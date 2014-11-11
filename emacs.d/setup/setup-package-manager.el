
; initialize package manager

(require 'cl)
(require 'package)

; add melpa repository
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

; add marmalade repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

; if we have an old emacs version, add the gnu repository too
(when (< emacs-major-version 24)
  (add-to-list 'package-archives
               '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(defvar my-packages
  '(ag 
    auto-complete 
    auto-highlight-symbol
    clj-refactor 
    clojure-mode
    dash-at-point
    diminish
    dired-details
    elpy
    enh-ruby-mode
    flx
    flx-ido
    flycheck
    grizzl
    highlight-indentation
    highlight-parentheses
    highlight-symbol
    ido-ubiquitous
    ido-vertical-mode
    jade-mode
    js2-mode
    js2-refactor
    lua-mode
    magit
    markdown-mode
    nrepl
    paredit
    powerline
    projectile
    python-mode
    rainbow-delimiters
    rainbow-mode
    robe
    smartparens
    soft-charcoal-theme
    soft-morning-theme
    web-mode
    yasnippet)
  "A list of required packages to get this config running")


(defun my-packages-installed-p ()
  (loop for package in my-packages
        when (not (package-installed-p package)) do (return nil)
        finally (return t)))

(unless (my-packages-installed-p)
 (message "%s" "refreshing package database...")
 (package-refresh-contents)
 (message "%s" " done.")
 (dolist (p my-packages)
   (when (not (package-installed-p p))
     (package-install p))))


(provide 'setup-package-manager)
