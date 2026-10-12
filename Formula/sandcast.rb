# The sandcast command — the account API's first caller (login, logout,
# account create, account verify, account delete). Head-only (P2, Q2, N4 as
# clarified 2026-10-11): the controller is private, so what this public tap
# publishes is this formula's text, not the command; the install fetches
# carteratl/sandcast-controller over ssh with the key the installer's agent
# holds. No release archive, no tag, no checksum: a tag or a release is a
# GitHub act the unit's stop list reserves. `branch:` is required of a git
# head by the Formula Cookbook.
class Sandcast < Formula
  desc "The sandcast command: a customer's terminal to the sandcast account API"
  homepage "https://sandcast.io"
  head "ssh://git@github.com/carteratl/sandcast-controller.git", branch: "main"
  license :cannot_represent

  depends_on "python@3.13"

  def install
    # One standard-library file; its shebang is rewritten to this formula's
    # Python so the command runs the same interpreter everywhere on the Mac.
    rewrite_shebang detected_python_shebang, "bin/sandcast"
    bin.install "bin/sandcast"
  end

  test do
    # The usage carries no envelope and exits 0; on a Mac there is no socket
    # to reach until the public door exists, so this is the whole test.
    assert_match "login", shell_output("#{bin}/sandcast --help")
  end
end
