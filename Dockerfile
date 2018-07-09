# This image compiles ShellCheck for armv6hf aka Raspberry Pi.
#
# It does this by emulating the entire Raspbian userland, because
# that was way easier than trying to build a functioning armv6hf
# cross-compiler.

FROM resin/rpi-raspbian:stretch
RUN ["cross-build-start"]
ENTRYPOINT ["/bin/sh"]
WORKDIR /mnt

# Install build dependencies
RUN apt-get update
RUN apt-get -y install ghc cabal-install

# GHC creates huge ARM binaries. Compile them all with -Os.
COPY cabal-config /root/.cabal/config

# Emulated compilation is very slow. Precompile dependencies.
RUN cabal update
RUN cabal install aeson bytestring containers mtl parsec regex-tdfa

COPY compile-shellcheck /usr/bin/
