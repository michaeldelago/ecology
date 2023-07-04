(defsystem "cl-config"
  :version "0.1.0"
  :author "Mike Delago"
  :license "bsd-0"
  :pathname "src/"
  :depends-on ()
  :components ((:file "main"))
  :description "12-factor application configuration in Common Lisp"
  :in-order-to ((test-op (test-op "cl-config/tests"))))

(defsystem "cl-config/tests"
  :author "Mike Delago"
  :license "bsd-0"
  :depends-on ("cl-config"
               "rove")
  :pathname "tests"
  :components ((:file "main"))
  :description "Test system for cl-config"
  :perform (test-op (op c) (symbol-call :rove :run c :style :spec)))
