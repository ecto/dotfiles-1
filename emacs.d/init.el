;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ~/.emacs.d/init.el

;; ┬  ┌─┐┬─┐┬─┐┬─┐┬─┐┌┐┐┬ ┬
;; │  │ ││─┤│ ││─┘│─┤ │ │─┤
;; └─┘┘─┘┘ │┴─┘│  ┘ │ │ │ ┴
;;;;;;;;;;;;;;;;;; LOADPATH

(add-to-list 'load-path "~/.emacs.d/vendor/")

;; o┌┐┐┌┐┐┬─┐┬─┐┬─┐┬─┐┌─┐┬─┐
;; ││││ │ ├─ │┬┘├─ │─┤│  ├─ 
;; │ └┘ │ ┴─┘│└┘│  ┘ │└─┘┴─┘
;;;;;;;;;;;;;;;;;; INTERFACE

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode t)
(line-number-mode -1)
(column-number-mode -1)
(size-indication-mode -1)
(desktop-save-mode 0)
(setq x-select-enable-clipboard t
      blink-cursor-blinks 0 ; cursor blinks for ever
      kill-whole-line t
      resize-mini-windows nil ; truncate line in minibuffer
      echo-keystrokes 0.5
      longlines-wrap-follows-window-size t
      display-time-12hr-format t
      display-time-day-and-date nil
      mouse-yank-at-point t
      scroll-conservatively 1
      scroll-preserve-screen-position t
      visible-bell t)
(delete-selection-mode 1) ; delete the selection with a keypress
(setq-default indicate-empty-lines t
              indicate-buffer-boundaries (quote left))
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message "")
(load-theme 'vt100 t)

;; ┌─┐┌─┐┬─┐┬─┐
;; │  │ ││┬┘├─ 
;; └─┘┘─┘│└┘┴─┘
;;;;;;;;;; CORE

(set-terminal-coding-system 'utf-8) ; charset
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)
(require 'iso-transl) ; to restore dead keys
(setq save-interprogram-paste-before-kill t
      apropos-do-all t
      require-final-newline t
      ediff-window-setup-function 'ediff-setup-windows-plain
      mm-text-html-renderer (quote shr) ; use shr to render HTML
      read-file-name-completion-ignore-case 't
)
;; remember your position in buffers
(setq save-place-file "~/.emacs.d/saveplace") ; keep my ~/ clean
(setq-default save-place t) ; activate it for all buffers
(require 'saveplace) 
;; auto-save
(setq auto-save-timeout 90)
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory
			"backups"))))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; when two files have the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)
;; save recent files
(setq recentf-save-file (concat user-emacs-directory "recentf")
      recentf-max-saved-items 200
      recentf-max-menu-items 15)
(recentf-mode t)
;; *scratch*

;; ┬─┐┬─┐┌─┐┬┌ ┬─┐┌─┐┬─┐┐─┐
;; │─┘│─┤│  ├┴┐│─┤│ ┬├─ └─┐
;; │  ┘ │└─┘│ ┘┘ │└─┘┴─┘──┘
;;;;;;;;;;;;;;;;;; PACKAGES

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("SC" . "http://joseito.republika.pl/sunrise-commander/"))
(add-to-list 'package-archives
             '("ELPA" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Check if all the packages I need are present. If not refresh and them.
(setq my-package-list '(auctex auto-capitalize auto-complete dash golden-ratio
                               markdown-mode popup with-editor))
