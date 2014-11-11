(require 'grizzl)

(projectile-global-mode)

(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)

; cmd-p for find in project
(global-set-key (kbd "s-p") 'projectile-find-file)

; cmd-b for find buffer
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)

(provide 'setup-projectile)

