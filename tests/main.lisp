(defpackage cl-config/tests/main
  (:use :cl
        :cl-config
        :rove))
(in-package :cl-config/tests/main)

(setup
  (defconfig nil
    (home :env "HOME")
    (unset-var :env "doesnt-exist" :default "default-value")
    (int-var :default "3" :key (lambda (x) (parse-integer x)))
    (kw-var :default "foo" :key (lambda (x) (intern (string-upcase x) :keyword)))))

(deftest env-vars 
  (testing "Able to grab configuration from an environment variable"
    (ok (equalp (uiop:getenvp "HOME") (config-home))))
  (testing "default values are resolved if env var is not found"
    (ok (equalp "default-value" (config-unset-var))))
  (testing "Able to perform type conversions on config values with the :key param"
    (ok (eq 3 (config-int-var))))
  (testing "Able to type convert keyword arguments"
    (ok (eq :foo (config-kw-var)))))
