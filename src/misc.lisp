(DEFPACKAGE :CL-DISCORD.MISC
  (:NICKNAMES :CD.MISC)
  (:USE :CL)
  (:EXPORT :ALIST-GET
           :STRING-CASE))
(IN-PACKAGE :CD.MISC)

(DEFUN ALIST-GET (KEY ALIST &AUX (RESULT (ASSOC (STRING KEY) ALIST
                                                :TEST #'STRING=)))
  (VALUES (CDR RESULT)
          RESULT))

(DEFMACRO STRING-CASE (KEYFORM &REST REST)
  (LET ((BODY (LOOP FOR I IN REST
                    IF (STRINGP (CAR I))
                      COLLECT `((STRING= ,KEYFORM ,(CAR I)) ,@(CDR I))
                    ELSE
                      COLLECT `(T ,@(CDR I)))))
    `(COND ,@BODY)))
