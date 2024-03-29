;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-font (font-spec :family "JetBrains Mono" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-oceanic-next)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(map! :leader
      "v"
      #'er/expand-region)

;; (map! :leader
;;       :desc "Comment/uncomment"
;;       ";"
;;       #'comment-line)

(map! :leader
      "c ! e"
      #'flycheck-explain-error-at-point)

(map! :leader
      :desc ";"
      "i ;"
      #'semicolon-at-end-of-line)

(map! :after rust-mode
      :map rust-mode-map
      :localleader
      :desc "Open Cargo.toml"
      "f"
      #'lsp-rust-analyzer-open-cargo-toml)

(map! :after rust-mode
      :map rust-mode-map
      :localleader
      :desc "Expand macro"
      "m"
      #'lsp-rust-analyzer-expand-macro)


(map! :after rust-mode
      :map evil-normal-state-map
      :desc "lookup type"
      "g t"
      #'lsp-find-type-definition)


(map! :leader
      "w ]"
      #'evil-window-right)

(map! :leader
      "w ["
      #'evil-window-left)

;; (map! :after rust-mode
;;       :map evil-normal-state-map
;;       ">"
;;       #'evil-cp->)

;; (map! :after rust-mode
;;       :map evil-normal-state-map
;;       "<"
;;       #'evil-cp-<)

(after! literate-calc-mode
  (defalias 'calcFunc-uconv 'math-convert-units))

(add-hook 'org-mode-hook #'literate-calc-minor-mode)

(after! lsp-mode
  (setq lsp-rust-analyzer-closing-brace-hints-min-lines 0)
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names t)
  (setq lsp-rust-analyzer-display-reborrow-hints "mutable")
  (setq lsp-rust-analyzer-display-chaining-hints t)
  (setq lsp-headerline-breadcrumb-enable '(project file symbols))
  (require 'dap-cpptools)
  (require 'dap-lldb)
  (require 'dap-gdb-lldb)

  (dap-register-debug-template
   "Rust::LLDB Run Configuration"
   (list :type "lldb-mi"
         :request "launch"
         :name "Rust::LLDB::Run"
	 :gdbpath "rust-lldb"
         :target nil
         :cwd nil)))


;; enable tree sitter parsing, text objects
(add-hook 'rust-mode-hook #'tree-sitter-mode)

;; enable tree sitter syntax highlighting
(add-hook 'rust-mode-hook #'tree-sitter-hl-mode)

(after! which-key
  (setq which-key-idle-delay 0.2)
  (setq which-key-idle-secondary-delay 0.05))

(add-hook! 'elfeed-search-mode-hook #'elfeed-update)

(add-hook 'window-setup-hook #'toggle-frame-fullscreen)

(add-hook 'clojure-mode-hook #'evil-cleverparens-mode)
(add-hook 'clojure-mode-hook #'highlight-indent-guides-mode)
(after! clojure-mode
  (require 'evil-cleverparens-text-objects))

(add-hook! 'better-jumper-post-jump-hook #'recenter-top-bottom)

(add-hook 'lisp-mode-hook #'evil-cleverparens-mode)
(after! lisp-mode
  (require 'evil-cleverparens-text-objects))


(display-time-mode)
(setq avy-timeout-seconds 0.3)

(global-undo-tree-mode)
(add-hook 'evil-local-mode-hook 'turn-on-undo-tree-mode)

(setq evil-snipe-override-evil-repeat-keys nil)
(setq doom-localleader-key ",")

(defun semicolon-at-end-of-line ()
  (interactive)
  (save-excursion
    (end-of-line)
    (insert ";")))


(setq highlight-indent-guides-method 'bitmap)
(setq highlight-indent-guides-responsive 'top)
(setq highlight-indent-guides-delay 0)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(setq math-additional-units '(
  (GiB "1024 * MiB" "Giga Byte")
  (MiB "1024 * KiB" "Mega Byte")
  (KiB "1024 * B" "Kilo Byte")
  (B nil "Byte")
  (Gib "1024 * Mib" "Giga Bit")
  (Mib "1024 * Kib" "Mega Bit")
  (Kib "1024 * b" "Kilo Bit")
  (b "B / 8" "Bit")))

(add-hook
 'treemacs-mode-hook
 (lambda ()
   (setq-local hl-line-face 'custom-line-highlight)
   (overlay-put hl-line-overlay 'face '((t (:background "gray40" :extend t))))
   (treemacs--setup-icon-background-colors)))

(setq doom-modeline-vcs-max-length 20)

(setq-default right-margin-width 2)

;; (map! :leader "j h" 'harpoon-quick-menu-hydra)
;; (map! :leader "j a" 'harpoon-add-file)
;; (map! :leader "j j" 'harpoon-toggle-quick-menu)
;; (map! :leader "j c" 'harpoon-clear)
;; (map! :leader "j f" 'harpoon-toggle-file)
;; (map! :leader "1" 'harpoon-go-to-1)
;; (map! :leader "2" 'harpoon-go-to-2)
;; (map! :leader "3" 'harpoon-go-to-3)
;; (map! :leader "4" 'harpoon-go-to-4)
;; (map! :leader "5" 'harpoon-go-to-5)
;; (map! :leader "6" 'harpoon-go-to-6)
;; (map! :leader "7" 'harpoon-go-to-7)
;; (map! :leader "8" 'harpoon-go-to-8)
;; (map! :leader "9" 'harpoon-go-to-9)

(after! undo-tree
  (setq undo-tree-auto-save-history nil))

;; (setq lsp-rust-analyzer-checkonsave-features '("all"))

(setq evil-collection-setup-minibuffer t)

(global-subword-mode)

(setq org-noter-highlight-selected-text t)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
