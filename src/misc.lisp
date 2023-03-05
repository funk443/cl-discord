;; Copyright (C) 2023  CToID

;; This file is part of cl-discord

;; cl-discord is free software: you can redistribute it and/or modify
;; it under the terms of the GNU Affero General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; cl-discord is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU Affero General Public License for more details.

;; You should have received a copy of the GNU Affero General Public License
;; along with cl-discord.  If not, see <https://www.gnu.org/licenses/>.

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
