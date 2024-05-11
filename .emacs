(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(setq visible-bell t)
(setq select-enable-clipboard t)
(mouse-avoidance-mode 'exile)
(setq frame-title-format "Emacs")
(setq warning-minimum-level :emergency)
(defun sda/set-font-face ()
  (set-face-attribute 'default nil :font "DejaVuSansM Nerd Font 10")
  (add-to-list 'default-frame-alist '(alpha-background . 90)))

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (sda/set-font-face)))))
(sda/set-font-face)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-verbose t)

(use-package nerd-icons
  :custom
  (nerd-icon-font-family "DejaVuSansM Nerd Font"))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package doom-modeline
  :init (doom-modeline-mode t)
  :custom ((doom-modeline-height 4)))

(use-package all-the-icons)

(use-package doom-themes
  :init (load-theme 'doom-palenight t))

(column-number-mode)
(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook
                shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(defun sda/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  ;; Disable org indent
  (setq org-adapt-indentation nil)

  (setq org-html-htmlize-output-type 'inline-css)
  
  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "DejaVu Sans Mono" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(defun sda/org-mode-setup ()
  (org-indent-mode)
  (turn-on-font-lock)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (setq org-html-validation-link nil)
  (setq evil-auto-indent nil)
  (setq org-link-elisp-confirm-function nil)
  (setq org-export-backends
	'(ascii html icalendar latex md odt))
  (setq org-todo-keywords
	'((sequence "TODO" "In Process" "|" "Done" "Abandoned"))))

(use-package org
  :hook (org-mode . sda/org-mode-setup)
  :config
  (sda/org-font-setup))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun sda/org-mode-visual-fill()
  (setq visual-fill-column-width 150
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . sda/org-mode-visual-fill))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-bable-load-languages
   '((emacs-lisp . t)))
  (setq org-confirm-babel-evaluate nil))

(with-eval-after-load 'org
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("ht" . "src html"))
  (add-to-list 'org-structure-template-alist '("md" . "src markdown"))
  (add-to-list 'org-structure-template-alist '("nx" . "src nix"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("pw" . "src powershell")))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(setq ispell-program-name "hunspell")

;; "en_US" is key to lookup in `ispell-local-dictionary-alist'.
;; Please note it will be passed as default value to hunspell CLI `-d` option
;; if you don't manually setup `-d` in `ispell-local-dictionary-alist`
(setq ispell-local-dictionary "en_US")

(setq ispell-local-dictionary-alist
      '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))

(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(add-hook 'message-mode-hook 'turn-on-flyspell)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'flyspell-prog-mode)
(defun turn-on-flyspell ()
  "Force flyspell-mode on using a positive arg.  For use in hooks."
  (interactive)
  (flyspell-mode 1))

(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined)))

(require 'htmlize)
(require 'nix-mode)
(require 'string-inflection)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Custom functions
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun sda/new-post ()
  (interactive)
  (setq new-blog-post-title (read-from-minibuffer "Post name: "))
  (setq new-blog-post-tags (read-from-minibuffer "Tags: "))
  (setq new-blog-post-slug (downcase (replace-regexp-in-string "[^[:alpha:][:digit:]_-]" "" (string-replace " " "-" new-blog-post-title))))
  (setq new-blog-post-filename-base (string-inflection-lower-camelcase-function (string-replace " " "_" new-blog-post-title)))
  (setq new-blog-post-file (concat "./content/blog/" new-blog-post-filename-base ".org"))
  (setq new-blog-title-line (concat "#+HTML_HEAD: <title>" new-blog-post-title "</title>"))
  (setq new-blog-date-line (concat "#+HTML_HEAD: <meta name=\"date\" content=\"" (format-time-string "%Y-%m-%d") "\" />"))
  (setq new-blog-slug-line (concat "#+HTML_HEAD: <meta name=\"slug\" content=\"" new-blog-post-slug "\" />"))
  (setq new-blog-keywords-line (concat "#+HTML_HEAD: <meta name=\"keywords\" content=\"" new-blog-post-tags "\" />"))
  (setq new-blog-language-line "#+HTML_HEAD: <meta name=\"language\" content=\"en\" />")
  (setq new-blog-author-line "#+AUTHOR: SpeDAllen")
  (setq new-blog-options-line "#+options: toc:nil num:nil ^:nil html-postamble:nil")
  (setq new-blog-filename-line (concat "#+EXPORT_FILE_NAME: " new-blog-post-filename-base))
  (let ((org-capture-templates
        `(("p" "New Pelican blog post" plain (file new-blog-post-file)
           ,(concat new-blog-title-line "\n" new-blog-date-line "\n" new-blog-keywords-line "\n" new-blog-slug-line "\n" new-blog-language-line "\n" new-blog-author-line "\n" new-blog-options-line "\n" new-blog-filename-line "\n\n")))
	)) (org-capture)))

