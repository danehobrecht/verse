# The location of the verses
VERSE_LIB = debian/verse/usr/share/verse/
VERSE_NAME = daily.verse
BIN_DIR = debian/verse/usr/bin
CFLAGS = -Wall -g -O2 --std=c99 $(shell dpkg-buildflags --get CFLAGS)
CPPFLAGS = $(shell dpkg-buildflags --get CPPFLAGS)
LDFLAGS = $(shell dpkg-buildflags --get LDFLAGS)
MAN_DIR = debian/verse/usr/share/man/man1
CC ?= gcc

all : verse

clean :
	rm -f verse *~

distclean : clean

verse : verse.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -DVERSE_LIB=\"$(VERSE_LIB)$(VERSE_NAME)\" -o verse verse.c

install : verse $(VERSE_NAME)
	install -m 755 -d $(BIN_DIR)
	install -m 755 verse $(BIN_DIR)
	install -m 755 -d $(VERSE_LIB)
	install -m 644 $(VERSE_NAME) $(VERSE_LIB)$(VERSE_NAME)
	install -m 755 -d $(MAN_DIR)
	install -m 644 verse.1 $(MAN_DIR)

