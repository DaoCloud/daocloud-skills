#!/usr/bin/env node

const { execFileSync } = require("child_process");
const fs = require("fs");
const path = require("path");

const bin = path.join(__dirname, "..", "bin", "dce");
const args = process.argv.slice(2);

if (!fs.existsSync(bin)) {
  try {
    execFileSync(process.execPath, [path.join(__dirname, "install.js")], {
      stdio: "inherit",
      env: { ...process.env, DCE_RUN: "true" },
    });
  } catch (_) {
    console.error(
      `\nFailed to auto-install dce binary.\n` +
      `Run the install script manually:\n` +
      `  node "${path.join(__dirname, "install.js")}"\n`
    );
    process.exit(1);
  }
}

try {
  execFileSync(bin, args, { stdio: "inherit" });
} catch (e) {
  process.exit(e.status || 1);
}
