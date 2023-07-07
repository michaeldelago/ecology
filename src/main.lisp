(defpackage ecology
  (:use :cl)
  (:export #:defconfig))

(in-package :ecology)

(defun make-env-var (name)
  "Creates an environment variable from a symbol or string. Strings become upcased and dashes are substituted to underscores."
  (string-upcase
    (substitute #\_ #\-
                (if (symbolp name)
                    (string name)
                    name))))

(defun symbol-append (&rest symbols)
  "Helper function to concat symbols"
  (intern (apply #'concatenate 'string (mapcar #'symbol-name symbols))))

(defun init-config (prefix config)
  "Returns a DEFUN form for the parameter set given to it. Intended to be used within defconfig. The PREFIX argument will pre-pend that prefix to the CAR of the CONFIG argument, and that's the name of the function."
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
              (list 'funcall key config-value))))))

(defmacro defconfig ((&key (prefix 'config-)) &rest configs)
  "Defines a configuration specification. Each configuration parameter is exposed as a function that will execute the command to grab the configuration"
  `(progn
    ,@(loop for config in configs
            collect (init-config prefix config))))