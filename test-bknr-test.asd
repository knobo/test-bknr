#|
  This file is a part of test-bknr project.
|#

(in-package :cl-user)
(defpackage test-bknr-test-asd
  (:use :cl :asdf))
(in-package :test-bknr-test-asd)

(defsystem test-bknr-test
  :author ""
  :license ""
  :depends-on (:test-bknr
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "test-bknr"))))
  :description "Test system for test-bknr"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
