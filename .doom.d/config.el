;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'ronen)
(setq doom-font (font-spec :family "JetBrains Mono" :size 15))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

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

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


(map! :leader
      "v"
      #'er/expand-region)

;; (map! :leader
;;       :desc "Comment/uncomment"
;;       ";"
;;       #'comment-line)
;;

;; unmap <SPC c x> and rebind it
(map! :leader
      :prefix ("c" . "code")
      (:nv "x" nil
       :prefix ("x". "Errors")
        :desc "Explain" "e" #'flycheck-explain-error-at-point
        :desc "List errors" "x" #'+default/diagnostics))

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
  ;; (require 'dap-cpptools)
  ;; (require 'dap-lldb)
  ;; (require 'dap-gdb-lldb)

  ;; (dap-register-debug-template
  ;;  "Rust::LLDB Run Configuration"
  ;;  (list :type "lldb-mi"
  ;;        :request "launch"
  ;;        :name "Rust::LLDB::Run"
  ;;        :gdbpath "rust-lldb"
  ;;        :target nil
  ;;        :cwd nil))
  )


;; enable tree sitter parsing, text objects
;; (add-hook 'rust-mode-hook #'tree-sitter-mode)

;; enable tree sitter syntax highlighting
;; (add-hook 'rust-mode-hook #'tree-sitter-hl-mode)

(after! which-key
  (setq which-key-idle-delay 0.2)
  (setq which-key-idle-secondary-delay 0.05))

(add-hook! 'elfeed-search-mode-hook #'elfeed-update)

(add-hook 'window-setup-hook #'toggle-frame-fullscreen)

;; (add-hook! 'better-jumper-post-jump-hook #'recenter-top-bottom)

;; (add-hook 'lisp-mode-hook #'evil-cleverparens-mode)
;; (after! lisp-mode
;;   (require 'evil-cleverparens-text-objects))


(display-time-mode)
(setq avy-timeout-seconds 0.3)

;; (global-undo-tree-mode)
;; (add-hook 'evil-local-mode-hook 'turn-on-undo-tree-mode)

(setq evil-snipe-override-evil-repeat-keys nil)
(setq doom-localleader-key ",")

(defun semicolon-at-end-of-line ()
  (interactive)
  (save-excursion
    (end-of-line)
    (insert ";")))


;; (setq highlight-indent-guides-method 'bitmap)
;; (setq highlight-indent-guides-responsive 'top)
;; (setq highlight-indent-guides-delay 0)
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(setq math-additional-units '(
                              (GB "1024 * MiB" "Giga Byte")
                              (MB "1024 * KiB" "Mega Byte")
                              (KB "1024 * B" "Kilo Byte")
                              (B nil "Byte")
                              (Gib "1024 * Mib" "Giga Bit")
                              (Mib "1024 * Kib" "Mega Bit")
                              (Kib "1024 * b" "Kilo Bit")
                              (b "B / 8" "Bit")))

(setq doom-modeline-vcs-max-length 20)

(setq-default right-margin-width 2)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(setq evil-collection-setup-minibuffer t)

(global-subword-mode)

(setq magit-list-refs-sortby "-creatordate")

(setq better-jumper-add-jump-behavior 'replace)

;; (after! corfu-mode
;;   ;; TAB-and-Go customizations
;;   (corfu-cycle t)           ;; Enable cycling for `corfu-next/previous'
;;   (corfu-preselect 'prompt) ;; Always preselect the prompt
;;   )

;; ;; Use TAB for cycling, default is `corfu-complete'.
;; (map! :after corfu-mode
;;       :map corfu-map
;;         "TAB" corfu-next
;;         [tab] corfu-next
;;         "S-TAB" corfu-previous
;;         [backtab] corfu-previous
;;         ;; ([tab] . corfu-next)
;;         ;; ("S-TAB" . corfu-previous)
;;         ;; ([backtab] . corfu-previous)
;;         )

;; ;;
