;;; init.el --- Configuration of Emacs
;;
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'org)
(require 'ob-tangle)

(setq init-dir (file-name-directory (or load-file-name (buffer-file-name))))
(org-babel-load-file (expand-file-name "config.org" init-dir))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("715fdcd387af7e963abca6765bd7c2b37e76154e65401cd8d86104f22dd88404" default)))
 '(linum-format (quote "%4d"))
 '(package-selected-packages
   (quote
    (prettier-js go-mode yaml-mode php-mode yasnippet evil-nerd-commenter rainbow-delimiters js2-mode f flycheck default-text-scale general evil-matchit markdown-mode nlinum evil-magit magit quelpa package-build rjsx which-key ivy use-package tuareg projectile merlin helm hamburg-theme exec-path-from-shell evil-visual-mark-mode evil-surround company)))
 '(safe-local-variable-values
   (quote
    ((cider-refresh-after-fn . "server.repl/post-refresh")
     (cider-refresh-before-fn . "server.repl/pre-refresh")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
