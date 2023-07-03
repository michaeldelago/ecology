(defpackage cl-config
  (:use :cl))
(in-package :cl-config)

(defmacro defconfig ((&key (accessor-prefix 'config-) (auto-initialize t)) &rest configs)
  "Defines a configuration specification"
 `(progn
    (defstruct (global-configuration (:conc-name ',accessor-prefix))
      ,@(loop for config in configs
              collect (init-config config)))
    (and ,auto-initialize
         (make-global-configuration))))

(defun init-config (config)
  (destructuring-bind (name &key env (typefun (lambda (x) x)))
      config
    `(,name (funcall ,typefun (when ',env
             (uiop:getenv ,(make-env-var name)))))))

(defun make-env-var (name)
  (cond ((symbolp name) (string-upcase (substitute #\_ #\- (string name))))
        ((stringp name) name)))
