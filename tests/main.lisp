(defpackage ecology/tests/main
  (:use :cl
        :ecology
        :rove))
(in-package :ecology/tests/main)

(setup
  (defconfig nil
    (home :env "HOME")
    (unset-var :env "doesnt-exist" :default "default-value")
    (int-var :default "3" :key (lambda (x) (parse-integer x)))
    (kw-var :default "foo" :key (lambda (x) (intern (string-upcase x) :keyword)))
    (reference-var :default (* 2 (config-int-var)))))

(deftest env-vars 
  (testing "Able to grab configuration from an environment variable"
    (ok (equalp (uiop:getenvp "HOME") (config-home))))
  (testing "default values are resolved if env var is not found"
    (ok (equalp "default-value" (config-unset-var)))))

(deftest default-values
  (testing "Able to perform type conversions on config values with the :key param"
           (ok (eq 3 (config-int-var))))
  (testing "Able to type convert keyword arguments"
           (ok (eq :foo (config-kw-var))))
  (testing "Able to reference other variables"
           (ok (eq 6 (config-reference-var)))))

  
