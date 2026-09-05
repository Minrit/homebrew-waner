# waner.rb.tmpl — rendered by scripts/release-cli.sh's render_homebrew_cask
# into dist/release/v<version>/homebrew/Casks/waner.rb, then pushed to the
# Homebrew tap (Minrit/homebrew-waner, see WANER_HOMEBREW_TAP) by
# publish_homebrew_cask. Do not edit the rendered output by hand — edit this
# template and re-run `scripts/release-cli.sh build`.
#
# Placeholders substituted at render time:
#   @VERSION@   — product version (e.g. 0.36.0)
#   @SHA256@    — sha256 of the aarch64 DMG (waner-v<version>-aarch64-apple-darwin.dmg)
#   @MANPAGES@  — zero or more `manpage "..."` lines, one per *.1 under the
#                 app bundle's Contents/Resources/share/man/man1
#   @CAVEATS@   — empty, or an ad-hoc-signing caveats block when the build
#                 that produced this cask was unsigned (dist/release/v<ver>/.desktop-adhoc)
#
# `zap` deliberately does NOT remove `~/.waner` (embedded PostgreSQL data,
# config, credentials, installed skill/plugin state, per-version installer
# trees) nor `~/.local/bin/waner` (the CLI symlink `waner shell-setup`
# manages) — those are user data and installer-owned state, not app caches,
# and a cask uninstall/zap must not silently delete a user's memory or
# credentials.
cask "waner" do
  version "0.37.0"
  sha256 "c60a174e52634b36660211646fda97dfa2afb7814929dd7a28aab5d8c2d36826"

  url "https://cdn.zstack.io/product_downloads/Cloud_suite/AI/waner-v#{version}-aarch64-apple-darwin.dmg"
  name "婉儿 (Waner)"
  desc "Secure AI agent runtime with persistent memory and sandboxed extensions"
  homepage "https://cdn.zstack.io/product_downloads/Cloud_suite/AI/waner.html"

  livecheck do
    url "https://cdn.zstack.io/product_downloads/Cloud_suite/AI/waner-manifest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on macos: :ventura
  depends_on arch: :arm64

  app "婉儿.app"
  binary "#{appdir}/婉儿.app/Contents/Resources/waner-entry", target: "waner"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-channels.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-chat.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-config.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-doctor.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-gateway.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-gui.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-hooks.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-login.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-logs.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-man.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-mcp.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-memory.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-models.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-onboard.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-pairing.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-plugin.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-profile.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-query.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-registry.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-routines.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-run.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-shell-setup.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-skills.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-status.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-tool.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-tools.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-tui.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-update.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-worktree.1"
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner.1"

  uninstall quit: "com.zenova.waner-desktop"

  zap trash: [
    "~/.waner/gui",
    "~/Library/Saved Application State/com.zenova.waner-desktop.savedState",
  ]

  caveats <<~EOS
    本构建为 ad-hoc 签名（尚未通过 Apple 公证）。首次打开 婉儿.app 请右键 → 打开；
    若终端里的 waner 被 Gatekeeper 拦截，执行：
      xattr -dr com.apple.quarantine "#{appdir}/婉儿.app"
    或重新安装时加 --no-quarantine：brew reinstall --cask --no-quarantine waner
  EOS
end
