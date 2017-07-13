class RegisCompanion < Formula
  desc "Command-line tool that provides advanced features for the Regis Mac App."
  homepage "https://github.com/harfangapps/regis-companion"
  url "https://github.com/harfangapps/regis-companion/archive/v0.0.7.tar.gz"
  sha256 "26de7a5898571dc72c3ffd942de5bf6d992e38e24eb3d53c2163985f9e0439b9"

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
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test regis-companion`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
