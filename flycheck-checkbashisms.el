;;; flycheck-checkbashisms.el --- checkbashisms intergrate with flycheck -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Cuong Le
;; All rights reserved.

;; Author: Cuong Le <cuong.manhle.vn@gmail.com>
;; Keywords: convenience, tools, sh, unix
;; Version: 1.0
;; URL: https://github.com/Gnouc/flycheck-checkbashisms
;; Package-Requires: ((emacs "24") (flycheck "0.25"))

;; This file is not part of GNU Emacs.

;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are
;; met:

;;     * Redistributions of source code must retain the above copyright
;;       notice, this list of conditions and the following disclaimer.

;;     * Redistributions in binary form must reproduce the above
;;       copyright notice, this list of conditions and the following
;;       disclaimer in the documentation and/or other materials provided
;;       with the distribution.

;;     * Neither the name of the @organization@ nor the names of its
;;       contributors may be used to endorse or promote products derived
;;       from this software without specific prior written permission.

;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;; A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL LE MANH CUONG
;; BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
;; BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
;; WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
;; OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
;; IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;;; Commentary:

;; A flycheck linter for sh script using checkbashisms

;;; Code:

(require 'flycheck)

(defgroup flycheck-checkbashisms nil
  "checkbashisms intergrate with flycheck"
  :prefix "flycheck-checkbashisms"
  :group 'flycheck
  :link '(url-link :tag "Github" "https://github.com/Gnouc/flycheck-checkbashisms"))

(flycheck-def-option-var flycheck-checkbashisms-newline nil checkbashisms
  "Check for 'echo -n' usage"
  :safe #'booleanp
  :type 'boolean)

(flycheck-def-option-var flycheck-checkbashisms-posix nil checkbashisms
  "Check non POSIX issues but required by Debian Policy 10.4
Enable this also enable `flycheck-checkbashisms-newline'"
  :safe #'booleanp
  :type 'boolean)

(flycheck-define-checker sh-checkbashisms
  "A linter for sh script.
See URL: `https://anonscm.debian.org/cgit/collab-maint/devscripts.git/tree/scripts/checkbashisms.pl'"
  :command ("checkbashisms"
            (option-flag "-n" flycheck-checkbashisms-newline)
            (option-flag "-p" flycheck-checkbashisms-posix)
            "-")
  :standard-input t
  :error-patterns
  ((error line-start
          (one-or-more not-newline) " line " line " " (message) ":"
          line-end))
  :modes sh-mode
  :predicate (lambda () (not (eq sh-shell 'bash)))
  :verify (lambda (_)
            (let ((_not-bash (not (eq sh-shell 'bash))))
              (list
               (flycheck-verification-result-new
                :label (format "Check shell %s" sh-shell)
                :message (if _not-bash "yes" "no")
                :face (if _not-bash 'success '(bold warning)))))))

;;;###autoload
(defun flycheck-checkbashisms-setup ()
  "Setup Flycheck checkbashisms.
Add `checkbashisms' to `flycheck-checkers'."
  (add-to-list 'flycheck-checkers 'sh-checkbashisms))

(provide 'flycheck-checkbashisms)
;;; flycheck-checkbashisms.el ends here
