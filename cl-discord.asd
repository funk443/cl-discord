(ASDF:DEFSYSTEM "cl-discord"
  :DESCRIPTION "cl-discord: a Common Lisp discord library"
  :VERSION "0.0.1"
  :AUTHOR "CToID  <funk443@yandex.com>"
  :LICENSE "GNU Affero General Public License"
  :DEPENDS-ON (:JONATHAN :DEXADOR :WEBSOCKET-DRIVER :BORDEAUX-THREADS)
  :COMPONENTS ((:MODULE "src"
                :COMPONENTS
                ((:FILE "misc")
                 (:FILE "bot")
                 (:FILE "request")
                 (:FILE "gateway")))))
