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

(require 'install-packages-pack)
(install-packages-pack/install-packs '(python-mode
                                       smartscan
                                       repl-toggle
                                       flycheck-pyflakes
                                       use-package))

(use-package repl-toggle
  :init
  (add-to-list 'rtog/mode-repl-alist '(python-mode . python3)))

(use-package anaconde-mode
  :init
  (bind-key "C-c C-d d" 'anaconda-mode-view-doc)
  (define-key anaconda-mode-map (kbd "M-?") nil) ;; unbind M-? (already used as emacs' default C-h)
  )

(use-package python-mode
  :init
  (add-hook 'python-mode-hook 'smartscan-mode-turn-on)
  (add-hook 'python-mode-hook 'company-mode-on)

  (define-key python-mode-map (kbd "C-c C-d") nil) ;; unbind key
  (bind-key "C-c C-d t" 'py-pdbtrack-toggle-stack-tracking))

(provide 'python-pack)
;;; python-pack.el ends here
