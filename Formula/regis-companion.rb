class RegisCompanion < Formula
  desc "Command-line tool that provides advanced features for the Regis Mac App."
  homepage "https://github.com/harfangapps/regis-companion"
  url "https://github.com/harfangapps/regis-companion/archive/v0.0.11.tar.gz"
  sha256 "9d9ea2024861e2427a0fd1efbb33c6583cfa396cb2bd5713df4c578548bb2914"

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

  plist_options :manual => "regis-companion"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/regis-companion</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/regis-companion.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/regis-companion.log</string>
      </dict>
    </plist>
    EOS
  end

  test do
    system "#{bin}/regis-companion", "--version"
  end
end
