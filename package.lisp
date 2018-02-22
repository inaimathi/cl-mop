;;;; package.lisp

(defpackage #:cl-mop
  (:use #:cl)
  (:shadowing-import-from
   #+openmcl-native-threads #:ccl
   #+cmu #:pcl
   #+sbcl #:sb-pcl
   #+lispworks #:hcl
   #+allegro #:mop
   #+clisp #:clos
   #:class-slots #:slot-definition-name)
  (:shadowing-import-from
   #+sbcl #:sb-mop
   #+clisp #:clos
   #+openmcl-native-threads #:ccl

   #:generic-function-methods
   #:method-specializers
   #:eql-specializer
   #:eql-specializer-object)
  (:export #:slot-names #:map-slots
	   #:to-alist
	   #:shallow-copy #:deep-copy
	   #:class-slots #:slot-definition-name

           #:methods-of #:specializers-of #:specializer-object #:specializer-objects-of))
