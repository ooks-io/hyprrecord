DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
DATAROOTDIR ?= $(PREFIX)/share
BINDIR ?= $(EXEC_PREFIX)/bin
MANDIR ?= $(DATAROOTDIR)/man
MAN1DIR ?= $(MANDIR)/man1

all: hyprrecord.1

hyprrecord.1: hyprrecord.1.scd
	scdoc < $< > $@

install: hyprrecord.1 hyprrecord
	@install -v -D -m 0644 hyprrecord.1 --target-directory "$(MAN1DIR)"
	@install -v -D -m 0755 hyprrecord --target-directory "$(BINDIR)"

uninstall: hyprrecord.1 hyprrecord
	rm "$(MAN1DIR)/hyprrecord.1"
	rm "$(BINDIR)/hyprrecord"
