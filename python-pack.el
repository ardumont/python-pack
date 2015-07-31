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
  :bind ("C-c C-d t" . py-pdbtrack-toggle-stack-tracking)
  :config
  (define-key python-mode-map (kbd "C-c C-d") nil)
  (dolist (py-mode-hook '(python-mode-hook py-python-shell-mode-hook py-ipython-shell-mode-hook))
    (dolist (hook-fn '(smartscan-mode-turn-on company-mode-on anaconda-mode))
      (add-hook py-mode-hook hook-fn)))
  (custom-set-variables '(py-python-command "python3")
                        '(ipython-command "ipython3")))

(use-package anaconda-mode
  :bind ("C-c C-d d" . anaconda-mode-view-doc)
  :config
  (define-key anaconda-mode-map (kbd "M-?") nil) ;; unbind M-? (already used as emacs' default C-h)
  (define-key anaconda-mode-map [remap tags-loop-continue] 'anaconda-nav-pop-marker))

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
