NAME:=_build/cl-config
LISP:=qlot exec ros run
PREFIX:=$(HOME)/bin

build: clean
	$(LISP) \
	  --eval "(ql:quickload 'asdf)" \
		--eval '(asdf:load-asd "$(PWD)/cl-config.asd")' \
		--eval '(ql:quickload :cl-config)' \
		--quit

check: test

test:
	$(LISP) --non-interactive \
	  --eval "(ql:quickload 'asdf)" \
		--eval '(asdf:load-asd "$(PWD)/cl-config.asd")' \
	  --eval '(ql:quickload :cl-config/tests)' \
		--eval '(asdf:test-system :cl-config)' \
		--quit

shell:
	rlwrap $(LISP) --eval "(ql:quickload 'asdf)" \
		--eval '(asdf:load-asd "$(PWD)/cl-config.asd")' \
    --eval '(ql:quickload :cl-config)'
