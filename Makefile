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
	$(call println,\\x1b[1mRunning Stekovaya...\\x1b[m)
	@clear

install:
	@/bin/echo -e -n \\x1b[1mInstalling Stekovaya...\\x20\\x20\\x20
	@wget https://repl.it/@stekovaya/Stekovaya.zip -q
	@unzip -q -o -d stekovaya Stekovaya.zip "stkvy.exe" "DOCS.md" "LICENSE" "_version"
	@rm Stekovaya.zip
	@/bin/echo -e done. \(v`cat stekovaya/_version`\)\\x1b[m
	@rm stekovaya/_version

run:
	@mono stekovaya/stkvy.exe main.stk
	
license:
	@if [ ! -e stekovaya/LICENSE ] ; then make install ; fi
ifeq ($(OPT),legalcode)
	@cat stekovaya/LICENSE
else
ifeq ($(OPT),name)
	@echo CC-BY-ND 4.0
else
	@echo Unknown option. Stop.
	@exit 1
endif
endif

clean:
	@rm -r stekovaya
	
help:
	$(call unicode,1B)
	$(call println,[1mHelp v1.0)
	$(call unicode,1B[m)
	$(call println,Usage: make [args...])
	$(call println,args:)
	$(call println,\\x09No args: Install Stekovaya and run Stekovaya.)
	$(call println,\\x09install: Install Stekovaya.)
	$(call println,\\x09run    : Run Stekovaya.)
	$(call println,\\x09license: Display about license info.)
	$(call println,\\x09         Need OPT=legalcode/name)
	$(call println,\\x09clean  : Uninstall Stekovaya.)
