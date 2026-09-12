# typed: strict
# frozen_string_literal: true

# 开头这两条魔法注释顺序固定，且都是 `brew style --cask` 的硬要求：
# Sorbet 的 `# typed:` 必须在第一行（2026-09-10 brew 升级后新增，
# 缺了判 offense），`frozen_string_literal` 紧随其后（2026-09-06 那次
# 加的，见下）。判据以 `HOMEBREW_DEVELOPER=1 brew style --cask --fix`
# 的输出为准——手猜顺序会越改越多，本文件因此被卡过两次。

# 第一行必须是这条魔法注释：Homebrew 2026-09-06 起（brew core 29b882c90e
# 之后）对独立 cask 文件也套 RuboCop 的 Style/FrozenStringLiteralComment，
# 缺了它 `brew style --cask` 直接判 offense，render_homebrew_cask 会 die，
# 把整个 ship 卡在最后一步（产物已全部构建完）。
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
  version "0.40.27"
  sha256 "0233c69b1cc7c6b587382910feccaa20961d32ec5d37e0b58937f2d7163ec4de"

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
  depends_on arch: :arm64
  depends_on macos: :ventura

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
  manpage "#{appdir}/婉儿.app/Contents/Resources/share/man/man1/waner-provider.1"
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
end
