
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for editing Ruby files" t)


(setq enh-ruby-bounce-deep-indent t)
(setq enh-ruby-hanging-brace-indent-level 2)

(require 'cl)

(defun* get-closest-gemfile-dir (&optional (file "Gemfile"))
  (let (root (expand-file-name "/")))
    (loop
     for d = default-directory then (expand-file-name ".." d)
     (if (file-exists-p (expand-file-name file d))
         return d
         if (equal d root)
         return nil)))
                      
(require 'compile)

(defun rspec-compile-file ()
  (interactive)
  (compile (format "cd %s;bundle exec rspec %s"
                   (get-closest-gemfile-dir)
                   (file-relative-name (buffer-file-name) (get-closest-gemfile-dir))) t))

(defun rspec-compile-on-line ()
  (interactive)
  (compile (format "cd %s;bundle exec rspec %s -l %s"
                   (get-closest-gemfile-dir)
                   (file-relative-name (buffer-file-name) (get-closest-gemfile-dir))
                   (line-number-at-pos)) t))

(add-hook 'enh-ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c l") 'rspec-compile-on-line)
            (local-set-key (kbd "C-c k") 'rspec-compile-file)))

(provide 'setup-ruby-mode)

