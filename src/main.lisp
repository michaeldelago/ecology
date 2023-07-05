(defpackage ecology
  (:use :cl)
  (:export #:defconfig))

(in-package :ecology)

(defun make-env-var (name)
  (string-upcase
    (substitute #\_ #\-
                (if (symbolp name)
                    (string name)
                    name))))

(defun symbol-append (&rest symbols)
  (intern (apply #'concatenate 'string (mapcar #'symbol-name symbols))))

(defun init-config (prefix config)
  (destructuring-bind
      (name &key (env nil) (default nil) key)
      config
    (let ((config-value
           `(or ,(when env
                   `(uiop:getenvp ,(make-env-var env)))
                ,(when default
                   default))))
      `(defun ,(symbol-append prefix name) ()
         ,(if (null key)
              config-value
              `(funcall ,key ,config-value))))))

(defmacro defconfig ((&key (prefix 'config-)) &rest configs)
  "Defines a configuration specification"
  `(progn
    ,@(loop for config in configs
            collect (init-config prefix config))))