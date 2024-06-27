class Entropy < Formula
  desc "This CLI tool scans your files for high entropy lines, which are often secrets"
  homepage "https://github.com/EwenQuim/entropy"
  url "https://github.com/EwenQuim/entropy/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "b6bf71ecd7ece64684313dacb2093d5cccfc7d338a4173837a255111659de5fe"
  license "MIT"
  
  depends_on "go" => :build
  
  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end
  
  test do
    (testpath/"high_entropy.txt").write <<~EOS
    normal line not a secret
    2d931510-d99f-494a-8c67-87feb05e1594
    another line
    EOS
  
    output = shell_output("#{bin}/entropy --top 1 #{testpath}/high_entropy.txt")
    expected = "high_entropy.txt:2 2d931510-d99f-494a-8c67-87feb05e1594"
  
    assert_match expected, output
  end
end
