PREFIX?=/usr
DESTDIR?=

GCC_BIN=`xcrun --sdk iphoneos --find gcc`
GCC_UNIVERSAL=$(GCC_BASE) -arch armv7 -arch armv7s -arch arm64
SDK=`xcrun --sdk iphoneos --show-sdk-path`

CFLAGS = 
#GCC_BASE = $(GCC_BIN) -Os $(CFLAGS) -Wimplicit -isysroot $(SDK) -F$(SDK)/System/Library/Frameworks -F$(SDK)/System/Library/PrivateFrameworks
GCC_BASE = $(GCC_BIN) -Os $(CFLAGS) -Wimplicit -Wl,-segalign,4000 -isysroot $(SDK) -F$(SDK)/System/Library/Frameworks -F$(SDK)/System/Library/PrivateFrameworks

all: dumpdecrypted.dylib

dumpdecrypted.dylib: dumpdecrypted.o 
	$(GCC_UNIVERSAL) -dynamiclib -o $@ $^

%.o: %.c
	$(GCC_UNIVERSAL) -c -o $@ $< 

clean:
	rm -f *.o dumpdecrypted.dylib

BINDIR=$(DESTDIR)$(PREFIX)/bin
LIBDIR=$(DESTDIR)$(PREFIX)/lib

install:
	mkdir -p $(BINDIR)
	cp -f dumpdecrypted.sh $(BINDIR)/dumpdecrypted
	chmod +x $(BINDIR)/dumpdecrypted
	mkdir -p $(LIBDIR)
	cp -f dumpdecrypted.dylib $(LIBDIR)
