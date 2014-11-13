(add-hook 'lua-mode-hook
          '(lambda ()
             (setq lua-indent-level 4)
             (flymake-mode)))

(provide 'setup-lua-mode)
