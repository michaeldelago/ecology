(defpackage cl-config/tests/main
  (:use :cl
        :cl-config
        :rove))
(in-package :cl-config/tests/main)


(setup
  (defconfig nil
    (home :env "HOME")
    (unset-var :env "doesnt-exist" :default "default-value")))

(deftest env-vars 
  (testing "Able to grab configuration from an environment variable"
    (ok (equalp (uiop:getenvp "HOME") (config-home))))
  (testing "default values are resolved if env var is not found"
    (ok (equalp "default-value" (config-unset-var)))))
