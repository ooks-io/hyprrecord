DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
DATAROOTDIR ?= $(PREFIX)/share
BINDIR ?= $(EXEC_PREFIX)/bin


install: powermenu
	@install -v -D -m 0755 powermenu --target-directory "$(BINDIR)"

uninstall: powermenu
	rm "$(BINDIR)/powermenu"
