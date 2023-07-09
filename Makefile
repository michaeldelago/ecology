NAME:=_build/ecology
LISP:=qlot exec ros run
PREFIX:=$(HOME)/bin

build: clean
	$(LISP) \
		--eval '(asdf:load-system :ecology)' \
		--quit

check: test

test:
	$(LISP) --non-interactive \
		--eval '(asdf:load-system :ecology)' \
		--eval '(asdf:test-system :ecology)' \
		--quit

shell:
	rlwrap $(LISP) \
		--eval '(asdf:load-system :ecology)'

# Install formatter with command:
# $(LISP) ros install hyotang666/trivial-formatter
fmt:
	$(LISP) --non-interactive \
		--eval '(asdf:load-system :trivial-formatter)' \
		--eval '(trivial-formatter:fmt :ecology :supersede)' \
		--quit