(mapc #'package-install my-package-list)

(when (not package-archive-contents)
  (package-refresh-contents))

;; ┬─┐┬─┐o┌┐┐┌─┐┬─┐
;; ├─ │ ││ │ │ ││┬┘
;; ┴─┘┴─┘│ │ ┘─┘│└┘
;;;;;;;;;;;; EDITOR

(setq ispell-program-name "aspell" ; use aspell instead of ispell
      ispell-extra-args '("--sug-mode=ultra")
      ispell-local-dictionary "fr"
      linum-format "%5d ·" ; for linum-mode
      time-stamp-active t ; for Time-stamp: <>
      time-stamp-line-limit 10 ; check first 10 lines
      time-stamp-format "%04y-%02m-%02d %02H:%02M:%02S (%u)") ; date format
(setq-default indent-tabs-mode nil ; death to the tabs!
              fill-column 78)
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(add-hook 'write-file-hooks 'time-stamp) ; update when saving
(setq auto-mode-alist
      (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist)) ; mutt support
(electric-pair-mode t)

;; ┐ ┬┌─┐┌┌┐┬─┐┌┐┐
;; ││││ │││││─┤│││
;; └┴┘┘─┘┘ │┘ │ └┘
;;;;;;;;;;;; WOMAN

(setq woman-fill-column 78)

;; o┬─┐┌─┐
;; ││ ││ │
;; │┴─┘┘─┘
;;;;;; IDO

(require 'ido)
(ido-mode 'both) ;; for buffers and files
(setq ido-use-faces nil)
(setq
  ido-save-directory-list-file "~/.emacs.d/cache/ido.last"
  ido-ignore-buffers ;; ignore these guys
  '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
     "^\*compilation" "^\*GTAGS" "^session\.*")
  ido-work-directory-list '("~/" "~/x/Droit/")
  ido-case-fold t ; be case-insensitive
  ido-enable-last-directory-history t ; remember last used dirs
  ido-max-work-directory-list 30 ; should be enough
  ido-max-work-file-list 50 ; remember many
  ido-use-filename-at-point nil ; don't use filename at point (annoying)
  ido-use-url-at-point nil ; don't use url at point (annoying)
  ido-enable-flex-matching nil ; don't try to be too smart
  ido-max-prospects 7 ; don't spam my minibuffer
  ido-confirm-unique-completion t ; wait for RET, even with unique completion
  ido-create-new-buffer 'always
  confirm-nonexistent-file-or-buffer nil) ; when using ido, this is annoying
(defun recentf-ido-find-file () ; recent file
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

;; o┬─┐┬ ┐┬─┐┬─┐┬─┐┬─┐
;; ││─││ │├─ ├─ ├─ │┬┘
;; │┴─┘└─┘│  │  ┴─┘│└┘
;;;;;;;;;;;;;; IBUFFER

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("Emacs"
                (or
                 (name . "^\\*scratch\\*$")
                 (name . "^\\*Messages\\*$")
                 (name . "^\\*Completions\\*$")
                 (name . "^\\*Help\\*$")
                 (filename . ".emacs.d/")
                 ))
               ("Dired"
                (mode . dired-mode))
               ("TXT"
                (or
                 (mode . text-mode)
                 (mode . org-mode)
                 (mode . markdown-mode)
                ))
               ("LaTeX"
                (or
                 (mode . tex-mode)
                 (mode . latex-mode)
                 (mode . LaTeX-mode)
                 (mode . bibtex-mode)
                 (mode . reftex-toc-mode)
                 ))
               ("Ebooks"
                (mode . etxt-mode))
               ("WWW"
                (or
                 (mode . w3m-mode)
                 (mode . eww-mode)
                 ))
               ("News/Mail"
                (or 
                 (mode . message-mode)
                 (mode . mail-mode)
                 (mode . message-mode)
                 (mode . bbdb-mode)
                 (mode . mail-mode)
                 (mode . gnus-group-mode)
                 (mode . gnus-summary-mode)
                 (mode . gnus-article-mode)
                 (name . "^\\.bbdb$")
                 (name . "^\\.newsrc-dribble")
                 ))
               ("IRC"
                (or
                 (mode . erc-mode)
                 (mode . rcirc-mode)
                 ))
               ))))
(add-hook 'ibuffer-mode-hook
  (lambda ()
    (ibuffer-switch-to-saved-filter-groups "default")))

;; ┬─┐┌─┐o┬─┐┌─┐
;; │┬┘│  ││┬┘│  
;; │└┘└─┘││└┘└─┘
;;;;;;;;;; RCIRC

(setq rcirc-default-nick "f6k"
      rcirc-default-user-name "FGK"
      rcirc-default-full-name "FGK"
      rcirc-fill-prefix ""
      rcirc-fill-column (quote frame-width)
      rcirc-server-alist (quote (("irc.freenode.net" :channels ("#emacs" "##slackware" "#nethack")))))
