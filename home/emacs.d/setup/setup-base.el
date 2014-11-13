;(require 'dash)

; enable external clipboard
(setq x-select-enable-clipboard t)

; enable window navigation using Shift+<cursor key>
(windmove-default-keybindings)

; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

; setup central backup directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
		 (concat user-emacs-directory "backups")))))

; make backups of version controled files too
(setq vc-make-backup-files t)

; open compressed files
(auto-compression-mode t)

; enable font-locking
(global-font-lock-mode t)

; use utf-8 ...
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

; show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

; delete current selection on insert
(delete-selection-mode 1)

; highlight searches
(setq search-highlight t)

;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

; use spaces!
(set-default 'indent-tabs-mode nil)

; refresh buffers without asking
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

; less info in dired buffers
(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)
(if is-mac
    (setq dired-use-ls-dired nil))


(provide 'setup-base)
