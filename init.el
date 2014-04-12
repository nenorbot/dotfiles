(menu-bar-mode -1)
(tool-bar-mode -1)
(setq line-number-mode t)
(setq column-number-mode t)

(require 'ido)
(ido-mode t)
(global-set-key 
 "\M-x"
 (lambda ()
   (interactive)
   (call-interactively
    (intern
     (ido-completing-read
      "M-x "
      (all-completions "" obarray 'commandp))))))

(add-to-list 'custom-theme-load-path
	     "~/.emacs.d/themes/")

(require 'package)

(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(setq refreshed nil)

(defun add-my-package (p)
  (unless (package-installed-p p)
    (if (not refreshed)
	(progn
	  (package-refresh-contents)
	  (setq refreshed t)))
    (package-install p)))

(add-to-list 'load-path "~/.emacs.d/")

(add-my-package 'dash)
(add-my-package 'pkg-info)

(add-my-package 'clojure-mode)
(require 'clojure-mode)
(add-hook 'clojure-mode-hook '(lambda ()
				(local-set-key (kbd "RET") 'newline-and-indent)))

(add-my-package 'cider)
(add-my-package 'undo-tree)
(add-my-package 'ace-jump-mode)
(add-my-package 'yasnippet)
(add-my-package 'auto-complete)

(require 'auto-complete-config)
(ac-config-default)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(add-my-package 'ac-nrepl)
(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
'(add-to-list 'ac-modes 'cider-repl-mode))
(defun set-auto-complete-as-completion-at-point ()
(setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point)
(add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point)

(add-my-package 'mic-paren)
(require 'mic-paren)
(paren-activate)

(add-my-package 'paredit)
(autoload 'enable-paredit-mode "paredit" "paredit" t)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)

(add-my-package 'eldoc)
(add-hook 'clojure-mode 'turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

(add-my-package 'cljdoc)

(add-my-package 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(add-my-package 'magit)
(global-set-key (kbd "C-c m") 'magit-status)

(add-my-package 'switch-window)
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

(add-my-package 'browse-kill-ring)
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; (add-my-package 'highlight-tail)
(require 'highlight-tail)
(setq highlight-tail-steps 14
      highlight-tail-timer 0.02)
(setq highlight-tail-colors '(("black" . 0)
			      ("orange" . 25)
			      ("black" . 66)))
(highlight-tail-mode)


(add-my-package 'auto-compile)
(require 'auto-compile)
(auto-compile-on-load-mode 1)
(auto-compile-on-save-mode 1)

(add-my-package 'afternoon-theme)
(load-theme 'afternoon t)

(add-my-package 'smex)
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(require 'sexpand)
(global-set-key (kbd "C-c w") 'sexpand)

(add-my-package 'makey)
(add-my-package 'discover)
(global-discover-mode 1)

