(setq inhibit-startup-message t)

(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                      64 68 72 76 80 84 88 92 96 100 104 108 112
                      116 120))

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar
(set-default 'truncate-lines t)
(column-number-mode)
(global-display-line-numbers-mode t)
(setq-default indent-tabs-mode nil)

;; Set up the visible bell
(setq ring-bell-function 'ignore)

(set-face-attribute 'default nil :font "Menlo" :height 140)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;;;; colorize output in compile buffer
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point-max)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(use-package command-log-mode)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

(rune/leader-keys
  "SPC" '(counsel-M-x :which-key "councel-M-x")
  "/" '(comment-line :which-key "comment line")
  "f" '(:ignore t :which-key "files")
  "fr" '(recentf-open :which-key "open recent"))

(general-define-key
 :states 'normal
 "C-w C-h" 'evil-window-left
 "C-w C-j" 'evil-window-down
 "C-w C-k" 'evil-window-up
 "C-w C-l" 'evil-window-right
 )

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (define-key evil-insert-state-map (kbd "<tab>") 'company-indent-or-complete-common)
  (define-key evil-insert-state-map (kbd "<backtab>") 'evil-shift-left-line)
  (evil-mode 1)

  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  ;; (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
)

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
	(c-sharp . ("https://github.com/tree-sitter/tree-sitter-c-sharp" "v0.20.0"))
	(cmake "https://github.com/uyha/tree-sitter-cmake")
	(css "https://github.com/tree-sitter/tree-sitter-css")
	(elisp "https://github.com/Wilfred/tree-sitter-elisp")
	(go "https://github.com/tree-sitter/tree-sitter-go")
	(html "https://github.com/tree-sitter/tree-sitter-html")
	(javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
	(json "https://github.com/tree-sitter/tree-sitter-json")
	(make "https://github.com/alemuller/tree-sitter-make")
	(markdown "https://github.com/ikatyang/tree-sitter-markdown")
	(python "https://github.com/tree-sitter/tree-sitter-python")
	(toml "https://github.com/tree-sitter/tree-sitter-toml")
	(tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
	(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
	(yaml "https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0")))

(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(defun custom/typescript-mode-hook ()
  (message "Runing custom/typescript-mode-hook")
  ;; next items aimed to add support of errors in output of `bun test'
  ;; however, they don't work as expected. output became colorless
  ;; (add-to-list 'compilation-error-regexp-alist-alist '(bun-test "  at \\(.*\\):\\([0-9]+\\):\\([0-9]+\\)" 1 2 3)))
  ;; (add-to-list 'compilation-error-regexp-alist 'bun-test)

  (setq compilation-error-regexp-alist-alist `((bun-test "at \\(.*\\):\\([0-9]+\\):\\([0-9]+\\)" 1 2 3)))
  (setq compilation-error-regexp-alist '(bun-test))
  )

(defun custom/csharp-mode-hook()
  (message "Running custom/csharp-mode-hook")
  ;; disable auto new line on save
  (setq require-final-newline nil)

  ;; setup compilation output parsing (TODO)
  (setq compilation-error-regexp-alist-alist `((dotnet "\\(/.*\\)(\\([0-9]+\\),\\([0-9]+\\)): error .*" 1 2 3)))
  (setq compilation-error-regexp-alist '(dotnet))
  )

(defun custom/lsp-mode-hook ()
  (message "LSP-MODE hook")
  (evil-local-set-key 'normal (kbd ",") lsp-command-map)
)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix ",")
  :hook (
        (typescript-ts-mode . lsp)
        (csharp-ts-mode . lsp)
        (lsp-mode . lsp-enable-which-key-integration)
        (lsp-mode . custom/lsp-mode-hook))
  :commands lsp)

(add-hook 'typescript-ts-mode-hook 'custom/typescript-mode-hook)
(add-hook 'csharp-ts-mode-hook 'custom/csharp-mode-hook)
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(add-to-list 'major-mode-remap-alist '(csharp-mode . csharp-ts-mode))

(use-package lsp-ui)

(use-package company
  :hook
  (after-init-hook . global-company-mode)
  :bind
  ("C-<tab>" . company-indent-or-complete-common)
  (:map company-active-map
        ("C-<RET>" . company-abort)
        ("<tab>" . company-complete-selection))
  :custom
  (company-idle-delay 0.25)
  (company-minimum-prefix-length 2)
  (company-selection-wrap-around t))

(use-package company-dabbrev
  :after company
  :ensure nil
  :custom
  (company-dabbrev-ignore-case nil)
  (company-dabbrev-downcase nil))

(use-package company-dabbrev-code
  :after company
  :ensure nil
  :custom
  (company-dabbrev-code-modes t)
  (company-dabbrev-code-ignore-case nil))

(setq company-backends '((company-capf company-dabbrev-code)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8122fb61548fe36171d9cf24cdb9b5f24d053b626d4cda739c3815e080623209" "d8bcb88ef0a3259a38d6deba78e569c0750ebfede82ad3e6da16573419fef48c" "456697e914823ee45365b843c89fbc79191fdbaff471b29aad9dcbe0ee1d5641" default))
 '(desktop-save-mode t)
 '(evil-undo-system 'undo-redo)
  '(lsp-csharp-omnisharp-roslyn-binary-path
   "/Users/dmitryivanov/omnisharp/omnisharp-osx-arm64-net6.0/run")
 '(package-selected-packages
   '(standard-themes evil-collection general helpful ivy-rich which-key rainbow-delimiters ivy command-log-mode evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
