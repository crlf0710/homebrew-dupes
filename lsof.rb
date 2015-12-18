class Lsof < Formula
  homepage "http://people.freebsd.org/~abe/"
  url "ftp://sunsite.ualberta.ca/pub/Mirror/lsof/lsof_4.89.tar.bz2"
  mirror "http://mirror.jaredwhiting.net/distfiles/lsof_4.89.tar.bz2"
  sha256 "81ac2fc5fdc944793baf41a14002b6deb5a29096b387744e28f8c30a360a3718"

  def install
    ENV["LSOF_INCLUDE"] = "#{MacOS.sdk_path}/usr/include"

    system "tar", "xf", "lsof_#{version}_src.tar"

    cd "lsof_#{version}_src" do
      # Source hardcodes full header paths at /usr/include
      inreplace %w[dialects/darwin/kmem/dlsof.h dialects/darwin/kmem/machine.h
                   dialects/darwin/libproc/machine.h],
                "/usr/include", MacOS.sdk_path.to_s + "/usr/include"

      mv "00README", "../README"
      system "./Configure", "-n", "darwin"
      system "make"
      bin.install "lsof"
    end
  end
end
