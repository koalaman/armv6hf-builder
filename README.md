## armv6hf-builder

This is the Docker container that builds ShellCheck for armv6hf, i.e. Raspberry Pi.

It was a huge pain to get GHC cross-compiling for armv6, so this container
actually invokes a complete Raspbian in qemu ARM user emulation mode. Thanks to
Resin for setting up an image where this is simple to do.

As an additional improvement, all libraries are compiled with `-Os`
and `-split-sections` to reduce the otherwise huge size of the binary.

The docker container takes hours to build since ARM emulation of GHC is
understandably slow. ShellCheck dependencies are therefore compiled in advance.

