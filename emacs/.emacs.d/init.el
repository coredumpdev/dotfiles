(setq inhibit-splash-screen t)
(add-hook 'window-setup-hook 'toggle-frame-maximized t)
(setq c-default-style "linux" c-basic-offset 4)
(electric-pair-mode 1)

(set-face-attribute 'default nil :font "0xProto Nerd Font-18")

(load "~/.emacs.d/themes/catppuccin/catppuccin-theme.el")

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/catppuccin")

(load-theme 'catppuccin t)


(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(global-display-line-numbers-mode t)
(custom-set-variables
 '(gdb-many-windows t)
 '(gdb-memory-unit 1)
 '(gdb-show-main t))
(custom-set-faces)