(rcirc-track-minor-mode 1)

;; ┬─┐o┬─┐┬─┐┬─┐
;; │ │││┬┘├─ │ │
;; ┴─┘││└┘┴─┘┴─┘
;;;;;;;;;; DIRED

;; omit-files
(require 'dired-x)
(setq-default dired-omit-files-p t) ; this is buffer-local variable
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
;; external viewer for image-dired
(setq image-dired-external-viewer "/usr/bin/feh -d.")
;; switch
(setq dired-listing-switches "-alF")
(setq dired-ls-F-marks-symlinks t)

;; ┬  ┬─┐┌┐┐┬─┐┐ │
;; │  │─┤ │ ├─ ┌┼┘
;; └─┘┘ │ │ ┴─┘│ └
;;;;;;;;;;;; LATEX

(require 'latex)
;; compile documents to PDF by default
(setq TeX-PDF-mode t)
;; load some minor modes with latex-mode
(add-hook 'LaTeX-mode-hook
  (lambda()
     (flyspell-mode 1)
     ;; (ruler-mode 1) % commented because it slowing C-x C-s!
     ;; (linum-mode 1)
     (auto-fill-mode 1)
     (auto-complete-mode 1)
     (auto-capitalize-mode 1)
     (reftex-mode 1)
     (abbrev-mode 1)
 ))
;; user pdf reader to view pdf files
(setq TeX-view-program-list '(("zathura" "zathura %o")))
(setq TeX-view-program-selection '((output-pdf "zathura")))
;; add C-h to C-c C-f (TeX-font-list) for hl{} (from csquotes.sty)
(add-to-list 'LaTeX-font-list '(?\C-h "\\hl{" "}"))
;;(add-to-list 'TeX-font-list '(?h "\\hl{" "}"))
;; integrate RefTeX with AUCTeX
(setq reftex-plug-into-AUCTeX t)

;; ┐─┐┌┌┐┬  
;; └─┐││││  
;; ──┘┘ │└─┘
;;;;;;;; SML

(require 'smart-mode-line)
(sml/setup)
(setq sml/replacer-regexp-list
   (quote
    (("^~/\\.emacs\\.d/" ":ED:")
     ("^/sudo:.*:" ":SU:")
     ("^~/g/" ":GIT:")     
     ("^~/x/Droit/" ":DROIT:"))))

;; ┬─┐┬ ┐┌┐┐┌─┐  ┌─┐┬─┐┬─┐o┌┐┐┬─┐┬  o┌─┐┬─┐
;; │─┤│ │ │ │ │──│  │─┤│─┘│ │ │─┤│  │┌─┘├─ 
;; ┘ │└─┘ │ ┘─┘  └─┘┘ ││  │ │ ┘ │└─┘│└─┘┴─┘
;;;;;;;;;;;;;;;;;;;;;;;;;;; AUTO-CAPITALIZE

(require 'auto-capitalize)

;; ┬─┐┌┐┐┐ │┌┐┐
;; ├─  │ ┌┼┘ │ 
;; ┴─┘ │ │ └ │ 
;;;;;;;;;; ETXT

(require 'etxt)

;; ┐ ┬┌─┐┌┌┐
;; │││ ─┤│││
;; └┴┘└─┘┘ │
;;;;;;;; W3M

(require 'w3m-load)
(setq w3m-use-tab nil
      w3m-use-tab-menubar nil
      w3m-use-title-buffer-name t
      w3m-session-show-titles t
      w3m-use-cookies t
      w3m-display-inline-image t
      mm-text-html-renderer 'w3m
      mm-inline-text-html-with-images t
      mm-inline-text-html-renderer 'mm-inline-text-html-render-with-w3m
      w3m-default-display-inline-images nil
      w3m-toggle-inline-images-permanently t)

; launch w3m by default when needed to browse url
(setq browse-url-browser-function 'w3m-goto-url-new-session)

;; ┌─┐┌─┐┬  ┬─┐┬─┐┌┐┐  ┬─┐┬─┐┌┐┐o┌─┐
;; │ ┬│ ││  │ │├─ │││  │┬┘│─┤ │ ││ │
;; └─┘┘─┘└─┘┴─┘┴─┘ └┘  │└┘┘ │ │ │┘─┘
;;;;;;;;;;;;;;;;;;;;;;; GOLDEN RATIO

(require 'golden-ratio)
(golden-ratio-mode 1)

;; ┐ ┬┬─┐┬─┐  ┬┬ ┐┌┌┐┬─┐
;; │││├─ │─│┌ ││ │││││─┘
;; └┴┆┴─┘┴─┘└─┘└─┘┘ ││  
;;;;;;;;;;;;;;;; WEBJUMP

(setq webjump-sites
      (append '(
                ("Wikipedia_en" . [simple-query "en.wikipedia.org" "http://en.wikipedia.org/wiki/Special:Search?search=" ""])
                ("Wikipedia_fr" . [simple-query "fr.wikipedia.org" "http://fr.wikipedia.org/wiki/Special:Search?search=" ""])
                ("Wiktionary_fr" . [simple-query "fr.wiktionary.org" "http://fr.wiktionary.org/wiki/Special:Search?search=" ""])
                ("Google" . [simple-query "google.com" "http://www.google.com/search?q=" "&ie=utf-8&oe=utf-8"])
                )))

;; ┬─┐┬ ┐┌┐┐┌─┐  ┌─┐┌─┐┌┌┐┬─┐┬  ┬─┐┌┐┐┬─┐
;; │─┤│ │ │ │ │──│  │ │││││─┘│  ├─  │ ├─ 
;; ┘ │└─┘ │ ┘─┘  └─┘┘─┘┘ ││  └─┘┴─┘ │ ┴─┘
;;;;;;;;;;;;;;;;;;;;;;;;;;; AUTO-COMPLETE

(require 'auto-complete-config)
(ac-config-default)
(ac-flyspell-workaround) ; to avoid bug with flyspell-mode
(setq ac-auto-show-menu nil) ; don't show any menu

;; ┬─┐┐ │┌┐┐┬─┐┬─┐  ┌─┐┌─┐┬─┐┬─┐
;; ├─ ┌┼┘ │ │┬┘│─┤  │  │ ││ │├─ 
;; ┴─┘│ └ │ │└┘┘ │  └─┘┘─┘┴─┘┴─┘
;;;;;;;;;;;;;;;;;;;;; EXTRA CODE

(defun insert-date () ; insert the current date
  "Insert a time-stamp according to locale's date and time format."
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S %z" (current-time))))
;; a little thing for "sniping" (cuting out) some text and replacing it
;; by [snip: irrelevant chatter (15 lines)] (usefull for newsgroup)
(defun snip-it (b e summ)
  "remove selected lines, and replace it with [snip:summary (n lines)]"
  (interactive "r\nsSummary:")
  (let ((n (count-lines b e)))
    (delete-region b e)
    (insert (format "[snip%s (%d line%s)]"
              (if (= 0 (length summ)) "" (concat ": " summ))
              n
              (if (= 1 n) "" "s")))))

;; ┬┌ ┬─┐┐ ┬┬─┐o┌┐┐┬─┐o┌┐┐┌─┐┐─┐
;; ├┴┐├─ └┌┘│─││││││ ││││││ ┬└─┐
;; │ ┘┴─┘ │ ┴─┘│ └┘┴─┘│ └┘└─┘──┘
;;;;;;;;;;;;;;;;;;;; KEYBINDINGS

;; the keys I don't want
(global-unset-key "\C-z")
(global-unset-key (kbd "C-x C-q"))
;; add some basic things
(global-set-key (kbd "C-x C-q") 'view-mode)
(global-set-key (kbd "C-ù") 'other-window)
(global-set-key [(meta g)] 'goto-line)
;; File finding
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)
;; replace buffer-menu with ibuffer
;; (global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
;; resize
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
;; magit-status
(global-set-key (kbd "C-c C-g") 'magit-status)
