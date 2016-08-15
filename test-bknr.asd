#|
  This file is a part of test-bknr project.
|#

(in-package :cl-user)
(defpackage test-bknr-asd
  (:use :cl :asdf))
(in-package :test-bknr-asd)

(defsystem test-bknr
  :version "0.1"
  :author ""
  :license ""
  :depends-on (:bknr.data.impex :bknr.datastore :cl-html-parse)
  :components ((:module "src"
                :components
                ((:file "test-bknr"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op test-bknr-test))))
