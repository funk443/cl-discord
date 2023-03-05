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
