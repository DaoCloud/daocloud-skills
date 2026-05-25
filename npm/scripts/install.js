const fs = require("fs");
const path = require("path");
const { execFileSync } = require("child_process");
const os = require("os");
const crypto = require("crypto");

const VERSION = require("../package.json").version;
const REPO = "DaoCloud/daocloud-skills";
const NAME = "dc";
const ALLOWED_HOSTS = new Set([
  "github.com",
  "objects.githubusercontent.com",
]);

const PLATFORM_MAP = {
  darwin: "darwin",
  linux: "linux",
};

const ARCH_MAP = {
  x64: "amd64",
  arm64: "arm64",
};

const platform = PLATFORM_MAP[process.platform];
const arch = ARCH_MAP[process.arch];

const TAG = `v${VERSION}`;
const PKG_NAME = `${NAME}-${TAG}-${platform}-${arch}`;
const archiveName = `${PKG_NAME}.tar.gz`;
const GITHUB_URL = `https://github.com/${REPO}/releases/download/${TAG}/${archiveName}`;

const pkgRoot = path.join(__dirname, "..");
const binDir = path.join(pkgRoot, "bin");
const dest = path.join(binDir, NAME);

function assertAllowedHost(url) {
  const { hostname } = new URL(url);
  if (!ALLOWED_HOSTS.has(hostname)) {
    throw new Error(`Download host not allowed: ${hostname}`);
  }
}

function download(url, destPath) {
  assertAllowedHost(url);
  execFileSync(
    "curl",
    [
      "--fail", "--location", "--silent", "--show-error",
      "--connect-timeout", "10", "--max-time", "120",
      "--max-redirs", "3",
      "--output", destPath,
      url,
    ],
    { stdio: ["ignore", "ignore", "pipe"] }
  );
}

function getExpectedChecksum(name) {
  const checksumsPath = path.join(pkgRoot, "checksums.txt");
  if (!fs.existsSync(checksumsPath)) {
    throw new Error(
      "[SECURITY] checksums.txt not found; refusing to install without integrity verification"
    );
  }
  const content = fs.readFileSync(checksumsPath, "utf8");
  for (const line of content.split("\n")) {
    const trimmed = line.trim();
    if (!trimmed) continue;
    const idx = trimmed.indexOf("  ");
    if (idx === -1) continue;
    const hash = trimmed.slice(0, idx);
    const entry = trimmed.slice(idx + 2);
    if (entry === name) return hash;
  }
  throw new Error(`Checksum entry not found for ${name}`);
}

function verifyChecksum(archivePath, expectedHash) {
  const hash = crypto.createHash("sha256");
  const fd = fs.openSync(archivePath, "r");
  try {
    const buf = Buffer.alloc(64 * 1024);
    let bytesRead;
    while ((bytesRead = fs.readSync(fd, buf, 0, buf.length, null)) > 0) {
      hash.update(buf.subarray(0, bytesRead));
    }
  } finally {
    fs.closeSync(fd);
  }
  const actual = hash.digest("hex");
  if (actual.toLowerCase() !== expectedHash.toLowerCase()) {
    throw new Error(
      `[SECURITY] Checksum mismatch for ${path.basename(archivePath)}: expected ${expectedHash} but got ${actual}`
    );
  }
}

function install() {
  fs.mkdirSync(binDir, { recursive: true });

  const tmpDir = fs.mkdtempSync(path.join(os.tmpdir(), `${NAME}-`));
  const archivePath = path.join(tmpDir, archiveName);

  try {
    download(GITHUB_URL, archivePath);

    const expected = getExpectedChecksum(archiveName);
    verifyChecksum(archivePath, expected);

    execFileSync("tar", ["-xzf", archivePath, "-C", tmpDir], { stdio: "ignore" });

    const extractedRoot = path.join(tmpDir, PKG_NAME);
    const extractedBinary = path.join(extractedRoot, NAME);

    fs.copyFileSync(extractedBinary, dest);
    fs.chmodSync(dest, 0o755);

    console.log(`${NAME} ${TAG} installed successfully`);
  } finally {
    fs.rmSync(tmpDir, { recursive: true, force: true });
  }
}

if (require.main === module) {
  if (!platform || !arch) {
    console.error(`Unsupported platform: ${process.platform}-${process.arch}`);
    process.exit(1);
  }

  // Under `npx`, postinstall fires but the binary is not yet needed —
  // run.js triggers install() on demand with DC_RUN=1 set.
  const isNpxPostinstall =
    process.env.npm_command === "exec" && !process.env.DC_RUN;
  if (isNpxPostinstall) process.exit(0);

  try {
    install();
  } catch (err) {
    console.error(`Failed to install ${NAME}:`, err.message);
    process.exit(1);
  }
}

module.exports = { getExpectedChecksum, verifyChecksum, assertAllowedHost };
