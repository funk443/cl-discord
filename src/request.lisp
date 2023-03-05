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

(DEFPACKAGE :CL-DISCORD.REQUEST
  (:NICKNAMES :CD.REQUEST)
  (:USE :CL)
  (:EXPORT :MAKE-REQUEST))
(IN-PACKAGE :CD.REQUEST)

(DEFPARAMETER +BASE-URL+ "https://discord.com/api/v10")

(DEFUN MAKE-REQUEST (URL &KEY (METHOD :GET) HEADERS CONTENT)
  (UNLESS (CD.MISC:ALIST-GET "User-Agent" HEADERS)
    (PUSH `("User-Agent" . ,(FORMAT NIL "DiscordBot (~A, ~A)"
                                    "https://github.com/funk443/cl-discord"
                                    "0.0.1"))
          HEADERS))
  (UNLESS (CD.MISC:ALIST-GET "Authorization" HEADERS)
    (PUSH `("Authorization" . ,(FORMAT NIL "Bot ~A"
                                       (CD.BOT:TOKEN
                                        CD.BOT:*CURRENT-BOT*)))
          HEADERS))
  (MULTIPLE-VALUE-BIND (BODY STATUS RESPONSE-HEADERS URI STREAM)
      (DEX:REQUEST (FORMAT NIL "~A~A" +BASE-URL+ URL)
                   :METHOD METHOD
                   :HEADERS HEADERS
                   :CONTENT CONTENT)
    (VALUES (JONATHAN:PARSE BODY :AS :ALIST)
            STATUS
            RESPONSE-HEADERS
            URI
            STREAM)))
