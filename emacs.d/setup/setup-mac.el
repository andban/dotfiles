(setq mac-option-modifier 'nil) ; keep the alt key for special characters
(setq mac-command-modifier 'meta)
(setq mac-function-modifier 'super)


;; mac friendly font
(when window-system
  (setq default-font "-apple-Menlo-medium-normal-normal-*-12-*-*-*-*-*-mac-roman")
  (setq presentation-font "-apple-Monaco-medium-normal-normal-*-28-*-*-*-*-*-mac-roman")
  (set-face-attribute 'default nil :font default-font))

;; 
(global-set-key [kp-delete] 'delete-char)

;; keybinding to toggle full screen mode
(global-set-key (quote [M-f10]) (quote ns-toggle-fullscreen))

;; Move to trash when deleting stuff
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash/emacs")

;; Ignore .DS_Store files with ido mode
;(add-to-list 'ido-ignore-files "\\.DS_Store")

;; Don't open files from the workspace in a new frame
(setq ns-pop-up-frames nil)

;; query Dash.app for the current word
(require 'dash-at-point)
(global-set-key "\C-cd" 'dash-at-point)

(setenv "PATH"
        (concat "/usr/texbin" ":" 
                (getenv "PATH")))

(provide 'setup-mac)
