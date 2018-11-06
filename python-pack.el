;;; python-pack.el --- A pack for python setup  -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Antoine R. Dumont

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

(require 'smartscan)
(require 'whitespace)

(require 'python-mode)
(defun whitespace-hook-fn ()
  (require 'whitespace)
  (custom-set-variables '(whitespace-line-column 79)
			'(whitespace-style '(face tabs empty trailing lines-tail))))

(define-key python-mode-map (kbd "C-c C-d") nil)
(define-key python-mode-map (kbd "C-c C-d t") 'py-pdbtrack-toggle-stack-tracking)
(define-key python-mode-map (kbd "C-c C-c") 'py-execute-statement-python3-no-switch)
(define-key python-mode-map (kbd "C-c C-b") 'py-execute-buffer-python3-no-switch)
(define-key python-mode-map (kbd "C-c C-l") 'py-execute-buffer-python3-no-switch)

(dolist (py-mode-hook '(python-mode-hook
			py-python-shell-mode-hook
			py-ipython-shell-mode-hook))
  (dolist (hook-fn '(company-mode-on
		     subword-mode
		     whitespace-hook-fn))
    (add-hook py-mode-hook hook-fn)))

(add-hook 'python-mode-hook 'smartscan-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
(custom-set-variables '(py-python-command "python3")
		      '(py-shell-name "python3")
		      '(python-indent-offset 4)
		      '(py-ipython-command "ipython3")
		      '(py-keep-windows-configuration 'force)
		      '(py-switch-buffers-on-execute-p nil)
		      '(py-split-window-on-execute 'just-two))

(require 'python)
(custom-set-variables '(python-shell-interpreter "ipython3")
		      ;; '(python-shell-interpreter-args "...")
		      '(python-shell-buffer-name "Python3")
		      '(python-check-command "pyflakes3"))

;; (require 'flycheck-pyflakes)
;; (require 'flycheck)

(require 'elpy)
;;(add-hook 'elpy-mode-hook 'flycheck-mode)
(add-hook 'elpy-mode-hook (lambda ()
			    (define-key elpy-mode-map (kbd "M-,") 'pop-tag-mark)))
;;(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
(custom-set-variables '(elpy-rpc-python-command "python3")
		      '(elpy-test-discover-runner-command '("python3" "-m" "nose")))

(elpy-enable)

;; for debug

(defun python-pack-trace-at-point ()
  "Dump a print trace of the variable at point."
  (interactive)
  (let ((print-statement (let ((var (symbol-at-point)))
                           (format "print ('%s: ', %s)"  var var))))
    (save-excursion
      (with-current-buffer (current-buffer)
        (forward-sentence)
        (insert "\n")
        (call-interactively 'indent-for-tab-command)
        (insert print-statement)))))

(defun python-pack-add-nose-test-attr-one (&optional args)
  "Add into python code an attr one to ease testing for that particular test.
Then use: nosetests3 path/to/test.py -a one to trigger the tests.
With ARGS set, does not add import statement."
  (interactive "P")
  (lexical-let ((import (if (null args)
                            "    from nose.plugins.attrib import attr\n"
                          "")))
    (save-excursion
      (with-current-buffer (current-buffer)
        (insert (format  "%s    @attr('one')\n" import))))))

(provide 'python-pack)
;;; python-pack.el ends here
