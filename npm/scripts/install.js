const fs = require("fs");
const path = require("path");
const { execFileSync } = require("child_process");
const https = require("https");
const os = require("os");
const crypto = require("crypto");

const VERSION = require("../package.json").version;
const REPO = "DaoCloud/daocloud-skills";
const NAME = "dce";
const ALLOWED_HOSTS = new Set([
  "github.com",
  "objects.githubusercontent.com",
  "release-assets.githubusercontent.com",
]);

const PLATFORM_MAP = {
  darwin: "darwin",
  linux: "linux",
  win32: "windows",
};

const ARCH_MAP = {
  x64: "amd64",
  arm64: "arm64",
};

function getPlatformSpec(platformName, archName) {
  const platform = PLATFORM_MAP[platformName];
  const arch = ARCH_MAP[archName];
  if (!platform || !arch) return undefined;
  return {
    platform,
    arch,
    extension: platformName === "win32" ? "zip" : "tar.gz",
  };
}

function getArchiveName(pkgName, spec) {
  return `${pkgName}.${spec.extension}`;
}

function getBinaryName(spec) {
  return spec.platform === "windows" ? "dce.exe" : "dce";
}

const platformSpec = getPlatformSpec(process.platform, process.arch);
const platform = platformSpec && platformSpec.platform;
const arch = platformSpec && platformSpec.arch;

const TAG = `v${VERSION}`;
const PKG_NAME = `${NAME}-${TAG}-${platform}-${arch}`;
const archiveName = platformSpec ? getArchiveName(PKG_NAME, platformSpec) : undefined;
const GITHUB_URL = `https://github.com/${REPO}/releases/download/${TAG}/${archiveName}`;

const pkgRoot = path.join(__dirname, "..");
const binDir = path.join(pkgRoot, "bin");
const dest = path.join(binDir, platformSpec ? getBinaryName(platformSpec) : NAME);

function assertAllowedHost(url) {
  const { hostname } = new URL(url);
  if (!ALLOWED_HOSTS.has(hostname)) {
    throw new Error(`Download host not allowed: ${hostname}`);
  }
}

function download(url, destPath, redirectCount = 0) {
  assertAllowedHost(url);
  if (redirectCount > 3) {
    return Promise.reject(new Error("Too many redirects while downloading release asset"));
  }

  return new Promise((resolve, reject) => {
    const request = https.get(url, { headers: { "User-Agent": "@daocloud-cli/dce" } }, (response) => {
      const status = response.statusCode || 0;
      const location = response.headers.location;
      if (status >= 300 && status < 400 && location) {
        response.resume();
        const nextUrl = new URL(location, url).toString();
        download(nextUrl, destPath, redirectCount + 1).then(resolve, reject);
        return;
      }
      if (status < 200 || status >= 300) {
        response.resume();
        reject(new Error(`Download failed with HTTP ${status}`));
        return;
      }

      const file = fs.createWriteStream(destPath);
      response.pipe(file);
      file.on("finish", () => file.close(resolve));
      file.on("error", (err) => {
        response.destroy();
        reject(err);
      });
      response.on("error", (err) => {
        file.destroy();
        reject(err);
      });
    });
    request.setTimeout(120000, () => request.destroy(new Error("Download timed out")));
    request.on("error", reject);
  });
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

function extractArchive(archivePath, tmpDir, spec) {
  if (spec.platform === "windows") {
    const quotePowerShell = (value) => `'${value.replace(/'/g, "''")}'`;
    const command = [
      "$ErrorActionPreference = 'Stop'",
      `Expand-Archive -LiteralPath ${quotePowerShell(archivePath)} -DestinationPath ${quotePowerShell(tmpDir)} -Force`,
    ].join("; ");
    execFileSync("powershell.exe", ["-NoProfile", "-NonInteractive", "-Command", command], {
      stdio: "ignore",
    });
    return;
  }
  execFileSync("tar", ["-xzf", archivePath, "-C", tmpDir], { stdio: "ignore" });
}

async function install() {
  fs.mkdirSync(binDir, { recursive: true });

  const tmpDir = fs.mkdtempSync(path.join(os.tmpdir(), `${NAME}-`));
  const archivePath = path.join(tmpDir, archiveName);

  try {
    await download(GITHUB_URL, archivePath);

    const expected = getExpectedChecksum(archiveName);
    verifyChecksum(archivePath, expected);

    extractArchive(archivePath, tmpDir, platformSpec);

    const extractedRoot = path.join(tmpDir, PKG_NAME);
    const binaryName = getBinaryName(platformSpec);
    const extractedBinary = path.join(extractedRoot, binaryName);

    fs.copyFileSync(extractedBinary, dest);
    if (platformSpec.platform !== "windows") fs.chmodSync(dest, 0o755);

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
  // run.js triggers install() on demand with DCE_RUN=1 set.
  const isNpxPostinstall =
    process.env.npm_command === "exec" && !process.env.DCE_RUN;
  if (isNpxPostinstall) process.exit(0);

  install().catch((err) => {
    console.error(`Failed to install ${NAME}:`, err.message);
    process.exit(1);
  });
}

module.exports = {
  getExpectedChecksum,
  verifyChecksum,
  assertAllowedHost,
  getPlatformSpec,
  getArchiveName,
  getBinaryName,
};
