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
