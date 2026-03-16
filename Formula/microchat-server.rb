class MicrochatServer < Formula
  desc "Lightweight self-hosted chat server with Nostr-style authentication"
  homepage "https://github.com/EwenQuim/microchat"
  url "https://github.com/EwenQuim/microchat/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4d7f65c8b15d0654677c5b2e2b35f6a7dd87281d6f0a50ef34c2d3cda79b4fe3"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/microchat-server"
  end

  test do
    assert_match "microchat-server", shell_output("#{bin}/microchat-server --help 2>&1", 1)
  end
end
