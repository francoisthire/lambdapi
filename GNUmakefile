VIMDIR     = $(HOME)/.vim
.PHONY: all
all: bin

#### Targets #################################################################

.PHONY: help
help:
	@cat MAKEFILE.md

#### Compilation #############################################################

LPBIN=_build/install/default/bin/lambdapi
.PHONY: bin
bin:
	dune build

#### Documentation ###########################################################

.PHONY: doc
doc:
	dune build @doc

#### Unit tests ##############################################################

OK_TESTFILES = $(sort $(wildcard tests/OK/*.*))
KO_TESTFILES = $(sort $(wildcard tests/KO/*.*))
TESTFILES    = $(sort $(wildcard examples/*.*))
TESTPROOFS   = $(sort $(wildcard proofs/*.lp))

.PHONY: tests
tests: bin
	@printf "## OK tests ##\n"
	@for file in $(OK_TESTFILES) ; do \
		$(LPBIN) --verbose 0 $$file 2> /dev/null \
		&& printf "\033[32mOK\033[0m $$file\n" \
	  || { printf "\033[31mKO\033[0m $$file\n" \
		&& $(LPBIN) --verbose 0 $$file ; } ; \
	done
	@printf "## KO tests ##\n"
	@for file in $(KO_TESTFILES) ; do \
		$(LPBIN) --verbose 0 $$file 2> /dev/null \
		&& printf "\033[31mOK\033[0m $$file\n" \
		|| printf "\033[32mKO\033[0m $$file\n" ; \
	done
	@printf "## Examples ##\n"
	@for file in $(TESTFILES) ; do \
		$(LPBIN) --verbose 0 $$file 2> /dev/null \
	  && printf "\033[32mOK\033[0m $$file\n" \
	  || { printf "\033[31mKO\033[0m $$file\n" \
		&& $(LPBIN) --verbose 0 $$file ; } ; \
	done
	@printf "## Proofs   ##\n"
	@for file in $(TESTPROOFS) ; do \
		$(LPBIN) --verbose 0 $$file 2> /dev/null \
	  && printf "\033[32mOK\033[0m $$file\n" \
	  || { printf "\033[31mKO\033[0m $$file\n" \
		&& $(LPBIN) --verbose 0 $$file ; } ; \
	done

.PHONY: real_tests
real_tests: bin
	@printf "## OK tests ##\n"
	@for file in $(OK_TESTFILES) ; do \
		$(LPBIN) --verbose 0 $$file 2> /dev/null \
		&& printf "\033[32mOK\033[0m $$file\n" \
	  || { printf "\033[31mKO\033[0m $$file\n" \
		&& $(LPBIN) --verbose 0 $$file ; exit 1 ; } ; \
	done
	@printf "## KO tests ##\n"
	@for file in $(KO_TESTFILES) ; do \
		$(LPBIN) --verbose 0 $$file 2> /dev/null \
		&& { printf "\033[31mOK\033[0m $$file\n" ; exit 1 ; } \
		|| printf "\033[32mKO\033[0m $$file\n" ; \
	done
	@printf "## Examples ##\n"
	@for file in $(TESTFILES) ; do \
		$(LPBIN) --verbose 0 $$file 2> /dev/null \
	  && printf "\033[32mOK\033[0m $$file\n" \
	  || { printf "\033[31mKO\033[0m $$file\n" \
		&& $(LPBIN) --verbose 0 $$file ; exit 1 ; } ; \
	done
	@printf "## Proofs   ##\n"
	@for file in $(TESTPROOFS) ; do \
		$(LPBIN) --verbose 0 $$file 2> /dev/null \
	  && printf "\033[32mOK\033[0m $$file\n" \
	  || { printf "\033[31mKO\033[0m $$file\n" \
		&& $(LPBIN) --verbose 0 $$file ; exit 1 ; } ; \
	done

#### Library tests ###########################################################

.PHONY: matita
matita: bin
	@printf "## Compiling the Matita's arithmetic library ##\n"
	@cd libraries && ./matita.sh

.PHONY: plein_de_dks
plein_de_dks: bin
	@printf "## Compiling “plein de dks” ##\n"
	@cd libraries && ./plein_de_dks.sh

.PHONY: focalide
focalide: bin
	@printf "## Compiling focalide library ##\n"
	@cd libraries && ./focalide.sh

.PHONY: holide
holide: bin
	@printf "## Compiling holide library ##\n"
	@cd libraries && ./holide.sh

.PHONY: verine
verine: bin
	@printf "## Compiling verine library ##\n"
	@cd libraries && ./verine.sh

.PHONY: iprover
iprover: bin
	@printf "## Compiling iProverModulo library ##\n"
	@cd libraries && ./iprover.sh

.PHONY: dklib
dklib: bin
	@printf "## Compiling the dklib library ##\n"
	@cd libraries && ./dklib.sh

.PHONY: zenon_modulo
zenon_modulo: bin
	@printf "## Compiling the zenon library ##\n"
	@cd libraries && ./zenon_modulo.sh

#### Cleaning targets ########################################################

.PHONY: clean
clean:
	dune clean

.PHONY: distclean
distclean: clean
	@cd libraries && ./matita.sh clean
	@cd libraries && ./plein_de_dks.sh clean
	@cd libraries && ./focalide.sh clean
	@cd libraries && ./holide.sh clean
	@cd libraries && ./verine.sh clean
	@cd libraries && ./iprover.sh clean
	@cd libraries && ./dklib.sh clean
	@cd libraries && ./zenon_modulo.sh clean
	@find . -type f -name "*~" -exec rm {} \;
	@find . -type f -name "*.dko" -exec rm {} \;

.PHONY: fullclean
fullclean: distclean
	@cd libraries && ./matita.sh fullclean
	@cd libraries && ./plein_de_dks.sh fullclean
	@cd libraries && ./focalide.sh fullclean
	@cd libraries && ./holide.sh fullclean
	@cd libraries && ./verine.sh fullclean
	@cd libraries && ./iprover.sh fullclean
	@cd libraries && ./dklib.sh fullclean
	@cd libraries && ./zenon_modulo.sh fullclean

#### Installation targets ####################################################

.PHONY: install
install:
	dune install

.PHONY: uninstall
uninstall:
	dune uninstall

# Install for the vim mode (in the user's directory).
.PHONY: install_vim
install_vim: $(wildcard editors/vim/*/*.vim)
ifeq ($(wildcard $(VIMDIR)/.),)
	@printf "\e[36mWill not install vim mode.\e[39m\n"
else
	install -d $(VIMDIR)/syntax
	install -d $(VIMDIR)/ftdetect
	install -m 644 editors/vim/syntax/dedukti.vim    $(VIMDIR)/syntax
	install -m 644 editors/vim/syntax/lambdapi.vim   $(VIMDIR)/syntax
	install -m 644 editors/vim/ftdetect/dedukti.vim  $(VIMDIR)/ftdetect
	install -m 644 editors/vim/ftdetect/lambdapi.vim $(VIMDIR)/ftdetect
	@printf "\e[36mVim mode installed.\e[39m\n"
endif

opam-release:
	dune-release distrib
	dune-release opam pkg
