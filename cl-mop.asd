;;;; cl-mop.asd

(asdf:defsystem #:cl-mop
  :serial t
  :description "Simple, portable tools for dealing with CLOS objects."
  :author "Inaimathi <leo.zovic@example.com>"
  :license "Expat (MIT-style)"
  :components ((:file "package")
               (:file "cl-mop")))

