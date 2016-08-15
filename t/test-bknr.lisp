(in-package :cl-user)
(defpackage test-bknr-test
  (:use :cl
        :test-bknr
        :prove))
(in-package :test-bknr-test)

;; NOTE: To run this test file, execute `(asdf:test-system :test-bknr)' in your Lisp.

(plan nil)

;; blah blah blah.

(finalize)
