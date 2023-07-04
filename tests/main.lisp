(defpackage cl-config/tests/main
  (:use :cl
        :cl-config
        :rove))
(in-package :cl-config/tests/main)


(setup
  (defconfig nil
    (home :env "HOME")
    (unset-var :env "doesnt-exist" :default "default-value")
    (kw-var :default "3" :key (lambda (x) (parse-integer x)))))

(deftest env-vars 
  (testing "Able to grab configuration from an environment variable"
    (ok (equalp (uiop:getenvp "HOME") (config-home))))
  (testing "default values are resolved if env var is not found"
    (ok (equalp "default-value" (config-unset-var))))
  (testing "Able to perform type conversions on config values with the :key param"
    (ok (eq 3 (config-kw-var)))))
