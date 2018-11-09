;;; python-pack.el --- A pack for python setup  -*- lexical-binding: t; -*-

;; Copyright (C) 2014-2018  Antoine R. Dumont

;; Author: Antoine R. Dumont <tony@dagobah>
;; Keywords: unix, convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

;; internal libs
(require 'python)
(require 'whitespace)

;; external
(require 'smartscan)
(require 'elpy)
(elpy-enable)

(define-key elpy-mode-map (kbd "M-.") 'elpy-goto-definition)

(define-key python-mode-map (kbd "C-c C-d") nil)
(define-key python-mode-map (kbd "C-c C-d t") 'py-pdbtrack-toggle-stack-tracking)
(define-key python-mode-map (kbd "C-c C-c") 'py-execute-statement-python3-no-switch)
(define-key python-mode-map (kbd "C-c C-b") 'py-execute-buffer-python3-no-switch)
(define-key python-mode-map (kbd "C-c C-l") 'py-execute-buffer-python3-no-switch)

(custom-set-variables
 ;; python setup
 '(python-shell-interpreter "ipython3")
 ;; '(python-shell-interpreter-args "...")
 '(python-indent-offset 4)
 '(python-shell-buffer-name "Python3")
 '(python-check-command "pyflakes3"))

(defun python-pack--hook-fn ()
  "Hook function to install on python modes."
  (custom-set-variables '(whitespace-line-column 79)
			'(whitespace-style '(face tabs empty trailing
						  lines-tail))))

(dolist (py-mode-hook '(python-mode-hook
			py-python-shell-mode-hook
			py-ipython-shell-mode-hook))
  (dolist (hook-fn '(subword-mode
		     python-pack--hook-fn
		     smartscan-mode
		     eldoc-mode))
    (add-hook py-mode-hook hook-fn)))

(provide 'python-pack)
;;; python-pack.el ends here
