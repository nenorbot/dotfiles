(menu-bar-mode -1)
(tool-bar-mode -1)
(setq line-number-mode t)
(setq column-number-mode t)
(global-linum-mode t)

(require 'package)

(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(setq *refreshed* nil)

(defun add-my-package (p)
  (unless (package-installed-p p)
    (unless *refreshed*
	(progn
	  (package-refresh-contents)
	  (setq *refreshed* t)))
    (package-install p)))

;(add-to-list 'load-path "~/.emacs.d/")

(add-my-package 'guru-mode)
(add-hook 'prog-mode-hook 'guru-mode)

(add-my-package 'better-defaults)
(add-my-package 'projectile)
(add-my-package 'clojure-mode)
(add-my-package 'cider)
(add-my-package 'paredit)
(add-my-package 'rainbow-delimiters)
(add-my-package 'clj-refactor)
(add-my-package 'ac-cider)
(add-my-package 'clojure-cheatsheet)
(add-my-package 'solarized-theme)
(add-my-package 'zenburn-theme)
(add-my-package 'darcula-theme)
(add-my-package 'expand-region)
(add-my-package 'undo-tree)
(add-my-package 'browse-kill-ring)
(add-my-package 'eldoc)
(add-my-package 'switch-window)
(add-my-package 'helm)
(add-my-package 'cljr-helm)
(add-my-package 'magit)
(add-my-package 'drag-stuff)
(add-my-package 'ace-jump-mode)

(require 'ace-jump-mode)
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'drag-stuff)
(drag-stuff-mode t)
(global-set-key (kbd "C-<up>") 'drag-stuff-up)
(global-set-key (kbd "C-<down>") 'drag-stuff-down)

(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)

(require 'cljr-helm)
(global-set-key (kbd "C-c C-r") 'cljr-helm)

(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'clojure-mode 'turn-on-eldoc-mode)

(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'expand-region)
(global-set-key (kbd "C-c w") 'er/expand-region)

;(load-theme 'solarized-dark t)
(load-theme 'zenburn t)

(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'cider-repl-mode-hook #'paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)

(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)

(require 'clj-refactor)

(defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import
    (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

(require 'ac-cider)
(global-auto-complete-mode t)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(setq tab-always-indent 'complete)
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))

(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

(eval-after-load 'clojure-mode
  '(progn
     (define-key clojure-mode-map (kbd "C-c C-h") #'clojure-cheatsheet)))

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))
