;;; --- 1. UI & PERSONAL PREFERENCES ---
(setq inhibit-splash-screen t)
(setq make-backup-files nil)
;; (add-hook 'window-setup-hook 'toggle-frame-maximized t)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode)
(global-display-line-numbers-mode t)
(electric-pair-mode 1)


(setq gc-cons-threshold 100000000) ; 100MB
(setq read-process-output-max (* 1024 1024))

;; (global-set-key (kbd "RET") 'newline-and-indent)

;; Styling & Theme
(set-face-attribute 'default nil :font "0xProto Nerd Font-18")
(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/catppuccin")
(load-theme 'catppuccin t)

;; Neotree
(add-to-list 'load-path "~/.config/emacs/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; Clean up line numbers for specific modes
(dolist (mode '(org-mode-hook term-mode-hook shell-mode-hook eshell-mode-hook neotree-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Global Keybinds
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;; --- 2. PACKAGE SYSTEM INITIALIZATION ---
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org"   . "https://orgmode.org/elpa/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;; --- 3. UI PACKAGES (IVY, DOOM, WHICH-KEY) ---
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line))
  :config (ivy-mode 1))

(use-package ivy-rich :init (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         ("C-M-j" . counsel-switch-buffer)))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; (use-package which-key
;;   :diminish
;;   :init (which-key-mode)
;;   :config (setq which-key-idle-delay 1))

(use-package helpful
  :bind (([remap describe-function] . counsel-describe-function)
         ([remap describe-command] . helpful-command)
         ([remap describe-variable] . counsel-describe-variable)
         ([remap describe-key] . helpful-key)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;;; --- 4. DEVELOPMENT & MSP430 SUPPORT ---

(use-package company
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.1
        company-async-timeout 5)
  :hook (eshell-mode . (lambda () (company-mode -1))))


(use-package yasnippet
  :config (yas-global-mode 1))


;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :hook ((c-mode . lsp-deferred)
;;          (c++-mode . lsp-deferred)
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :config
;;   (setq lsp-enable-on-type-formatting nil)
;;   (setq lsp-ui-doc-enable nil) ; Disable hover docs if they cause stutter
;;   (setq lsp-headerline-breadcrumb-enable nil)) ; Breadcrumbs can be heavy
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   :custom
;;   ;; Crucial for MSP430 clangd support
;;   (lsp-clients-clangd-args 
;;    '("--background-index"
;;      "--clang-tidy"))
;;   :config
;;   (setq lsp-completion-provider :capf
;;         lsp-idle-delay 0.1)
;;   (require 'yasnippet))


(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((c-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)
         (go-mode . lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :custom
  (lsp-enable-on-type-formatting nil)
  (lsp-ui-doc-enable nil)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-completion-provider :capf)
  (lsp-idle-delay 0.1)
  (lsp-clients-clangd-args
   '("--background-index"
     "--clang-tidy"))
  :config
  (require 'yasnippet))

(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :commands lsp-treemacs-errors-list)

(use-package pfuture)
(use-package treemacs)

;; Go Support
(use-package go-mode
  :hook (go-mode . lsp-deferred)
  :config
  (add-hook 'go-mode-hook
            (lambda ()
              (setq tab-width 4
                    indent-tabs-mode 1)
              (add-hook 'before-save-hook #'lsp-format-buffer nil t)
              (add-hook 'before-save-hook #'lsp-organize-imports nil t))))

;; C-specific coding style
(setq-default c-default-style "linux" 
              c-basic-offset 4)

;;; --- 5. AUTOMATICALLY GENERATED (Keep at bottom) ---
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gdb-many-windows t)
 '(gdb-memory-unit 1)
 '(gdb-show-main t)
 '(package-selected-packages
   '(all-the-icons-nerd-fonts company counsel doom-modeline go-mode
			      go-tag helpful ivy-rich lsp-treemacs
			      lsp-ui rainbow-delimiters yasnippet))
 '(safe-local-variable-directories '("/home/coredumpdev/.config/emacs/")))



;; ;; --- WINDOW MANAGEMENT SHORTCUTS ---

;; ;; 1. Switching between panes (Alt + Arrow Keys)
;; (global-set-key (kbd "M-<left>")  'windmove-left)
;; (global-set-key (kbd "M-<right>") 'windmove-right)
;; (global-set-key (kbd "M-<up>")    'windmove-up)
;; (global-set-key (kbd "M-<down>")  'windmove-down)

;; ;; 2. Creating and Deleting panes (Ctrl-c + Arrow Keys)
;; (global-set-key (kbd "C-c <right>") (lambda () (interactive) (split-window-right) (windmove-right)))
;; (global-set-key (kbd "C-c <down>")  (lambda () (interactive) (split-window-below) (windmove-down)))
;; (global-set-key (kbd "C-c <left>")  'delete-window)
;; (global-set-key (kbd "C-c <up>")    'delete-other-windows)

;; ;; 3. Resizing (Your existing logic)
;; (global-set-key (kbd "C-<up>") 'enlarge-window)
;; (global-set-key (kbd "C-<down>") 'shrink-window)
;; (global-set-key (kbd "C-<left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "C-<right>") 'enlarge-window-horizontally)




;; --- WINDOW NAVIGATION (Move Focus) ---
;; Move focus using Alt + Arrow Keys
(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<down>")  'windmove-down)

;; --- WINDOW CREATION (Split & Follow) ---
;; These split the window and immediately move your cursor to the new pane
(global-set-key (kbd "C-c <right>") (lambda () (interactive) (split-window-right) (windmove-right)))
(global-set-key (kbd "C-c <down>") (lambda () (interactive) (split-window-below) (windmove-down)))
(global-set-key (kbd "C-c 0") 'delete-window)

;; --- WINDOW RESIZING (Your existing logic) ---
(global-set-key (kbd "C-<up>") 'enlarge-window)
(global-set-key (kbd "C-<down>") 'shrink-window)
(global-set-key (kbd "C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-<right>") 'enlarge-window-horizontally)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
