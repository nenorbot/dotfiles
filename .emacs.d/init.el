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
(add-my-package 'helm-projectile)
(add-my-package 'flycheck-clojure)
(add-my-package 'flycheck-pos-tip)
;(add-my-package 'flycheck-tip)
(add-my-package 'monky) 
(add-my-package 'cider-eval-sexp-fu)
(add-my-package 'perspective)
(add-my-package 'persp-projectile)
(add-my-package 'hackernews)
(add-my-package 'elfeed)
(add-my-package 'dumb-jump)
(add-my-package 'helm-cider)
;(add-my-package 'hl-line)
(add-my-package 'buffer-move)
(add-my-package 'neotree)
;(add-my-package 'scala-mode2)
(add-my-package 'ensime)
;(add-my-package 'clojure-snippets)
(add-my-package 'which-key)
(add-my-package 'company)
(add-my-package 'company-quickhelp)
(add-my-package 'command-log-mode)
(add-my-package 'ivy)
(add-my-package 'swiper)
(add-my-package 'swiper-helm)
(add-my-package 'arjen-grey-theme)
(add-my-package 'smart-mode-line)
(add-my-package 'smart-mode-line-powerline-theme)
(add-my-package 'eclim)
(add-my-package 'ac-emacs-eclim)
(add-my-package 'company-emacs-eclim)
(add-my-package 'sublimity)

(require 'ace-jump-mode)
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c f SPC") 'ace-jump-mode)

(require 'drag-stuff)
(drag-stuff-mode t)
(global-set-key (kbd "C-<up>") 'drag-stuff-up)
(global-set-key (kbd "C-<down>") 'drag-stuff-down)

(require 'helm-config)
(helm-mode)
(global-set-key (kbd "M-x") 'helm-M-x)

(require 'cljr-helm)
(global-set-key (kbd "C-c C-r") 'cljr-helm)

(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'cider-repl-mode-hook #'eldoc-mode)
;(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)

;(require 'browse-kill-ring)
;(browse-kill-ring-default-keybindings)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'expand-region)
(global-set-key (kbd "C-c w") 'er/expand-region)

;(load-theme 'solarized-dark t)
;(load-theme 'zenburn t)
(load-theme 'wombat t)
;(load-theme 'arjen-grey t)

(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)

(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)

(require 'clj-refactor)

(defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import
    (cljr-add-keybindings-with-prefix "C-c C-m")
    (setq cljr-warn-on-eval nil))

(defun my-buffer-face-mode-fixed ()
  (interactive)
  (setq buffer-face-mode-face '(:family "DejaVu Sans Mono" :height 105 ))
  (buffer-face-mode))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)
;(add-hook 'clojure-mode-hook 'my-buffer-face-mode-fixed)

;; (require 'ac-cider)
;; (global-auto-complete-mode t)
;; (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
;; (add-hook 'cider-mode-hook 'ac-cider-setup)
;; (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
;; (eval-after-load "auto-complete"
;;   '(progn
;;      (add-to-list 'ac-modes 'cider-mode)
;;      (add-to-list 'ac-modes 'cider-repl-mode)))

;; (setq tab-always-indent 'complete)
;; (defun set-auto-complete-as-completion-at-point-function ()
;;   (setq completion-at-point-functions '(auto-complete)))

;; (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

(eval-after-load 'clojure-mode
  '(progn
     (define-key clojure-mode-map (kbd "C-c C-h") #'clojure-cheatsheet)))

(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2)
  (defstate 0))

;; indentation for clojure.core.match/match
(put-clojure-indent 'match 1)

(helm-cider-mode)

(setq cider-repl-history-file "~/.cider_repl_history")

;(defalias 'helm-buffer-match-major-mode 'helm-buffers-list--match-fn)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(global-set-key (kbd "C-c n") 'helm-projectile-find-file)
(global-set-key (kbd "C-c l") 'helm-projectile-grep)

;(eval-after-load 'flycheck '(flycheck-clojure-setup))
;(add-hook 'after-init-hook #'global-flycheck-mode)

;; (with-eval-after-load 'flycheck
;;   (flycheck-pos-tip-mode))

(setq monky-process-type 'cmdserver)

(add-hook 'cider-repl-mode-hook #'subword-mode)

(require 'cider-eval-sexp-fu)

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-mode))

(require 'perspective)
(persp-mode)
(require 'persp-projectile)
(define-key global-map (kbd "C-c s") 'projectile-persp-switch-project)

; redefining from face from perspective.el
(face-spec-set 'persp-selected-face '((t :weight bold :foreground "CornflowerBlue")))

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

(global-set-key (kbd "C-x n") #'new-empty-buffer)

(global-set-key (kbd "C-x b") 'helm-buffers-list)

(defadvice show-paren-function
  (after show-matching-paren-offscreen activate)
   "If the matching paren is offscreen, show the matching line in the
   echo area. Has no effect if the character before point is not of
   the syntax class ')'."
   (interactive)
    (let* ((cb (char-before (point)))
     (matching-text (and cb
                     (char-equal (char-syntax cb) ?\) )
                     (blink-matching-open))))
     (when matching-text (message matching-text))))

(require 'hackernews)

(setq hackernews-top-story-limit 40)

(require 'elfeed)
(global-set-key (kbd "C-x w") 'elfeed)

(setq elfeed-feeds
      '("https://news.ycombinator.com/rss"))

(dumb-jump-mode)

(global-hl-line-mode t)
(set-face-attribute 'hl-line nil :background "coral4" :underline nil)
(set-face-foreground 'highlight nil)

(add-hook 'cider-repl-mode-hook
          (lambda ()
            (setq-local global-hl-line-mode nil)))

(set-cursor-color "#f4a460")
(set-face-attribute 'isearch nil :background "magenta4")
(set-face-attribute 'isearch-lazy-highlight-face nil :background "green")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
;(setq projectile-switch-project-action 'neotree-projectile-action)
(setq neo-smart-open t)

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(global-auto-revert-mode t)

(require 'which-key)
(which-key-mode)

(global-company-mode)
(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
;(global-set-key [tab] #'company-indent-or-complete-common)
(company-quickhelp-mode 1)
(eval-after-load 'company
  '(define-key company-active-map (kbd "M-h") #'company-quickhelp-manual-begin))


(defun cider-repl-rebind-tab-hook ()
  (define-key (current-local-map) (kbd "TAB") #'company-indent-or-complete-common)
  (define-key (current-local-map) [tab] #'company-indent-or-complete-common))

(add-hook 'cider-repl-mode-hook #'cider-repl-rebind-tab-hook)

(setq company-require-match 'never)
(setq company-selection-wrap-around t)

(defface swiper-line-face
  '((((class color) (background dark))
     :background "green" :foreground "black"))
  "")

(global-set-key "\C-s" 'swiper-helm)

(display-battery-mode)

(setq sml/no-confirm-load-theme t)
(setq sml/theme 'powerline)
(sml/setup)

(setq helm-move-to-line-cycle-in-source t)

(require 'eclim)
(require 'eclimd)
(add-hook 'java-mode-hook 'eclim-mode)

(custom-set-variables
  '(eclim-eclipse-dirs '("~/opt/eclipse"))
  '(eclim-executable "~/opt/eclipse/eclim"))

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)

(require 'sublimity)
(require 'sublimity-scroll)
;(require 'sublimity-map)
;(require 'sublimity-attractive)
(sublimity-mode 1)
