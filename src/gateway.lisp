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

(DEFPACKAGE :CL-DISCORD.GATEWAY
  (:NICKNAMES :CD.GATEWAY)
  (:USE :CL)
  (:IMPORT-FROM :CD.MISC :STRING-CASE :ALIST-GET))
(IN-PACKAGE :CD.GATEWAY)

(DEFUN SEND-PAYLOAD (BOT OP DATA)
  (WSD:SEND (CD.BOT:WS BOT) (JONATHAN:TO-JSON `(("op" . ,OP)
                                                ("d" . ,DATA))
                                              :FROM :ALIST)))

(DEFUN SEND-HEARTBEAT (BOT)
  (SEND-PAYLOAD BOT 1 (CD.BOT:SEQ BOT)))

(DEFUN SEND-IDENTIFY (BOT)
  (SEND-PAYLOAD BOT 2 `(("token" . ,(CD.BOT:TOKEN BOT))
                        ("properties" . (("os" . "GNU/Linux")
                                         ("browser" . "cl-discord")
                                         ("device" . "cl-discord")))
                        ("presence" . ,(APPLY #'MAKE-PRESENCE
                                              (CD.BOT:PRESENCE BOT)))
                        ("intents" . 36361))))

(DEFUN MAKE-PRESENCE (STATUS NAME TYPE AFK)
  `(("since" . :null)
    ("activities" . ((("name" . ,NAME)
                      ("type" . ,TYPE))))
    ("status" . ,STATUS)
    ("afk" . ,AFK)))

(DEFUN MAKE-HEARTBEAT-THREAD (BOT INTERVAL)
  (SETF (CD.BOT:HEARTBEAT BOT)
        (SB-THREAD:MAKE-THREAD (LAMBDA ()
                                 (LOOP
                                   (SLEEP INTERVAL)
                                   (SEND-HEARTBEAT BOT)))
                               :NAME (FORMAT NIL "Heartbeat~A" BOT))))

(DEFUN CONNECT (BOT)
  (LET ((WS (SETF (CD.BOT:WS BOT)
                  (WSD:MAKE-CLIENT
                   "wss://gateway.discord.gg/?v=10&encoding=json"))))
    (WSD:ON :OPEN WS
            (LAMBDA ()
              (SLEEP 1)
              (SEND-HEARTBEAT BOT)
              (MAKE-HEARTBEAT-THREAD BOT 30)
              (SEND-IDENTIFY BOT)))
    (WSD:ON :MESSAGE WS
            (LAMBDA (MESSAGE &AUX (ALIST (JONATHAN:PARSE MESSAGE
                                                         :AS :ALIST)))
              (UNLESS (= (ALIST-GET "op" ALIST) 11)
                (SETF (CD.BOT:SEQ BOT) (ALIST-GET "s" ALIST)))
              (EVENTS (ALIST-GET "op" ALIST) ALIST)))
    (WSD:ON :CLOSE WS
            (LAMBDA (&KEY CODE REASON)
              (FORMAT T "~&Connection closed: [~A]~A~%" CODE REASON)
              (SB-THREAD:TERMINATE-THREAD (CD.BOT:HEARTBEAT BOT))))
    (WSD:START-CONNECTION WS)))

(DEFUN EVENTS (OP ALIST)
  (CASE OP
    (0 (STRING-CASE (ALIST-GET "t" ALIST)
                    ("READY"
                     (FORMAT T "~&Bot is connected and ready!~%"))
                    (T (FORMAT T "~S~%" (ALIST-GET "d" ALIST)))))
    (11 NIL)
    (T NIL)))
