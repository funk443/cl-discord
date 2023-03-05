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

(DEFPACKAGE :CL-DISCORD.BOT
  (:NICKNAMES :CD.BOT)
  (:USE :CL)
  (:EXPORT :MAKE-BOT
           :*CURRENT-BOT*
           :TOKEN
           :SEQ
           :WS
           :HEARTBEAT
           :PRESENCE))
(IN-PACKAGE :CD.BOT)

(DEFVAR *CURRENT-BOT*)

(DEFCLASS DISCORD-BOT ()
  ((TOKEN
    :INITARG :TOKEN
    :INITFORM (ERROR "Must supply a token!")
    :READER TOKEN)
   (SEQ
    :INITFORM 0
    :ACCESSOR SEQ)
   (WS
    :ACCESSOR WS)
   (HEARTBEAT
    :ACCESSOR HEARTBEAT)
   (PRESENCE
    :INITARG :PRESENCE
    :ACCESSOR PRESENCE)))

(DEFUN MAKE-BOT (TOKEN &OPTIONAL (PRESENCE '("online" "Emacs" 0 :false)))
  (DECLARE (TYPE STRING TOKEN))
  (SETF *CURRENT-BOT* (MAKE-INSTANCE 'DISCORD-BOT :TOKEN TOKEN
                                                  :PRESENCE PRESENCE)))
