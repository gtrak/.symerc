;; A lighter-weight init.el for 24

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (null package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(better-defaults
                      idle-highlight-mode
                      elisp-slime-nav paredit
                      smex scpaste parenface-plus
                      find-file-in-project magit
                      cider
                      doremi
                      doremi-cmd
                      doremi-frm))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(smex-initialize)

(setq-default ispell-program-name "aspell")

(set-face-foreground 'vertical-border "white")

(when (<= (display-color-cells) 8)
  (defun hl-line-mode () (interactive)))

;;; bindings

(eval-after-load 'paredit
  ;; need a binding that works in the terminal
  '(progn
     (define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M-(") 'paredit-backward-slurp-sexp)))

;;; programming

(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'idle-highlight-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)

(add-hook 'clojure-mode-hook 'paredit-mode)

(add-hook 'nrepl-connected-hook
          (defun pnh-clojure-mode-eldoc-hook ()
            (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)))

(setq whitespace-style '(face trailing lines-tail tabs))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(define-key emacs-lisp-mode-map (kbd "C-c v") 'eval-buffer)

(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)
