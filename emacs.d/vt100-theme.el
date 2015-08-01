;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; vt100-theme.el

;; CC-BY 4.0 FGK <f6k@opmbx.org>
;; Last updated Time-stamp: <2015-08-01 14:08:02 (f6k)>

;; vt100-theme.el is a dark monochrome theme for Emacs 24 based on the
;; monochrome theme by Xavier Noria <fxn@hashref.com> [copyright (C) 2011-2014]
;;
;; Just throw this file into ~/.emacs.d and
;;
;;     M-x load-theme RET vt100 RET
;;
;; or put in your init file
;;
;;     (load-theme 'vt100)
;;
;; Works with Emacs 24.

;; ┬─┐┬─┐┬─┐o┌┐┐o┌┐┐o┌─┐┌┐┐
;; │ │├─ ├─ │││││ │ ││ ││││
;; ┴─┘┴─┘│    └┘  │  ┘─┘ └┘
;;;;;;;;;;;;;;;; DEFINITION

(deftheme vt100
  "White on black monochromatic vt100 terminal.")

(let ((class '((class color) (min-colors 10)))
      (black "black")
      (white "#fcefba")
      (lgray "light gray")
      (dgray "gray30"))

  (custom-theme-set-faces
   'vt100

;; ┬─┐┬─┐┐─┐o┌─┐
;; │─││─┤└─┐││
;; ┴─┘┘ │──┘ └─┘
;;;;;;;;;; BASIC

`(default ((,class (:foreground ,white :background ,black))))
`(cursor ((,class (:background ,white))))

;; ┬ ┬o┌─┐┬ ┬┬  o┌─┐┬ ┬┌┐┐o┌┐┐┌─┐
;; │─┤││ ┬│─┤│  ││ ┬│─┤ │ │││││ ┬
;; │ ┴ └─┘│ ┴└─┘ └─┘│ ┴ │   └┘└─┘
;;;;;;;;;;;;;;;;;;;; HIGHLIGHTING

`(fringe ((,class (:foreground ,white :background ,black))))
`(highlight ((,class (:foreground ,black :background ,white))))
`(region ((,class (:foreground ,black :background ,white))))
`(secondary-selection ((,class (:foreground: ,black :background ,lgray))))
`(isearch ((,class (:foreground ,black :background ,white))))
`(lazy-highlight ((,class (:foreground ,black :background ,lgray))))
`(linum ((,class (:foreground ,white))))
`(trailing-whitespace ((,class (:background "red"))))
`(header-line ((,class (:background ,black :foreground ,white))))

;; ┌┌┐┌─┐┬─┐┬─┐  ┬  o┌┐┐┬─┐
;; ││││ ││ │├─   │  ││││├─
;; ┘ │┘─┘┴─┘┴─┘  └─┘  └┘┴─┘
;;;;;;;;;;;;;;;;; MODE LINE

`(mode-line ((t (:background ,black :foreground ,white))))
`(mode-line-buffer-id ((t (:background ,black :foreground ,white
                                       :weight bold))))
`(mode-line-inactive ((t (:inherit mode-line :background ,black
                                   :foreground ,white :weight light))))

;; ┬─┐┐─┐┌─┐┬─┐┬─┐┬─┐  ┬─┐┌┐┐┬─┐  ┬─┐┬─┐┌─┐┌┌┐┬─┐┌┐┐
;; ├─ └─┐│  │─┤│─┘├─   │─┤││││ │  │─┘│┬┘│ │││││─┘ │
;; ┴─┘──┘└─┘┘ ││  ┴─┘  ┘ │ └┘┴─┘  │  │└┘┘─┘┘ ││   │
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ESCAPE AND PROMPT

`(minibuffer-prompt ((,class (:foreground ,white))))
`(escape-glyph ((,class (:foreground ,lgray))))
`(error ((,class (:weight bold :slant italic :foreground "red"))))
`(warning ((,class (:foreground "yellow"))))
`(success ((,class (:foreground "green"))))

;; ┬─┐┌─┐┌┐┐┌┐┐  ┬  ┌─┐┌─┐┬┌
;; ├─ │ ││││ │   │  │ ││  ├┴┐
;; │  ┘─┘ └┘ │   └─┘┘─┘└─┘│ ┘
;;;;;;;;;;;;;;;;;;; FONT LOCK

`(font-lock-builtin-face ((,class (:foreground ,white))))
`(font-lock-comment-face ((,class (:slant italic :foreground ,white))))
`(font-lock-constant-face ((,class (:foreground ,white))))
`(font-lock-function-name-face ((,class (:foreground ,white))))
`(font-lock-keyword-face ((,class (:foreground ,white))))
`(font-lock-string-face ((,class (:foreground ,white))))
`(font-lock-type-face ((,class (:foreground ,white))))
`(font-lock-variable-name-face ((,class (:weight bold :foreground ,white))))
`(font-lock-warning-face ((,class (:foreground ,white))))

;; ┬─┐┬ ┐┌┐┐┌┐┐┌─┐┌┐┐  ┬─┐┌┐┐┬─┐  ┬  o┌┐┐┬┌
;; │─││ │ │  │ │ ││││  │─┤││││ │  │  ││││├┴┐
;; ┴─┘└─┘ │  │ ┘─┘ └┘  ┘ │ └┘┴─┘  └─┘  └┘│ ┘
;;;;;;;;;;;;;;;;;;;;;;;;;;;; BUTTON AND LINK

`(link ((,class (:underline t :foreground ,white))))
`(link-visited ((,class (:underline t :foreground ,lgray))))

;; ┐─┐┬ ┬┌─┐┐ ┬  ┬─┐┬─┐┬─┐┬─┐┌┐┐
;; └─┐│─┤│ ││││──│─┘│─┤│┬┘├─ │││
;; ──┘│ ┴┘─┘└┴┘  │  ┘ ││└┘┴─┘ └┘
;;;;;;;;;;;;;;;;;;;;; SHOW-PAREN

`(show-paren-match ((t (:background ,white :foreground ,black))))
`(show-paren-mismatch ((t (:background "red"))))

;; ┐ ┬┬ ┬o┌┐┐┬─┐┐─┐┬─┐┬─┐┌─┐┬─┐  ┌┌┐┌─┐┬─┐┬─┐
;; ││││─┤│ │ ├─ └─┐│─┘│─┤│  ├─ ──││││ ││ │├─
;; └┴┘│ ┴  │ ┴─┘──┘│  ┘ │└─┘┴─┘  ┘ │┘─┘┴─┘┴─┘
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; WHITESPACE-MODE

`(whitespace-empty ((,class (:background unspecified :foreground "red"))))
`(whitespace-line ((,class (:background ,black :foreground ,white))))
`(whitespace-space ((,class (:background ,black :foreground ,dgray))))
`(whitespace-newline ((,class (:background ,black :foreground ,dgray))))
`(whitespace-trailing ((,class (:background ,black :foreground "red"))))
`(whitespace-identation ((, class (:background ,black :foreground ,dgray))))
`(whitespace-space-after-tab ((, class (:background ,black
                                                    :foreground ,dgray))))

;; ┐─┐┬─┐┬─┐┬─┐┬─┐┬─┐┬─┐┬─┐
;; └─┐│─┘├─ ├─ │ ││─││─┤│┬┘
;; ──┘│  ┴─┘┴─┘┴─┘┴─┘┘ ││└┘
;;;;;;;;;;;;;;;;;; SPEEDBAR

`(speedbar-button-face ((,class (:foreground ,lgray))))
`(speedbar-file-face ((,class (:foreground ,lgray))))
`(speedbar-directory-face ((,class (:weight bold :foreground ,white))))
`(speedbar-tag-face ((,class (:foreground ,lgray))))
`(speedbar-selected-face ((,class (:underline ,lgray :foreground ,lgray))))
`(speedbar-highlight-face ((,class (:weight bold :background ,black
                                            :foreground ,white))))
;; ┬─┐┬ ┐┬  ┬─┐┬─┐
;; │┬┘│ ││  ├─ │┬┘
;; │└┘└─┘└─┘┴─┘│└┘
;;;;;;;;;;;; RULER

`(ruler-mode-default ((t (:inherit default :background ,black
                                   :foreground ,white))))
`(ruler-mode-column-number ((t (:inherit ruler-mode-default
                                         :foreground ,white))))
`(ruler-mode-current-column ((t (:inherit default :weight bold))))
`(ruler-mode-fill-column ((t (:inherit default :weight bold))))
`(ruler-mode-comment-column ((t (:inherit default :weight bold))))

;; ┬─┐┌─┐o┬─┐┌─┐
;; │┬┘│  ││┬┘│
;; │└┘└─┘ │└┘└─┘
;;;;;;;;;; RCIRC

`(rcirc-prompt ((t (:foreground "default"))))
`(rcirc-server ((t (:foreground "default"))))
`(rcirc-server-prefix ((t (:foreground "default"))))
`(rcirc-timestamp ((t (:foreground "default"))))
`(rcirc-url ((t (:foreground "default"))))
`(rcirc-other-nick ((t (:foreground "default"))))
`(rcirc-my-nick ((t (:foreground "default"))))
`(rcirc-nick-in-message ((t (:foreground "default"))))

;; o┬─┐┌─┐
;; ││ ││ │
;;  ┴─┘┘─┘
;;;;;; IDO

`(ido-first-match ((,class (:foreground ,white))))
`(ido-only-match ((,class (:underline ,white :foreground ,white))))
`(ido-subdir ((,class (:weight bold :foreground ,white))))

;; ┌─┐┌┐┐┬ ┐┐─┐
;; │ ┬││││ │└─┐
;; └─┘ └┘└─┘──┘
;;;;;;;;;; GNUS

`(gnus-group-news-1 ((,class (:weight bold :foreground ,white))))
`(gnus-group-news-1-low ((,class (:foreground ,white))))
`(gnus-group-news-2 ((,class (:weight bold :foreground ,white))))
`(gnus-group-news-2-low ((,class (:foreground ,white))))
`(gnus-group-news-3 ((,class (:weight bold :foreground ,white))))
`(gnus-group-news-3-low ((,class (:foreground ,white))))
`(gnus-group-news-4 ((,class (:weight bold :foreground ,white))))
`(gnus-group-news-4-low ((,class (:foreground ,white))))
`(gnus-group-news-5 ((,class (:weight bold :foreground ,white))))
`(gnus-group-news-5-low ((,class (:foreground ,white))))
`(gnus-group-news-low ((,class (:foreground ,white))))
`(gnus-group-mail-1 ((,class (:weight bold :foreground ,white))))
`(gnus-group-mail-1-low ((,class (:foreground ,white))))
`(gnus-group-mail-2 ((,class (:weight bold :foreground ,white))))
`(gnus-group-mail-2-low ((,class (:foreground ,white))))
`(gnus-group-mail-3 ((,class (:weight bold :foreground ,white))))
`(gnus-group-mail-3-low ((,class (:foreground ,white))))
`(gnus-group-mail-low ((,class (:foreground ,white))))
`(gnus-header-content ((,class (:foreground ,white))))
`(gnus-header-from ((,class (:weight bold :foreground ,white))))
`(gnus-header-subject ((,class (:foreground ,white))))
`(gnus-header-name ((,class (:foreground ,white))))
`(gnus-header-newsgroups ((,class (:foreground ,white))))
`(gnus-summary-select ((,class (:foreground ,white))))

;; ┌┌┐┬─┐┐─┐┐─┐┬─┐┌─┐┬─┐
;; │││├─ └─┐└─┐│─┤│ ┬├─
;; ┘ │┴─┘──┘──┘┘ │└─┘┴─┘
;;;;;;;;;;;;;;;; MESSAGE

`(message-header-name ((,class (:foreground ,white))))
`(message-header-cc ((,class (:foreground ,white))))
`(message-header-other ((,class (:foreground ,white))))
`(message-header-subject ((,class (:foreground ,white))))
`(message-header-to ((,class (:weight bold :foreground ,white))))
`(message-cited-text ((,class (:slant italic :foreground ,white))))
`(message-separator ((,class (:weight bold :foreground ,white))))

;; ┬─┐┐─┐┬ ┬┬─┐┬  ┬
;; ├─ └─┐│─┤├─ │  │
;; ┴─┘──┘│ ┴┴─┘└─┘└─┘
;;;;;;;;;;;;;; ESHELL

`(eshell-prompt ((,class (:foreground ,white :bold t))))
`(eshell-ls-archive ((,class (:inherit eshell-ls-unreadable))))
`(eshell-ls-backup ((,class (:inherit eshell-ls-unreadable))))
`(eshell-ls-clutter ((,class (:inherit eshell-ls-unreadable))))
`(eshell-ls-directory ((,class (:foreground ,white :bold t))))
`(eshell-ls-executable ((,class (:inherit eshell-ls-unreadable))))
`(eshell-ls-missing ((,class (:inherit eshell-ls-unreadable))))
`(eshell-ls-product ((,class (:inherit eshell-ls-unreadable))))
`(eshell-ls-readonly ((,class (:inherit eshell-ls-unreadable))))
`(eshell-ls-special ((,class (:inherit eshell-ls-unreadable))))
`(eshell-ls-symlink ((,class (:inherit eshell-ls-unreadable))))

;; ┌─┐┬─┐┌─┐  ┌┌┐┌─┐┬─┐┬─┐
;; │ ││┬┘│ ┬──││││ ││ │├─
;; ┘─┘│└┘└─┘  ┘ │┘─┘┴─┘┴─┘
;;;;;;;;;;;;;;;;; ORG-MODE

`(org-level-1 ((t (:bold t :foreground ,white))))
`(org-level-2 ((t (:bold t :foreground ,white))))
`(org-level-3 ((t (:bold t :foreground ,white))))
`(org-level-4 ((t (:bold t :foreground ,white))))
`(org-level-5 ((t (:bold t :foreground ,white))))
`(org-level-6 ((t (:bold t :foreground ,white))))
`(org-link ((t (:foreground ,white :underline t))))
`(org-todo ((t (:bold t :foreground ,white :underline t))))
`(org-done ((t (:bold t :foreground ,white :underline t))))
`(org-document-title ((t (:foreground "light gray" :weight bold))))
`(org-date ((t (:foreground ,white :underline t))))

;; ┬─┐┬  ┐ ┬┐─┐┬─┐┬─┐┬  ┬
;; ├─ │  └┌┘└─┐│─┘├─ │  │
;; │  └─┘ │ ──┘│  ┴─┘└─┘└─┘
;;;;;;;;;;;;;;;;;; FLYSPELL

`(flyspell-duplicate ((,class (:weight unspecified :foreground unspecified
     			  :slant unspecified :underline ,lgray))))
`(flyspell-incorrect ((,class (:weight unspecified :foreground unspecified
     			  :slant unspecified :underline "red2"))))

;; ┌┌┐┬─┐┬─┐┬┌ ┬─┐┌─┐┐ ┬┌┐┐
;; ││││─┤│┬┘├┴┐│ ││ │││││││
;; ┘ │┘ ││└┘│ ┘┴─┘┘─┘└┴┘ └┘
;;;;;;;;;;;;;;;;;; MARKDOWN

`(markdown-bold-face ((t (:weight bold))))
`(markdown-italic-face ((t (:slant italic))))
`(markdown-metadata-key-face ((t (:foreground ,white))))
`(markdown-metadata-value-face ((t (:foreground, white))))
`(markdown-link-face ((t (:foreground ,white))))
`(markdown-url-face ((t (:foreground, white :underline t))))

;; ┬  ┬─┐┌┐┐┬─┐┐ │
;; │  │─┤ │ ├─ ┌┼┘
;; └─┘┘ │ │ ┴─┘│ └
;;;;;;;;;;;; LATEX

`(font-latex-bold-face ((t (:inherit bold :weight bold))))
`(font-latex-italic-face ((t (:inherit italic))))
`(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face))))
`(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face))))
`(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face))))
`(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face))))
`(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face))))
`(font-latex-sectioning-5-face ((t (:inherit default :weight bold))))
`(font-latex-sedate-face ((t (:inherit default))))

;; ┐ ┬┌─┐┌┌┐
;; │││ ─┤│││
;; └┴┘└─┘┘ │
;;;;;;;; W3M

`(w3m-anchor ((t (:underline t))))
`(w3m-header-line-location-content ((t (:background ,black :foreground ,white
                                                    :underline t))))
`(w3m-header-line-location-title ((t (:background ,black :foreground ,white))))
`(w3m-arrived-anchor ((t (:foreground ,lgray :underline t))))

;; ┬─┐┌┐┐┬─┐
;; ├─ ││││ │
;; ┴─┘ └┘┴─┘
;;;;;;;; END
)

  (custom-theme-set-variables
   'vt100
   `(ansi-color-names-vector [,black ,white ,lgray])))

;; ┬─┐┬ ┐┌┐┐┌─┐┬  ┌─┐┬─┐┬─┐  ┬─┐┌─┐┬─┐  ┌┌┐┬─┐┬  ┬─┐┬─┐
;; │─┤│ │ │ │ ││  │ ││─┤│ │  ├─ │ ││┬┘  │││├─ │  │─┘│─┤
;; ┘ │└─┘ │ ┘─┘└─┘┘─┘┘ │┴─┘  │  ┘─┘│└┘  ┘ │┴─┘└─┘│  ┘ │
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; AUTOLOAD FOR MELPA

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

;; ┬─┐o┌┐┐o┐─┐┬ ┬  ┬ ┬o┌┌┐┐
;; ├─ │││││└─┐│─┤  │─┤│││││
;; │    └┘ ──┘│ ┴  │ ┴ ┘ │o
;;;;;;;;;;;;;;; FINISH HIM!

(provide-theme 'vt100)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; vt100-theme.el ends here
