(require 'paren)
(show-paren-mode)
(setq-default dabbrev-case-replace nil)
(setq-default dabbrev-abbrev-skip-leading-regexp "\\$")
(setq column-number-mode t)
(put 'narrow-to-region 'disabled nil)
(require 'font-lock)
(global-font-lock-mode t)

(setq font-lock-maximum-decoration
  '((c-mode . 3) (c++-mode . 3) (tcl-mode . 3)))

;; Index menu
(require 'imenu)
(add-hook 'c-mode-hook (function (lambda () (imenu-add-menubar-index))))
(add-hook 'c++-mode-hook (function (lambda () (imenu-add-menubar-index))))
(add-hook 'cperl-mode-hook (function (lambda () (imenu-add-menubar-index))))
(add-hook 'java-mode-hook (function (lambda () (imenu-add-menubar-index))))
(add-hook 'tcl-mode-hook (function (lambda () (imenu-add-menubar-index))))
(require 'msb)
;; handle .hpp as cc-mode files
(setq auto-mode-alist (cons '("\\.hpp$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.yac$" . c++-mode) auto-mode-alist))

;;ME paren matching
(defun jumpmatch ()
  (interactive)
  (let (pos dir)
    (cond ((eq (char-syntax (preceding-char)) ?\))
	     (setq dir -1))
	    ((eq (char-syntax (following-char)) ?\()
	     (setq dir 1)))
;;; Now dir is 1/-1 for forward/backward search or 0 for non paren char
    (when dir 
      (condition-case ()
	  (setq pos (scan-sexps (point) dir))
	(error (setq pos t mismatch t)))
      (when (integerp pos)
	(push-mark)
	(goto-char pos)))))

;; Binding
;;(define-key esc-map "\C-f" 'jumpmatch)

;; Desktop to Fn keys
;;(global-set-key [f1]         'nonincremental-search-forward)
;;(global-set-key [f2]         'nonincremental-search-backward)
;;(global-set-key [f3]         'nonincremental-repeat-search-forward)
;;(global-set-key [f4]         'nonincremental-repeat-search-backward)
;;(global-set-key [f8]         'goto-line)
;;(global-set-key [f9]         'save-buffer)
;;(global-set-key [f10]        'save-buffers-kill-emacs)


;;(global-set-key [f9]      'desktop-save)
;;(global-set-key [f10]      'desktop-clear)
;;(global-set-key [f11]      'desktop-read)

;; auctex 
;; (require 'tex-site)

;; 
;; (set-language-environment "Latin-2")

;; Request y/nm only
(fset 'yes-or-no-p 'y-or-n-p)
(auto-fill-mode)
(setq tex-dvi-view-command "xdvi")

;; Autoload for PO mode
(autoload 'po-mode "po-mode")
(setq auto-mode-alist (cons '("\\.po[tx]?\\'\\|\\.po\\." . po-mode)
				  auto-mode-alist))

;; GNUS
(setq gnus-select-method '(nntp "pentix.imp.bg.ac.yu"))
;; display-time customization - I don't need load  
(setq display-time-s1tring-forms
      (list '(if
		(and
		 (not display-time-format)
		 display-time-day-and-date)
		(format-time-string "%e/%Y " now)
	      "")
	    '(format-time-string
	     (or display-time-format
		 (if display-time-24hr-format "%H:%M" "%-I:%M%p"))
	     now)))
;	    'load
;	    '(if mail " Mail" "")))
;;(setq display-time-day-and-date 't)
;; (tool-bar-mode)
(display-time)
;; p4 mode - load on linux box only
;; (cond ((string-match "linux" system-configuration)
;; 	  (message "Loading P4 support")
;; 	  (load-library "~smarkovic/elisp/p4.elc")
;; )
;; )

;; emacs server
(server-start)

;;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-offsets-alist (quote ((arglist-cont-nonempty . +) (arglist-close . 0) (inextern-lang . 0) (innamespace . 0))))
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "Latin-2")
 '(default-input-method "latin-2-prefix")
 '(delete-selection-mode nil nil (delsel))
 '(display-time-mode t)
 '(ecb-layout-name "left11")
 '(ecb-layout-window-sizes (quote (("left11" (0.24545454545454545 . 0.6037735849056604) (0.24545454545454545 . 0.37735849056603776)))))
 '(global-font-lock-mode t nil (font-lock))
 '(load-home-init-file t t)
 '(py-python-command "python26")
 '(recentf-max-saved-items 128)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t nil (paren))
 '(tab-width 4)
 '(tool-bar-mode nil))

;; since 1998
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))
(global-set-key "%" 'match-paren)


(global-set-key "\e2" 'goto-line)
(global-set-key "\e3" 'recompile)
;; Jump to the next tag
(global-set-key "\e7" '"^UESCxfind-tag")

;;
(add-to-list 'load-path "~/elisp")
(require 'recentf)
(recentf-mode)
(require 'xcscope)

(add-to-list 'auto-mode-alist
             '("\\.py\\'" . python-mode))

(setq which-func-modes 't)
(setq which-func-mode 't)

(setq-default indent-tabs-mode nil)

(iswitchb-mode 't)
(setq iswitchb-default-method 'samewindow)

(setq default-tab-width 4)
(which-function-mode 1)

;; gtags
(add-to-list 'load-path "/usr/local/share/gtags")
(autoload 'gtags-mode "gtags" "" t)

(add-hook 'gtags-mode-hook 
  (lambda()
    (local-set-key (kbd "M-.") 'gtags-find-tag)   ; find a tag, also M-.
    (local-set-key (kbd "M-,") 'gtags-find-rtag)))  ; reverse tag

(add-hook 'c-mode-common-hook
  (lambda ()
    (require 'gtags)
    (gtags-mode t)))
(add-hook 'c++-mode-common-hook
  (lambda ()
    (require 'gtags)
    (gtags-mode t)))

(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
        (buffer-substring (point-min) (1- (point-max)))
      nil)))

(defun gtags-update ()
  "Make GTAGS incremental update"
  (call-process "global" nil nil nil "-u"))

(defun gtags-update-hook ()
  (when (gtags-root-dir)
    (gtags-update)))

(add-hook 'after-save-hook #'gtags-update-hook)

(scroll-bar-mode 0)
(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 93 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

(menu-bar-mode -1)
;; (add-to-list 'default-frame-alist
;;              '(font . "DejaVu Sans Mono-10"))
(setq grep-find-command "find . -type f '!' -wholename '*/.svn/*' -print0 | xargs -0 -e grep -nH -e ")

;; emacs 24
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; add this if you need elpa in .emacs
(package-initialize)

;; flymake
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-gcc-include-path
                           (list "/workspace/blackbird/plx/poc" "/workspace/blackbird/dpdk/x86_64-wsm-linuxapp-gcc/include"))))
