
; keep GUI to a minimum
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

; keep the mode line clean...

(require 'diminish)
(eval-after-load "smartparens" '(diminish 'smartparens-mode))

; .. just to make the mode line fancy again
(require 'powerline)
(powerline-default-theme)

(setq visible-bell t
      font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

(global-hl-line-mode 1)

(defun use-default-theme ()
  (interactive)
  ;(disable-theme 'twilight)
  (when (boundp 'magnars/default-font)
    (set-face-attribute 'default nil :font magnars/default-font))
  (load-theme 'soft-charcoal))

(use-default-theme)

; keep the contents of the screen fresh
(setq redisplay-dont-pause t)

; show me the counter parts of those
(show-paren-mode 1)

; setup stuff when running in a window manager
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))


(provide 'setup-appearance)
