(in-package :cl-user)
(defpackage #:test-bknr
  (:use #:cl #:bknr.datastore #:bknr.impex))

(in-package :test-bknr)

(defparameter *application-root*   (asdf:system-source-directory :test-bknr))

(defvar *tutorial-dtd*
  (cxml:parse-dtd-file "/home/knobo/epi.dtd"))

(defvar *tutorial-dtd-file* (merge-pathnames #p"epi.dtd" *application-root*))

(defun  business-parser (list)
  (format t "Business: ----------- ~s ------------~%" list)
  list)


(defclass shop ()
  ((name :initarg :name :reader shop-name :element "name")
   (location :initarg :location :reader shop-location :element "location")
   (image :initarg :image :reader shop-image :element "image")
   (intro :initarg :intro :reader shop-intro :element "intro")
   (bodytext :initarg :bodytext :reader shop-bodytext :element "bodytext")
   (phone :initarg :phone :reader shop-phone :element "phone")
   (fax :initarg :fax :reader shop-fax :element "fax")
   (slideshow :initarg :slideshow :reader shop-slideshow :element "slideshow")
   (business :initarg :business :reader shop-business :element "business" :parser #'business-parser)
   (productgroups :initarg :productgroups :reader shop-productgroups :element "productgroups")
   (brands :initarg :brands :reader shop-brands :element "brands")
   (floors :initarg :floors :reader shop-floors :element "floors"))
  (:metaclass bknr.impex:xml-class)
  (:dtd-name *tutorial-dtd-file*) ;; (:dtd-name "/home/knobo/epi.dtd") ;;   
  (:element "store"))

(defun parse-html (string)
  (format t "------------------------- Parse html ------------ ~s~%" string)
  (first (net.html.parser:parse-html string :parse-entities t))
  string)

(defclass line ()
  ((id :initarg :id :reader line-id :attribute "id" :parser #'parse-integer)
   (name :initarg :name :reader line-name :body t :parser #'parse-html)) ;; 
  (:metaclass bknr.impex:xml-class)
  (:dtd-name *tutorial-dtd-file*) ;; (:dtd-name "/home/knobo/epi.dtd") ;;   
  (:element "line"))

(defparameter *elements* nil)

(defun test ()
  (setf *elements*
        (bknr.impex:parse-xml-file (merge-pathnames "data.xml" *application-root*)
                                   (list (find-class 'shop) (find-class 'line))))
  (format t "Should print: ~s" "Klær, sko og tilbehør")
  (line-name (first (first (shop-business (first (getf (first (getf  *elements* :stores)) :store)))))))
