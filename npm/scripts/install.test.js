const test = require("node:test");
const assert = require("node:assert/strict");

const {
  getPlatformSpec,
  getArchiveName,
  getBinaryName,
} = require("./install.js");

test("selects the Windows archive and executable for win32", () => {
  const spec = getPlatformSpec("win32", "x64");

  assert.deepEqual(spec, { platform: "windows", arch: "amd64", extension: "zip" });
  assert.equal(getArchiveName("dce-v0.0.3-windows-amd64", spec), "dce-v0.0.3-windows-amd64.zip");
  assert.equal(getBinaryName(spec), "dce.exe");
});

test("keeps the Unix tarball and executable naming", () => {
  const spec = getPlatformSpec("darwin", "arm64");

  assert.deepEqual(spec, { platform: "darwin", arch: "arm64", extension: "tar.gz" });
  assert.equal(getArchiveName("dce-v0.0.3-darwin-arm64", spec), "dce-v0.0.3-darwin-arm64.tar.gz");
  assert.equal(getBinaryName(spec), "dce");
});
