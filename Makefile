.SILENT: all

define printf
	@/bin/echo -e -n "${1}"
endef

define println
 @/bin/echo -e "${1}"
endef

define unicode
	@/bin/echo -e -n \\x${1}
endef

all: install cls run

cls:
	$(call println,\\x1b[1mRunning Obratnaya...\\x1b[m)
	@clear

install:
	@/bin/echo -e -n \\x1b[1mInstalling Obratnaya...\\x20\\x20\\x20
	@wget https://repl.it/@obratnaya/Obratnaya.zip -q
	@unzip -q -o -d obratnaya Obratnaya.zip "obrya.exe" "DOCS.md" "LICENSE"
	@rm Obratnaya.zip
	@/bin/echo -e done.

run:
	@mono obratnaya/obrya.exe main.oba
	
license:
	@if [ ! -e obratnaya/LICENSE ] ; then make install ; fi
ifeq ($(OPT),legalcode)
	@cat obratnaya/LICENSE
else
ifeq ($(OPT),name)
	@echo CC-BY-ND 4.0
else
	@echo Unknown option. Stop.
	@exit 1
endif
endif

clean:
	@rm -r obratnaya
	
help:
	$(call unicode,1B)
	$(call println,[1mHelp v1.0)
	$(call unicode,1B[m)
	$(call println,Usage: make [args...])
	$(call println,args:)
	$(call println,\\x09No args: Install Obratnaya and run Obratnaya.)
	$(call println,\\x09install: Install Obratnaya.)
	$(call println,\\x09run    : Run Obratnaya.)
	$(call println,\\x09license: Display about license info.)
	$(call println,\\x09         Need OPT=legalcode/name)
	$(call println,\\x09clean  : Uninstall Obratnaya.)
