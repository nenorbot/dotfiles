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


;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;




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


(map! :leader
      "o c"
      #'calc)

;; (map! :after rust-mode
;;       :map evil-normal-state-map
;;       ">"
;;       #'evil-cp->)

;; (map! :after rust-mode
;;       :map evil-normal-state-map
;;       "<"
;;       #'evil-cp-<)

;; (after! literate-calc-mode
;;   (defalias 'calcFunc-uconv 'math-convert-units))

;; (add-hook 'org-mode-hook #'literate-calc-minor-mode)

(after! lsp-mode
  (setq lsp-rust-analyzer-closing-brace-hints-min-lines 0)
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names t)
  (setq lsp-rust-analyzer-display-reborrow-hints "mutable")
  (setq lsp-rust-analyzer-display-chaining-hints t)
  (setq lsp-headerline-breadcrumb-enable '(project file symbols))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Enable for linux rust-analyzer ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq lsp-rust-analyzer-cargo-target "x86_64-unknown-linux-gnu")

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

(add-hook 'lisp-mode-hook #'evil-cleverparens-mode)
(after! lisp-mode
  (require 'evil-cleverparens-text-objects))

(add-hook 'clojure-mode-hook #'evil-cleverparens-mode)
(after! clojure-mode
  (require 'evil-cleverparens-text-objects))

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
 (B nil "Byte")
 (b "B / 8" "Bit")
 (KB "1000 * B" "Kilo Byte")
 (MB "1000 * KB" "Mega Byte")
 (GB "1000 * MB" "Giga Byte")
 (TB "1000 * GB" "Tera Byte")
 (KiB "1024 * B" "Kibi Byte")
 (MiB "1024 * KiB" "Mebi Byte")
 (GiB "1024 * MiB" "Gibi Byte")
 (TiB "1024 * GiB" "Tebi Byte")
 (Kbit "1000 * b" "Kilo Bit")
 (Mbit "1000 * Kbit" "Mega Bit")
 (Gbit "1000 * Mbit" "Giga Bit")
 (Tbit "1000 * Gbit" "Tera Bit")))

(setq doom-modeline-vcs-max-length 20)

(setq-default right-margin-width 2)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(setq evil-collection-setup-minibuffer t)

(global-subword-mode)

(setq magit-list-refs-sortby "-creatordate")

(setq better-jumper-add-jump-behavior 'replace)

(map! :after calc-mode
  :map calc-mode-map
  "C-o" #'casual-calc-tmenu
  :map calc-alg-map
  "C-o" #'casual-calc-tmenu)


      ;; :map rust-mode-map
      ;; :localleader
      ;; :desc "Open Cargo.toml"
      ;; "f"
      ;; #'lsp-rust-analyzer-open-cargo-toml)
(setq dap-cpptools-extension-version "1.5.1")

  (with-eval-after-load 'lsp-rust
    (require 'dap-cpptools))

  (with-eval-after-load 'dap-cpptools
    (dap-register-debug-template "Rust LLDB Debug Configuration"
        (list :type "cppdbg"
                :request "launch"
                :name "Rust::Run"
                :MIMode "lldb"
                :gdbpath "rust-lldb"
                :program (concat (projectile-project-root) "target/debug/" (projectile-project-name)) ;; Requires that the rust project is a project in projectile
                :environment []
                :cwd (projectile-project-root)))
    ;; Add a template specific for debugging Rust programs.
    ;; It is used for new projects, where I can M-x dap-edit-debug-template
    (dap-register-debug-template "Rust::CppTools Run Configuration"
                                 (list :type "cppdbg"
                                       :request "launch"
                                       :name "Rust::Run"
                                       :MIMode "gdb"
                                       :miDebuggerPath "rust-gdb"
                                       :environment []
                                       :program "${workspaceFolder}/target/debug/hello / replace with binary"
                                       :cwd "${workspaceFolder}"
                                       :console "external"
                                       :dap-compilation "cargo build"
                                       :dap-compilation-dir "${workspaceFolder}")))

  (with-eval-after-load 'dap-mode
    (setq dap-default-terminal-kind "integrated") ;; Make sure that terminal programs open a term for I/O in an Emacs buffer
    (dap-auto-configure-mode +1))


(setq org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org"
      org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* ")

(after! vertico
  ;; Ensure we start in insert mode
  (setq evil-minibuffer-state 'insert)

  ;; Re-bind j/k only for the vertico-map in Normal state
  (evil-define-key 'normal vertico-map
    (kbd "j") #'vertico-next
    (kbd "k") #'vertico-previous)

  ;; Re-bind ESC to switch to normal mode, or quit if already in normal
  (define-key vertico-map (kbd "<escape>")
    (lambda ()
      (interactive)
      (if (evil-normal-state-p)
          (abort-recursive-edit)
        (evil-normal-state)))))
