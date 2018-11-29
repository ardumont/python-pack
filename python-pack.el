;;; python-pack.el --- A pack for python setup

;; Copyright (C) 2014-2018  Antoine R. Dumont (@ardumont)
;; Author: Antoine R. Dumont (@ardumont) <antoine.romain.dumont@gmail.com>
;; Keywords:

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

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;;; Code:

;; internal libs
(require 'python)
(require 'whitespace)
(require 'smartparens-config)

;; external
(require 'elpy)
(elpy-enable)

;; define paredit-like bindings

(define-key smartparens-mode-map (kbd "C-M-h") 'sp-backward-kill-sexp)
(define-key smartparens-mode-map (kbd "C-)") 'sp-forward-slurp-sexp) ;; sp-slurp-hybrid-sexp
(define-key smartparens-mode-map (kbd "C-(") 'sp-backward-slurp-sexp)

(define-key smartparens-mode-map (kbd "M-s") 'sp-splice-sexp)
(define-key smartparens-mode-map (kbd "M-S") 'sp-split-sexp)
(define-key smartparens-mode-map (kbd "C-M-f") 'sp-forward-sexp)
(define-key smartparens-mode-map (kbd "C-M-b") 'sp-backward-sexp)
(define-key smartparens-mode-map (kbd "C-M-d") 'sp-down-sexp)
(define-key smartparens-mode-map (kbd "C-M-u") 'sp-up-sexp)
(define-key smartparens-mode-map (kbd "C-M-a") 'sp-beginning-of-sexp)
(define-key smartparens-mode-map (kbd "C-M-e") 'sp-end-of-sexp)
(define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)

;; keep standard kill-line sp-kill-hybrid-sexp is strange
(define-key smartparens-strict-mode-map [remap kill-line] nil)

(define-key elpy-mode-map (kbd "M-.") 'elpy-goto-definition)
(define-key python-mode-map (kbd "C-c C-d") nil)
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

(add-hook 'python-mode-hook 'smartparens-strict-mode)

(provide 'python-pack)
;;; python-pack.el ends here
