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
  (:export #:slot-names #:map-slots 
	   #:shallow-copy #:deep-copy))

