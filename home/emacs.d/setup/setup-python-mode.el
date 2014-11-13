;(require 'python-mode)

(require 'highlight-indentation)

(add-hook 'python-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))


(provide 'setup-python-mode)
