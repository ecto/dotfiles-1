;;; smart-mode-line.el --- A color coded smart mode-line.

;; based on smart-mode-line.el version: 1.7.1
;; Copyright (C) 2012 Artur Malabarba <bruce.connor.am@gmail.com>

;; Author: Artur Malabarba <bruce.connor.am@gmail.com>
;; URL: http://github.com/Bruce-Connor/smart-mode-line

;;; Instructions:

;; INSTALLATION

;;	Make sure "smart-mode-line.el" is in your load path, then place
;; 	this code in your .emacs file:
;;		(require 'smart-mode-line)
;; 		(sml/setup)

;; Variables
;;
;; 	All variables can be edited by running `sml/customize', and the
;; 	documentations are mostly self explanatory, I list here only the
;; 	most important ones.

;; 	`sml/shorten-directory' and `sml/shorten-modes'
;; 		Setting both of these to t garantees a fixed width mode-line
;; 		(directory name and modes list will be truncated to fit).  To
;; 		actually define the width, see below.

;;	`sml/name-width' and `sml/mode-width'
;;		Customize these according to the width of your Emacs
;;		frame.  I set them to 40 and 30 respectively, and the
;;		mode-line fits perfectly when the frame is split in two even
;;		on my laptop's small 17" monitor.

;; 	`sml/replacer-regexp-list'
;; 		This variable is a list of (REGEXP REPLACEMENT) that is used
;; 		to parse the path.  The replacements are applied
;; 		sequentially.  This allows you to greatly abbreviate the path
;; 		that's shown in the mode-line.  If this abbreviation is of
;; 		the form ":SOMETHING:", it is considered a prefix and get's
;; 		a different color (you can change what's considered a prefix
;; 		by customizing `sml/prefix-regexp').

;;		For example, if you do a lot of work on a folder called
;;		"~/Dropbox/Projects/In-Development/" almost half the
;;		mode-line would be occupied just by the folder name, which
;;		is much less important than the buffer name.  But, you can't
;;		just hide the folder name, since editting a file in
;;		"~/Dropbox/Projects/In-Development/Source" is VERY different
;;		from editting a file in "~/Dropbox/Projects/Source".  By
;;		setting up a prefix for your commonly used folders, you get
;;		all that information without wasting all that space.  In this
;;		example you could set the replacement to ":ProjDev:" or just
;;		":InDev:", so the path shown in the mode-line will be
;;		":ProjDev:Source/" (saves a lot of space without hiding
;;		information).

;;		Here go some more useful examples:
;;
;; 	(add-to-list 'sml/replacer-regexp-list '("^~/Dropbox/Projects/In-Development/"	":ProjDev:"))
;;	(add-to-list 'sml/replacer-regexp-list '("^~/Documents/Work/"			":Work:))
;;
;;	;; Added in the right order, they even work sequentially:
;;	(add-to-list 'sml/replacer-regexp-list '("^~/Dropbox/"				":DB:"))
;;	(add-to-list 'sml/replacer-regexp-list '("^:DB:Documents"			":DDocs:"))
;;	(add-to-list 'sml/replacer-regexp-list '("^~/Git-Projects/"			":Git:"))
;;	(add-to-list 'sml/replacer-regexp-list '("^:Git:\\(.*\\)/src/main/java/"	":G/\\1/SMJ:"))

;;; License:

;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;

;;; Code:

(eval-when-compile (require 'cl))

(defconst sml/version "1.7.1" "Version of the smart-mode-line.el package.")

(defun sml/customize ()
  "Open the customization menu the `smart-mode-line' group."
  (interactive)
  (customize-group 'smart-mode-line t))

(defun sml/customize-faces ()
  "Open the customization menu the `smart-mode-line-faces' group."
  (interactive)
  (customize-group 'smart-mode-line-faces t))

(defgroup smart-mode-line '()
  "Customization group for the `smart-mode-line.el' package."
    :group 'convenience)

(defgroup smart-mode-line-faces '()
  "Font (face) colors for the `smart-mode-line.el' package.

You can fully customize any of the fonts to match the color you
want. You can also set properties like bold with ':weight bold'."
  :group 'smart-mode-line
  :group 'faces)

(defcustom sml/persp-selected-color "Green"
  "Replace `persp-selected-color', otherwise it's unreadable."
  :type 'string
  :group 'smart-mode-line)

(defun sml/set-shortener-func (sym val)
  "Configure `sml/shortener-func' according to `sml/shorten-directory'."
  (set-default sym val)
  (if val (setq sml/shortener-func 'sml/do-shorten-directory)
    (setq sml/shortener-func 'sml/not-shorten-directory)))

(defvar sml/shortener-func 'sml/do-shorten-directory
  "Function used to shorten the directory name.

Value is a funcallable symbol that takes two arguments: the
string to be shortened and the maximum size. This is set
automatically when `sml/shorten-directory' is changed via the
customization menu or via the `sml/toggle-shorten-directory'
function (which are the only ways you should change it).")

(defun sml/toggle-shorten-directory (&rest val)
  "Toggle the variable `sml/shorten-directory'.

If given an argument the variable is set to the argument,
otherwise it is toggled. This can be used as an alternative to
customizing the variable with `customize-group'. Setting the
variable with `setq' will NOT work and should be avoided."
  (interactive)
  (sml/set-shortener-func 'sml/shorten-directory
                          (if val (car val)
                            (not sml/shorten-directory))))

(defcustom sml/shorten-directory t
  "Should directory name be shortened to fit width?

When the buffer+directory name is longer than
`sml/name-width':
	if nil the rest of the mode-line is pushed right;
	otherwise the directory name is shortened to fit."
  :type 'boolean
  :group 'smart-mode-line
  :set 'sml/set-shortener-func)

(defcustom sml/prefix-regexp '(":\\(.*:\\)" "~/")
  "List of Regexps used to identify prefixes.

A prefix is anything at the begining of a line that matches any
of these regexps. Don't start these regexps with \"^\", the
parser applies that for you."
  :type '(repeat regexp)
  :group 'smart-mode-line)

(defcustom sml/replacer-regexp-list '(("^~/\\.emacs\\.d/" ":ED:") ("^/sudo:.*:" ":SU:"))
  "List of pairs of strings used by `sml/replacer'.

The first string of each pair is a regular expression, the second
is a replacement. These replacements are sequentially called on
the filename to replace portions of it. To be considered a prefix
a string must start and end with \":\" (see the default as an
example).

You can also set custom colors (faces) for these prefixes, just
set `sml/prefix-face-list' accordingly."
  :type '(repeat (list regexp string))
  :group 'smart-mode-line)

(defcustom sml/prefix-face-list '((":SU:" sml/sudo)
                                  (":G" sml/git)
                                  ("" sml/prefix))
  "List of (STRING FACE) pairs used by `sml/propertize-prefix'."
  :type '(repeat (list string face))
  :group 'smart-mode-line)

(defcustom sml/name-width 10
  "Minimum and maximum size of the file name in the mode-line.

If `sml/shorten-directory' is nil, this is the minimum width.
Otherwise, this is both the minimum and maximum width."
  :type 'integer
  :group 'smart-mode-line)

(defcustom sml/modified-time-string "Modified on %T %Y-%m-%d."
  "String format used for displaying the modified time.

This is shown in the tooltip when hovering over the \"modified
file\" character (which is usually a * right before the file
name."
  :type 'string
  :group 'smart-mode-line)

(defconst sml/major-help-echo
  "Mouse-1: mode menu.\nMouse-2: mode help.\nMouse-3: toggle minor modes.")

;;;###autoload
(defun sml/setup (&optional arg)
  "Setup the mode-line, or revert it.

If argument is a non-positive integer, revert any changes made.
Otherwise, setup the mode-line."
  (interactive)
  (if (and (integerp arg) (< arg 1))
      (sml/revert)
    (sml/set-face-color nil nil)
    (setq-default
     mode-line-format
     '(
     "--" "%e" mode-line-mule-info
     (:eval
      (cond
       ((not
         (verify-visited-file-modtime))
        (propertize "M"
                    (quote face)
                    (quote sml/outside-modified)
                    (quote help-echo)
                    "Modified outside Emacs!
Revert first!"))
       (buffer-read-only
        (propertize "R"
                    (quote face)
                    (quote sml/read-only)
                    (quote help-echo)
                    "Read-Only Buffer"))
       ((buffer-modified-p)
        (propertize "×"
                    (quote face)
                    (quote sml/modified)
                    (quote help-echo)
                    (if
                        (buffer-file-name)
                        (format-time-string sml/modified-time-string
                                            (nth 5
                                                 (file-attributes
                                                  (buffer-file-name))))
                      "Buffer Modified")))
       (t
        (propertize "Ø"
                    (quote face)
                    (quote sml/not-modified)
                    (quote help-echo)
                    "Buffer Not Modified"))))
     " "
     (:eval
      (let*
          ((prefix
            (sml/get-prefix
             (sml/replacer
              (abbreviate-file-name
               (sml/get-directory)))))
           (bufname
            (buffer-name))
           (dirsize
            (max 1
                 (-
                  (abs sml/name-width)
                  (length prefix)
                  (length bufname))))
           (dirstring
            (funcall sml/shortener-func
                     (sml/get-directory)
                     dirsize)))
        (propertize
         (concat
          (sml/propertize-prefix prefix)
          (propertize dirstring
                      (quote face)
                      (quote sml/folder))
          (propertize bufname
                      (quote face)
                      (quote sml/filename))
          (make-string
           (max 1
                (- dirsize
                   (length dirstring)))
           32))
         (quote help-echo)
         (buffer-file-name))))
     "[" "%p" ":" "%02l" "/" "%02c" "]-["
     (:eval
      (propertize
       (format-mode-line mode-name)
       (quote mouse-face)
       (quote mode-line-highlight)
       (quote face)
       (quote sml/modes)
       (quote local-map)
       mode-line-major-mode-keymap
       (quote help-echo)
       sml/major-help-echo))
     (:propertize
      ("" mode-line-process)
      (quote mouse-face)
      (quote mode-line-highlight)
      (quote face)
      (quote sml/modes)
      (quote help-echo)
      sml/major-help-echo)
       global-mode-string "]%-")))

    ;; Perspective support
    (eval-after-load "perspective"
      '(set-face-foreground 'persp-selected-face sml/persp-selected-color)))

(defun sml/mode-list-to-string-list (ml) ;;Credits to Constantin
  "Try to read the mode-list (which contains almost anything) and
return a sensible list of strings."
  (case (type-of ml)
    ('string (list ml))
    ('symbol
     (if ml
         (sml/mode-list-to-string-list (symbol-value ml) )
       nil))
    (('function 'subr) (sml/mode-list-to-string-list (list (funcall ml))))
    ('cons
     (let ((kar (car ml))
           (kdr (cdr ml)))
       (case (type-of kar)
         ('symbol
          (let ((val (symbol-value kar))
                (kadr (if (listp kdr) (car kdr) nil)))
            (case val
              (:eval (sml/mode-list-to-string-list (eval kadr) ))
              ;; properties now not handlet properly
              (:propertize (sml/mode-list-to-string-list kdr ))
              (t
               (if val
                   (sml/mode-list-to-string-list kadr)
                 (sml/mode-list-to-string-list (cdr kdr)))))))
         ('integer
          ;; heh, now do nothing, must reduce max width if < 0 or do padding if > 0
          (sml/mode-list-to-string-list kdr ))
         (t (append (sml/mode-list-to-string-list kar ) (sml/mode-list-to-string-list kdr ))))))
    ;; unknown
    (t ;;(message "mode-list-to-string-error Unknown: type: %s;\nval: %s" ml (type-of ml))
     (list (format "%s" ml)))))

(defun sml/propertize-prefix (prefix)
  "Set the color of the prefix according to its contents."
  (let ((out prefix))
    (dolist (pair sml/prefix-face-list)
      (if (search (car pair) prefix)
	(return (propertize prefix 'face (car (cdr pair))))))))

(defun sml/trim-modes (major minor)
  "Maybe trim the modes list."
  (let ((out (concat major minor))
        (N sml/mode-width))
    (if sml/shorten-modes
        (if (> (length out) N)
            (concat (substring out 0 (- N 3)) "...")
          (concat out (make-string (- N (length out)) ?\ )))
      (concat out (make-string (max 0 (- N (length out))) ?\ )))))

(defun sml/revert ()
  "Called by `sml/setup' with arg = -1."
  (copy-face 'sml/active-backup 'mode-line)
  (copy-face 'sml/inactive-backup 'mode-line-inactive)
  (setq-default mode-line-format sml/format-backup)
  (setq battery-mode-line-format sml/battery-format-backup)
  )

(defun sml/get-directory ()
  "Decide if we want directory shown. If so, return it."
  (cond ((buffer-file-name) default-directory)
        ((search "Dired" mode-name :start1)
         (replace-regexp-in-string "/[^/]*/$" "/" default-directory))
        (t "")))

(defun sml/replacer (in)
  "Runs the replacements specified in `sml/replacer-regexp-list'.

Used by `sml/strip-prefix' and `sml/get-prefix'."
  (let ((out in))
    (dolist (cur sml/replacer-regexp-list)
      (setq out (replace-regexp-in-string (car cur)
                                          (car (cdr cur))
                                          out)))
    out))

(defun sml/regexp-composer (getter)
  "Prepares the actual regexp using `sml/prefix-regexp'."
  (let ((left "^\\(")
        (right (if getter "\\|\\).*" "\\)")))
    (if (stringp sml/prefix-regexp)
        (if (search "\\(" sml/prefix-regexp)
            sml/prefix-regexp
          (concat left sml/prefix-regexp right))
      (concat left (mapconcat 'identity sml/prefix-regexp "\\|") right))))

(defun sml/strip-prefix (path)
  "Remove prefix from string.

A prefix is anything at the begining of the line that matches a
regexp in `sml/prefix-regexp'."
  (replace-regexp-in-string (sml/regexp-composer nil) "" path))

(defun sml/get-prefix (path)
  "Get prefix from string.

A prefix is anything at the begining of the line that matches a
regexp in `sml/prefix-regexp'."
  (replace-regexp-in-string (sml/regexp-composer t) "\\1" path))

(defun sml/not-shorten-directory (dir ml)
  "Dummy function. Just returns abbreviated dir."
  (sml/strip-prefix (sml/replacer (abbreviate-file-name dir))))

(defun sml/do-shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((longname (sml/strip-prefix (sml/replacer (abbreviate-file-name dir)))))
    ;; If it fits, return the string.
    (if (<= (length longname) max-length) longname
      ;; If it doesn't, shorten it
      (let ((path (reverse (split-string longname "/")))
            (output ""))
        (when (and path (equal "" (car path)))
          (setq path (cdr path)))
        ;; Concat as many levels as possible, leaving 4 chars for safety.
        (while (and path (< (length (concat (car path) "/" output)) (- max-length 3)))
          (setq output (concat (car path) "/" output))
          (setq path (cdr path)))
        ;; If we had to shorten, prepend .../
        (when path
          (setq output (concat "…/" output)))
        output
        ))))

;; Color definitions

(defun sml/set-face-color (sym val)
  (if sym (set-default sym val))
  (set-face-attribute 'mode-line nil
                      :foreground sml/active-foreground-color
                      :background sml/active-background-color)
  (set-face-attribute 'mode-line-inactive nil
                      :background sml/inactive-background-color
                      :foreground sml/inactive-foreground-color))

(defcustom sml/active-foreground-color "#fcefba"
  "Foreground mode-line color for the active frame."
  :type 'color
  :group 'smart-mode-line-faces
  :set 'sml/set-face-color
  :initialize 'set-default)
(defcustom sml/active-background-color "black" "Background mode-line color for the active frame."
  :type 'color :group 'smart-mode-line-faces
  :set 'sml/set-face-color
  :initialize 'set-default)


(defcustom sml/inactive-foreground-color "#fcefba" "Foreground mode-line color for the inactive frame."
  :type 'color :group 'smart-mode-line-faces
  :set 'sml/set-face-color
  :initialize 'set-default)
(defcustom sml/inactive-background-color "black" "Background mode-line color for the inactive frame."
  :type 'color :group 'smart-mode-line-faces
  :set 'sml/set-face-color
  :initialize 'set-default)

;; Face definitions

(defface sml/global
  '((t
     :foreground "#fcefba"
     ))
  ""
  :group 'smart-mode-line-faces)

(defface sml/warning
  '((t
     :inherit sml/global
     :foreground "#fcefba"
     :weight bold
     ))
  ""
  :group 'smart-mode-line-faces)

(defface sml/not-modified
  '((t
     :inherit sml/global ;;sml/active-foreground-color
     :foreground "#fcefba"
     ))
  ""
  :group 'smart-mode-line-faces)

(defface sml/read-only
  '((t
     :inherit sml/global
     :foreground "#fcefba"
     ))
  ""
  :group 'smart-mode-line-faces)

(defface sml/outside-modified
  '((t
     :inherit sml/global
     :foreground "#fcefba"
     ))
  ""
  :group 'smart-mode-line-faces)

(defface sml/modified
  '((t
     :inherit sml/global
     :foreground "#fcefba"
     ;; :weight bold
     ))
  ""
  :group 'smart-mode-line-faces)

(defface sml/prefix
  '((t
     :inherit sml/global
     :foreground "#fcefba"
     ;; :weight bold ;; not sure if it's best bold or not
     ))
  ""
  :group 'smart-mode-line-faces)

(defface sml/sudo
  '((t
     :inherit sml/warning
     ))
  ""
  :group 'smart-mode-line-faces)

(defface sml/git
  '((t
     :foreground "#fcefba"
     :inherit sml/prefix
     ))
  ""
  :group 'smart-mode-line-faces)

(defface sml/folder
  '((t
     :inherit sml/global
     :foreground "#fcefba"
     ))
  ""
  :group 'smart-mode-line-faces)

(defface sml/filename
  '((t
     :inherit sml/global
     :foreground "#fcefba"
     :weight bold
     ))
  ""
  :group 'smart-mode-line-faces)

(defface sml/modes
  '((t
     :inherit sml/global
     :foreground "#fcefba"
     ))
  ""
  :group 'smart-mode-line-faces)

;; Backup the original configs, just in case.
(defconst sml/format-backup mode-line-format
  "Backs up the `mode-line-format' before SML was required.")

(copy-face 'mode-line 'sml/active-backup)
(copy-face 'mode-line-inactive 'sml/inactive-backup)

(provide 'smart-mode-line)

;;; smart-mode-line.el ends here
