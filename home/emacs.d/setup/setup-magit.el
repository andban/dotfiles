
; open magit in fullscreen and reset windows to previous configuration when done
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(autoload 'magit-status "magit" nil t)
(global-set-key "\C-ci" 'magit-status)

(eval-after-load 'magit-status '((defun magit-quit-session ()
                                   "Restores the previous window configuration and kills the magit buffer."
                                   (interactive)
                                   (kill-buffer)
                                   (jump-to-register :magit-fullscreen))
                                 
                                 (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

                                        ; toggle whitespace changes from diffs
                                 (defun magit-toggle-whitespace ()
                                   (interactive)
                                   (if (member "-w" magit-diff-options)
                                       (magit-dont-ignore-whitespace)
                                     (magit-ignore-whitespace)))
                                 
                                 (defun magit-ignore-whitespace ()
                                   (interactive)
                                   (add-to-list 'magit-diff-options "-w")
                                   (magit-refresh))
                                 
                                 (defun magit-dont-ignore-whitespace ()
                                   (interactive)
                                   (setq magit-diff-options (remove "-w" magit-diff-options))
                                   (magit-refresh))
                                 
                                 (define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)))
                                 
(provide 'setup-magit)
