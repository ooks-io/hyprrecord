DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
DATAROOTDIR ?= $(PREFIX)/share
BINDIR ?= $(EXEC_PREFIX)/bin


install: zellijmenu
	@install -v -D -m 0755 zellijmenu --target-directory "$(BINDIR)"

uninstall: zellijmenu
	rm "$(BINDIR)/zellijmenu"
