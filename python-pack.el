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

(use-package flycheck-pyflakes)
(use-package smartscan)

(use-package python-mode
  :config
  (define-key python-mode-map (kbd "C-c C-d") nil)
  (define-key python-mode-map (kbd "C-c C-d t") 'py-pdbtrack-toggle-stack-tracking)
  (define-key python-mode-map (kbd "C-c C-c") 'py-execute-statement-python3-no-switch)
  (define-key python-mode-map (kbd "C-c C-b") 'py-execute-buffer-python3-no-switch)
  (define-key python-mode-map (kbd "C-c C-l") 'py-execute-buffer-python3-no-switch)

  (dolist (py-mode-hook '(python-mode-hook py-python-shell-mode-hook py-ipython-shell-mode-hook))
    (add-hook py-mode-hook 'company-mode-on))
  (add-hook 'python-mode-hook 'smartscan-mode)
  (add-hook 'python-mode-hook 'eldoc-mode)
  (custom-set-variables '(py-python-command "python3")
                        '(py-shell-name "python3")
                        '(python-indent-offset 4)
                        '(py-ipython-command "ipython3")
                        '(py-keep-windows-configuration 'force)
                        '(py-switch-buffers-on-execute-p nil)
                        '(py-split-window-on-execute 'just-two)))

(use-package python
  :config
  (custom-set-variables '(python-shell-interpreter "python3")
                        ;; '(python-shell-interpreter-args "...")
                        '(python-shell-buffer-name "Python3")))

(use-package flycheck)

(use-package elpy
  :config
  (add-hook 'elpy-mode-hook 'flycheck-mode)
  (add-hook 'elpy-mode-hook (lambda ()
                              (define-key elpy-mode-map (kbd "M-,") 'pop-tag-mark)))
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (custom-set-variables '(elpy-rpc-python-command "python3")
                        '(elpy-test-discover-runner-command '("python3" "-m" "nose")))

  (elpy-enable))

;; (use-package company-jedi
;;   :config
;;   (add-hook 'python-mode-hook
;;             (lambda () (add-to-list 'company-backends 'company-jedi))))

;; for debug

(use-package repl-toggle
  :config
  (rtog/add-repl 'python-mode 'py-switch-to-shell)
  (custom-set-variables '(rtog/fullscreen t)))

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

(provide 'python-pack)
;;; python-pack.el ends here
