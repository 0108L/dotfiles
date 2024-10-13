;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Lee"
      user-mail-address "cocowang616@hotmail.com")

;; When I bring up Doom's scratch buffer with SPC x, it's often to play with
;; elisp or note something down (that isn't worth an entry in my notes). I can
;; do both in `lisp-interaction-mode'.
(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)

;;
;;; UI

(setq doom-theme 'doom-one
      doom-font (font-spec :family "JetBrainsMono" :size 15)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 15.5)
      nerd-icons-font-names '("SymbolsNerdFontMono-Regular.ttf")
      ;; +doom-dashboard-banner-file (expand-file-name "logo.png" doom-user-dir)
      fancy-splash-image (file-name-concat doom-user-dir "logo.png")
      display-line-numbers-type 'relative
      )
;; Prevents some cases of Emacs flickering.
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
;; Bullet
(add-hook! 'org-mode-hook #'+org-pretty-mode)
;; (add-hook! 'org-mode-hook #'mixed-pitch-mode)
(add-hook! 'org-mode-hook '(org-bullets-mode org-fancy-priorities-mode))
;; An evil mode indicator is redundant with cursor shape
(setq doom-modeline-modal nil)
;; Others
(setq avy-all-windows t
      dart-format-on-save t
      projectile-project-search-path '("~/Documents/myDraft/"
                                       ;;
                                       )
      dired-dwim-target t
      )
;; TODO ligatures

;;; :ui doom-dashboard
;; (setq fancy-splash-image (file-name-concat doom-user-dir "splash.png"))
;; Hide the menu for as minimalistic a startup screen as possible.
;; (setq +doom-dashboard-functions '(doom-dashboard-widget-banner))

;;
;;; Keybinds

;; (map! (:after evil-org
;;        :map evil-org-mode-map
;;        :n "gk" (cmds! (org-on-heading-p)
;;                       #'org-backward-element
;;                       #'evil-previous-visual-line)
;;        :n "gj" (cmds! (org-on-heading-p)
;;                       #'org-forward-element
;;                       #'evil-next-visual-line))

;;       :o "o" #'evil-inner-symbol

;;       :leader
;;       "h L" #'global-keycast-mode
;;       (:prefix "f"
;;        "t" #'find-in-dotfiles
;;        "T" #'browse-dotfiles)
;;       (:prefix "n"
;;        "b" #'org-roam-buffer-toggle
;;        "d" #'org-roam-dailies-goto-today
;;        "D" #'org-roam-dailies-goto-date
;;        "e" (cmd! (find-file (doom-path org-directory "ledger/personal.gpg")))
;;        "i" #'org-roam-node-insert
;;        "r" #'org-roam-node-find
;;        "R" #'org-roam-capture))
;; (map! :ne "M-/" #'comment-or-uncomment-region)
;; (map! :ne "SPC / r" #'deadgrep)
;; (map! :ne "SPC n b" #'org-brain-visualize)

;;
;;; :editor evil

;; Implicit /g flag on evil ex substitution, because I use the default behavior
;; less often.
;; (setq evil-ex-substitute-global t)

;;; :tools lsp
;; Disable invasive lsp-mode features
(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
        ;; If an LSP server isn't present when I start a prog-mode buffer, you
        ;; don't need to tell me. I know. On some machines I don't care to have
        ;; a whole development environment for some ecosystems.
        lsp-enable-suggest-server-download nil))
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil  ; no more useful than flycheck
        lsp-ui-doc-enable nil))     ; redundant with K

;;; tools magit
(setq +magit-hub-features t
      magit-repository-directories '(("~/Documents/myDraft/" . 2))
      magit-save-repository-buffers nil
      ;; Don't restore the wconf after quitting magit, it's jarring
      magit-inhibit-save-previous-winconf t
      evil-collection-magit-want-horizontal-movement t
      magit-openpgp-default-signing-key "FA1FADD9440B688CAA75A057B60957CA074D39A3"
      transient-values '((magit-rebase "--autosquash" "--autostash")
                         (magit-pull "--rebase" "--autostash")
                         (magit-revert "--autostash")))

;;; tools deft
(setq deft-directory "~/Documents/myDraft/")

;;; :lang org
(setq org-directory "~/Documents/myDraft/org/"
      org-archive-location (file-name-concat org-directory ".archive/%s::")
      org-agenda-files (list org-directory)
      org-ellipsis " ▾ "
      org-bullets-bullet-list '("⦿" "○" "✸" "✿" "◆")
      org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")
      org-tags-column -88
      org-agenda-files (ignore-errors (directory-files +org-dir t "\\.org$" t))
      org-log-done 'time
      org-roam-directory org-directory
      ;; org-roam-directory "~/Documents/myDraft/org/roam/"
      org-roam-db-location (file-name-concat org-directory ".org-roam.db")
      ;; org-roam-update-slug-on-save-h t
      ;; org-roam-restore-insertion-order-for-tags-a t
      org-roam-dailies-directory "~/Documents/myDraft/org/journal/"
      org-journal-date-prefix "#+title:"
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org"
      org-super-agenda-groups '((:name "Today"
                                 :time-grid t
                                 :scheduled today)
                                (:name "Due today"
                                 :deadline today)
                                (:name "Important"
                                 :priority "A")
                                (:name "Overdue"
                                 :deadline past)
                                (:name "Due soon"
                                 :deadline future)
                                (:name "Big Outcomes"
                                 :tag "bo"))
      )

(after! org
  (setq org-startup-folded 'show2levels
        org-ellipsis " [...] "
        org-capture-templates
        '(("t" "todo" entry (file+headline "todo.org" "Inbox")
           "* [ ] %?\n%i\n%a"
           :prepend t)
          ("d" "deadline" entry (file+headline "todo.org" "Inbox")
           "* [ ] %?\nDEADLINE: <%(org-read-date)>\n\n%i\n%a"
           :prepend t)
          ("s" "schedule" entry (file+headline "todo.org" "Inbox")
           "* [ ] %?\nSCHEDULED: <%(org-read-date)>\n\n%i\n%a"
           :prepend t)
          ("c" "check out later" entry (file+headline "todo.org" "Check out later")
           "* [ ] %?\n%i\n%a"
           :prepend t)
          ("l" "ledger" plain (file "ledger/personal.gpg")
           "%(+beancount/clone-transaction)")))
  (set-face-attribute 'org-link nil
                      ;; :background nil
                      :weight 'normal)
  (set-face-attribute 'org-code nil
                      ;; :foreground "#a9a1e1"
                      ;; :background nil
                      )
  (set-face-attribute 'org-date nil
                      ;; :foreground "#5B6268"
                      ;; :background nil
                      )
  (set-face-attribute 'org-level-1 nil
                      ;; :foreground "steelblue2"
                      ;; :background nil
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      ;; :foreground "slategray2"
                      ;; :background nil
                      :height 1.08
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      ;; :foreground "SkyBlue2"
                      ;; :background nil
                      :height 1.05
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      ;; :foreground "DodgerBlue2"
                      ;; :background nil
                      :height 1.02
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      ;; :foreground "SlateGray1"
                      ;; :background nil
                      :height 1.75
                      :weight 'bold))
;; jump in and out of latex fragments without using 'C-c C-x C-l' all the time
;; (use-package! org-fragtog
;;   :after org
;;   :hook (org-mode . org-fragtog-mode)
;;   )

(set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^\\*org-brain" :side 'right :size 1.00 :select t :ttl nil)

(after! org-roam
  (setq org-roam-capture-templates
        `(("n" "note" plain
           ,(format "#+title: ${title}\n%%[%s/template/note.org]" org-roam-directory)
           :target (file "note/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("r" "thought" plain
           ,(format "#+title: ${title}\n%%[%s/template/thought.org]" org-roam-directory)
           :target (file "thought/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("t" "topic" plain
           ,(format "#+title: ${title}\n%%[%s/template/topic.org]" org-roam-directory)
           :target (file "topic/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("c" "contact" plain
           ,(format "#+title: ${title}\n%%[%s/template/contact.org]" org-roam-directory)
           :target (file "contact/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("p" "project" plain
           ,(format "#+title: ${title}\n%%[%s/template/project.org]" org-roam-directory)
           :target (file "project/%<%Y%m%d>-${slug}.org")
           :unnarrowed t)
          ("i" "invoice" plain
           ,(format "#+title: %%<%%Y%%m%%d>-${title}\n%%[%s/template/invoice.org]" org-roam-directory)
           :target (file "invoice/%<%Y%m%d>-${slug}.org")
           :unnarrowed t)
          ("f" "ref" plain
           ,(format "#+title: ${title}\n%%[%s/template/ref.org]" org-roam-directory)
           :target (file "ref/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("w" "works" plain
           ,(format "#+title: ${title}\n%%[%s/template/works.org]" org-roam-directory)
           :target (file "works/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("s" "secret" plain "#+title: ${title}\n\n"
           :target (file "secret/%<%Y%m%d%H%M%S>-${slug}.org.gpg")
           :unnarrowed t))
        ;; Use human readable dates for dailies titles
        org-roam-dailies-capture-templates
        `(("d" "default" plain ""
           :target (file+head "%<%Y-%m-%d>.org" ,(format "%%[%s/template/journal.org]" org-roam-directory))))))

(after! org-tree-slide
  ;; I use g{h,j,k} to traverse headings and TAB to toggle their visibility, and
  ;; leave C-left/C-right to .  I'll do a lot of movement because my
  ;; presentations tend not to be very linear.
  (setq org-tree-slide-skip-outline-level 2))

(after! org-roam
  ;; Offer completion for #tags and @areas separately from notes.
  (add-to-list 'org-roam-completion-functions #'org-roam-complete-tag-at-point)

  ;; Automatically update the slug in the filename when #+title: has changed.
  (add-hook 'org-roam-find-file-hook #'org-roam-update-slug-on-save-h)

  ;; Make the backlinks buffer easier to peruse by folding leaves by default.
  (add-hook 'org-roam-buffer-postrender-functions #'magit-section-show-level-2)

  ;; List dailies and zettels separately in the backlinks buffer.
  (advice-add #'org-roam-backlinks-section :override #'org-roam-grouped-backlinks-section)

  ;; Open in focused buffer, despite popups
  (advice-add #'org-roam-node-visit :around #'+popup-save-a)

  ;; Make sure tags in vertico are sorted by insertion order, instead of
  ;; arbitrarily (due to the use of group_concat in the underlying SQL query).
  (advice-add #'org-roam-node-list :filter-return #'org-roam-restore-insertion-order-for-tags-a)

  ;; Add ID, Type, Tags, and Aliases to top of backlinks buffer.
  (advice-add #'org-roam-buffer-set-header-line-format :after #'org-roam-add-preamble-a))

;; lang: reason-mode
(add-hook! reason-mode
  (add-hook 'before-save-hook #'refmt-before-save nil t))

(add-hook!
 js2-mode 'prettier-js-mode
 (add-hook 'before-save-hook #'refmt-before-save nil t))

;; lang: ruby-mode
;; (after! ruby
;;   (add-to-list 'hs-special-modes-alist
;;                `(ruby-mode
;;                  ,(rx (or "def" "class" "module" "do" "{" "[")) ; Block start
;;                  ,(rx (or "}" "]" "end"))                       ; Block end
;;                  ,(rx (or "#" "=begin"))                        ; Comment start
;;                  ruby-forward-sexp nil)))

;; (remove-hook 'enh-ruby-mode-hook #'+ruby|init-robe)

;;; :app everywhere
(after! emacs-everywhere
  ;; Easier to match with a bspwm rule:
  ;;   bspc rule -a 'Emacs:emacs-everywhere' state=floating sticky=on
  (setq emacs-everywhere-frame-name-format "emacs-anywhere")

  ;; The modeline is not useful to me in the popup window. It looks much nicer
  ;; to hide it.
  ;; (remove-hook 'emacs-everywhere-init-hooks #'hide-mode-line-mode)

  ;; Semi-center it over the target window, rather than at the cursor position
  ;; (which could be anywhere).
  (defadvice! center-emacs-everywhere-in-origin-window (frame window-info)
    :override #'emacs-everywhere-set-frame-position
    (cl-destructuring-bind (x y width height)
        (emacs-everywhere-window-geometry window-info)
      (set-frame-position frame
                          (+ x (/ width 2) (- (/ width 2)))
                          (+ y (/ height 2))))))
;;; HACK lang: latex
(setq +latex-viewers '(pdf-tools) ;; C-c C-v
      TeX-view-program-selection '((output-pdf "PDF Tools")) ;; maybe duplicate
      TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
      TeX-tree-roots "/usr/local/texlive/2024/texmf-dist/"
      pdf-sync-backward-display-action t
      pdf-sync-forward-display-action t
      TeX-source-correlate-mode t
      TeX-source-correlate-method '((dvi . source-specials)
                                    (pdf . synctex))
      TeX-source-correlate-start-server t  ;; [C-c C-g] to switch between source code and PDF
      ;; TeX-PDF-mode t ;; default value
      ;; lsp-tex-server 'texlab ;; default
      )
(setenv "PATH"
        (concat
         "/usr/local/texlive/2024/bin/x86_64-linux" ";"
         (getenv "PATH")))
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer) ;; refresh after compilation
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))
;; (add-hook 'pdf-view-mode-hook 'pdf-view-fit-page-to-window) ;; fit width/height/page
(add-hook! 'TeX-mode-hook '(outline-minor-mode auto-fill-mode))
(add-hook 'TeX-mode-hook (lambda () (outline-hide-body))) ;; declare an anonymous function to hide-body by default
;;  prettify-symbols-mode ;; asiic or other symbols, enable it when in need ❎
;;  xenops-mode ;; preview mathematica, enable it when in need ❎
;;  auto-fill-mode ;; auto line feed ❎
;;  outline-hide-body ;; hide article body, avairible when outline-minor-mode is enabled ✅
;;  outline-minor-mode ;; fold the article ✅
;;  turn-on-cdlatex ;; enabled by default ✅
;;  reftex-mode ;; cross reference, enabled by default ✅
;;  flyspell-mode ;; flycheck is enabled by default ✅
;; (map! :map cdlatex-mode-map
;;       :i "TAB" #'cdlatex-tab)
(map! :map pdf-view-mode-map
      ;; :n "w" 'pdf-view-scroll-down-or-previous-page
      ;; :n "s" 'pdf-view-scroll-up-or-next-page ;; FIXME doesn't work
      :n "d" 'pdf-view-next-page-command
      :n "a" 'pdf-view-previous-page-command)

;;
;;; Language customizations

(use-package! agenix
  :mode ("\\.age\\'" . agenix-mode)
  :config
  (add-to-list 'agenix-key-files "~/.config/ssh/id_ed25519")
  (add-to-list 'agenix-key-files "/etc/ssh/host_ed25519")
  (dolist (file (doom-glob "~/.config/ssh/*/id_ed25519"))
    (add-to-list 'agenix-key-files file)))

(define-generic-mode sxhkd-mode
  '(?#)
  '("alt" "Escape" "super" "bspc" "ctrl" "space" "shift") nil
  '("sxhkdrc") nil
  "Simple mode for sxhkdrc files.")

;;
;;; Function customizations
(defun +data-hideshow-forward-sexp (arg)
  (let ((start (current-indentation)))
    (forward-line)
    (unless (= start (current-indentation))
      (require 'evil-indent-plus)
      (let ((range (evil-indent-plus--same-indent-range)))
        (goto-char (cadr range))
        (end-of-line)))))

(add-to-list 'hs-special-modes-alist '(yaml-mode "\\s-*\\_<\\(?:[^:]+\\)\\_>" "" "#" +data-hideshow-forward-sexp nil))
