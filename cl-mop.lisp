;;;; cl-mop.lisp

(in-package #:cl-mop)

;;;;;;;;;;;;;;; basic operations
(defmethod slot-names ((object standard-object))
  (slot-names (class-of object)))

(defmethod slot-names ((class standard-class))
  (mapcar #'slot-definition-name (class-slots class)))

(defgeneric map-slots (function instance)
  (:documentation "Takes a binary function and an instance.
Returns the sequence resulting from calling the function on each bound (slot-name slot-value) of instance"))

(defmethod map-slots ((fn function) (instance standard-object))
  "The default case of map-slots specializes on STANDARD-OBJECT."
  (loop for slot in (class-slots (class-of instance))
	for slot-name = (slot-definition-name slot)
	when (slot-boundp instance slot-name)
	  collect (funcall fn slot-name (slot-value instance slot-name))))

;;;;;;;;;;;;;;; copying functions
;;;;; shallow
(defgeneric shallow-copy (object)
  (:documentation "Provides a general shallow-copy function for CLOS objects. If you've got a special case, write a new defmethod."))

(defmethod shallow-copy ((object standard-object))
  "The default shallow copy specializes on STANDARD-OBJECT. It takes an object and returns a shallow copy."
  (let ((copy (allocate-instance (class-of object))))
    (map-slots 
     (lambda (k v) (setf (slot-value copy k) v))
     object)
    copy))

;;;;; deep
(defgeneric deep-copy (object)
  (:documentation "Does a general deep-copy on the given object and sub-pieces.
Returns atoms, numbers and chars. 
Runs copy-tree on lists, and copy-seq on other sequences.
Runs copy-structure on pathnames, hash tables and other structure-objects"))

(defmethod deep-copy (object)
  "The default unspecialized case should only catch atoms, numbers and characters.
It merely returns its results."
  object)

(defmethod deep-copy ((object standard-object))
  "The default deep copy specializes on STANDARD-OBJECT. It takes an object and returns a deep copy."
  (let ((copy (allocate-instance (class-of object))))
    (map-slots 
     (lambda (k v) (setf (slot-value copy k) (deep-copy v))) 
     object)
    copy))

(defmethod deep-copy ((object sequence))
  "A deep copy of a general sequence is merely (copy-seq sequence)."
  (copy-seq object))

(defmethod deep-copy ((object list))
  "A deep copy of a list is (copy-tree list)"
  (copy-tree object))

(defmethod deep-copy ((object structure-object))
  "A deep copy of a structure-object is (copy-structure object)."
  (copy-structure object))