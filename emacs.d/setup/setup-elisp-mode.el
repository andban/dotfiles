; paredit
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

; colorful parentheses hightlights
(require 'highlight-parentheses)
(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
(add-hook 'emacs-list--mode-hook 'smartparens-mode)

(provide 'setup-elisp-mode)
