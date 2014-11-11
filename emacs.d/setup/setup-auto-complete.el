

(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

(setq ac-ignore-case nil)

(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'python-mode)

(provide 'setup-auto-complete)
