class Mr < Formula
  desc "Multiple Repository management tool"
  homepage "https://myrepos.branchable.com/"
  url "git://myrepos.branchable.com/",
      tag:      "1.20180726",
      revision: "0ad7a17bb455de1fec3b2375c7aac72ab2a22ac4"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    sha256 cellar: :any_skip_relocation, all: "028ddae368f2d35962c98a20da7317f07aec39b167255aa7fc1b30fb004c9fb1"
  end

  # Use brewed pod2man to ensure consistent output between platforms
  depends_on "pod2man" => :build

  uses_from_macos "perl"

  resource("test-repo") do
    url "https://github.com/Homebrew/homebrew-command-not-found.git"
  end

  def install
    # Don't include the perl version in the manpage since it may differ over time
    inreplace "Makefile", "pod2man", "pod2man -r \"\""

    system "make"
    bin.install "mr", "webcheckout"

    # Don't include the pod2man version in the manpage since it may differ over time
    inreplace %w[mr.1 webcheckout.1], /^\.\\" Automatically generated by.*$/, ""

    man1.install Utils::Gzip.compress("mr.1", "webcheckout.1")
    pkgshare.install Dir["lib/*"]
  end

  test do
    resource("test-repo").stage do
      system bin/"mr", "register"
      assert_match(/^mr status: #{Dir.pwd}$/, shell_output("#{bin}/mr status"))
    end
  end
end

