class RegisCompanion < Formula
  desc "Command-line tool that provides advanced features for the Regis Mac App."
  homepage "https://github.com/harfangapps/regis-companion"
  url "https://github.com/harfangapps/regis-companion/archive/v0.0.8.tar.gz"
  sha256 "c89c0bcce73bedb5c524520ca3c14279de7dadaaac47f140fc747c69ce2733b1"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOOS"] = "darwin"
    ENV["GOARCH"] = MacOS.prefer_64_bit? ? "amd64" : "386"

    (buildpath/"src/github.com/harfangapps").mkpath
    ln_s buildpath, "src/github.com/harfangapps/regis-companion"

    system "go", "build", "-ldflags",
           "-X github.com/harfangapps/regis-companion/server.Version=#{version}",
           "-o", bin/"regis-companion", "github.com/harfangapps/regis-companion"
  end

  test do
    system "#{bin}/regis-companion", "--version"
  end
end
