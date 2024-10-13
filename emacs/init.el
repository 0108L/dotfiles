;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;;(setq debug-on-error t)

(let ((minver "27.1"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "28.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; (require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))


;; Adjust garbage collection threshold for early startup (see use of gcmh below)
(setq gc-cons-threshold (* 128 1024 1024))


;; Process performance tuning

(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)


;; custom
(setq confirm-kill-emacs #'y-or-n-p) ;; ask y or n
(electric-pair-mode t) ;; auto parentheses
(column-number-mode t) ;; show column number on Mode line
(global-auto-revert-mode t) ;; refresh when other application has edited a file
(delete-selection-mode t) ;; edit on a selected text to overwrite it
(setq inhibit-startup-message t) ;; disable the welcome UI when starting up
(setq make-backup-files nil) ;; disable auto back up the files
(add-hook 'prog-mode-hook #'hs-minor-mode) ;; enable code block folding in editing mode
(global-display-line-numbers-mode 1) ;; show row number on window
(tool-bar-mode -1) ;; disable the tool bar
(menu-bar-mode -1) ;; disabble menu bar
(when (display-graphic-p) (toggle-scroll-bar -1)) ;; disable scroll bar on GUI
(savehist-mode 1) ;; OPTIONAL: enable buffer history
(setq display-line-numbers-type 'relative) ;; relative row number
;; (add-to-list 'default-frame-alist '(width . 140)) ;; width of GUI
;; (add-to-list 'default-frame-alist '(height . 43)) ;; height of GU

;; keybindings
(global-set-key (kbd "RET") 'newline-and-indent) ;; Return -> newline and indent
(global-set-key (kbd "C-c '") 'comment-or-uncomment-region) ;; comment the selected code
;; Faster move cursor
(defun next-ten-lines()
  "Move cursor to next 10 lines."
  (interactive)
  (next-line 10))
(defun previous-ten-lines()
  "Move cursor to previous 10 lines."
  (interactive)
  (previous-line 10))
(global-set-key (kbd "M-n") 'next-ten-lines) ;; move down 10 lines
(global-set-key (kbd "M-p") 'previous-ten-lines) ;; move up 10 lines
(global-set-key (kbd "C-j") nil)
(global-set-key (kbd "C-j C-k") 'kill-whole-line)

;; Plugins
                                        ; 添加MELPHA插件仓库
;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpha.org/packages/") t)
;; (package-initialize)
                                        ; 腾讯镜像
(require 'package)
(setq package-archives '(("gnu" . "http://mirrors.cloud.tencent.com/elpa/gnu/")
			 ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/"))) ;; two mirrors
(package-initialize)
;; plugin: use-package
(eval-when-compile
  (require 'use-package))

;;(use-package foo
;;  :init ;; run some comments before load the plugins
;;  (setq foo-variable t)
;;  :config ;; after load plugins
;;  (foo-mode 1))
(use-package flycheck
  :ensure t
  :hook
  (prog-mode . flycheck-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(flycheck)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; hydra: 把一组特定场景的命令组织起来
(use-package hydra
  :ensure t)
(use-package use-package-hydra
  :ensure t
  :after hydra)

;; ivy: 优化emacs使用体验
(use-package counsel
  :ensure t)
(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (counsel-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-count-format "(%d/%d) ")
  :bind
  (("C-s" . 'swiper)
   ("C-x b" . 'ivy-switch-buffer)
   ("C-c v" . 'ivy-push-view)
   ("C-c s" . 'ivy-switch-view)
   ("C-c V" . 'ivy-pop-view)
   ("C-x C-@" . 'counsel-mark-ring); 在某些终端上 C-x C-SPC 会被映射为 C-x C-@，比如在 macOS 上，所以要手动设置
   ("C-x C-SPC" . 'counsel-mark-ring)
   :map minibuffer-local-map
   ("C-r" . counsel-minibuffer-history)))

;; amx: M-x命令历史
(use-package amx
  :ensure t
  :init (amx-mode))

;; ace-window: 对不同的windows进行编号，方便C-x o跳转
(use-package ace-window
  :ensure t
  :bind (("C-x o" . 'ace-window)))

;; mwin: 修改C-a和C-e
(use-package mwim
  :ensure t
  :bind
  ("C-a" . mwim-beginning-of-code-or-line)
  ("C-e" . mwim-end-of-code-or-line))

;; undo-tree: 可以配置让所有的undo操作保存到某个特定文件夹中
(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode)
  :after hydra
  :bind ("C-x C-h u" . hydra-undo-tree/body) ; 调出一组命令，配置时加上 /body
  :hydra (hydra-undo-tree (:hint nil)
			  " _p_: undo _n_: redo _s_: save _l_: load "
			  ("p" undo-tree-undo)
			  ("n" undo-tree-redo)
			  ("s" undo-tree-save-history)
			  ("l" undo-tree-load-history)
			  ("u" undo-tree-visualize "visualize" :color blue)
			  ("q" nil "quit" :color blue))
  :custom
  (undo-tree-auto-save-history nil)) ; 不把undo的历史保存在文件夹中

;; smart-mode-line: 配置mode-line
;; (use-package smart-mode-line
;;   :ensure t
;;   :init (sml/setup))

;; good-scroll: 平滑滚动
(use-package good-scroll
  :ensure t
  :if window-system ; 图形界面才有
  :init (good-scroll-mode))

;; which-key，marginalia: 为选项添加注解
(use-package which-key
  :ensure t
  :init (which-key-mode))
(use-package marginalia
  :ensure t
  :init (marginalia-mode)
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle)))
;; embark: 中断以查看文件，与marginalia一同使用为宜
(use-package embark
  :ensure t
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  :bind
  (("C-." . embark-act)     ;; pick some comfortable binding
   ("C-;" . embark-dwim)    ;; good alternative: M-.
   ("C-h B" . embark-bindings))) ;; alternative for `describe-bindings'

;; avy: easymotion般快速跳转
(use-package avy
  :ensure t
  :config
  (defun avy-action-embark (pt)
    (umwind-protect
     (save-excursion
       (goto-char pt)
       (embark-act))
     (select-window
      (cdr (ring-ref avy-ring 0))))
    t)
  (setf (alist-get ?e avy-dispatch-alist) 'avy-action-embark)
  :bind
  (("C-j C-SPC" . avy-goto-char-timer))) ; C-j C-SPC后输入要跳转到的字符

;; multiple-cursors: 多光标编辑
(use-package multiple-cursors
  :ensure t
  :after hydra
  :bind
  (("C-x C-h m" . hydra-multiple-cursors/body)
   ("C-S-<mouse-1>" . mc/toggle-cursor-on-click))
  :hydra
  (hydra-multiple-cursors
   (:hint nil)
   "
Up^^       Down^^      Miscellaneous      % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
------------------------------------------------------------------
 [_p_]  Prev   [_n_]  Next   [_l_] Edit lines [_0_] Insert numbers
 [_P_]  Skip   [_N_]  Skip   [_a_] Mark all  [_A_] Insert letters
 [_M-p_] Unmark  [_M-n_] Unmark  [_s_] Search   [_q_] Quit
 [_|_] Align with input CHAR    [Click] Cursor at point"
   ("l" mc/edit-lines :exit t)
   ("a" mc/mark-all-like-this :exit t)
   ("n" mc/mark-next-like-this)
   ("N" mc/skip-to-next-like-this)
   ("M-n" mc/unmark-next-like-this)
   ("p" mc/mark-previous-like-this)
   ("P" mc/skip-to-previous-like-this)
   ("M-p" mc/unmark-previous-like-this)
   ("|" mc/vertical-align)
   ("s" mc/mark-all-in-region-regexp :exit t)
   ("0" mc/insert-numbers :exit t)
   ("A" mc/insert-letters :exit t)
   ("<mouse-1>" mc/add-cursor-on-click)
   ;; Help with click recognition in this hydra
   ("<down-mouse-1>" ignore)
   ("<drag-mouse-1>" ignore)
   ("q" nil)))

;; dashboard
(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "Welcome to Emacs!") ;; 个性签名，随读者喜好设置
  ;; (setq dashboard-projects-backend 'projectile) ;; 读者可以暂时注释掉这一行，等安装了 projectile 后再使用
  (setq dashboard-startup-banner 'official) ;; 也可以自定义图片
  (setq dashboard-items '((recents . 5)  ;; 显示多少个最近文件
                          (bookmarks . 5) ;; 显示多少个最近书签
                          (projects . 10))) ;; 显示多少个最近项目
  (dashboard-setup-startup-hook))

;; tiny: 用来多重操作
(use-package tiny
  :ensure t
  ;; :bind
  ;; ("C-;" . tiny-expand)
  )

;; highlight-symbol: 高亮相同的字符串
(use-package highlight-symbol
  :ensure t
  :init (highlight-symbol-mode)
  :bind ("<f3>" . highlight-symbol)) ; 按F3高亮当前符号
;; rainbow-delimiters: 彩虹括号
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; evil: vim
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package evil-escape
  :ensure t
  :init)
;; {{ https://github.com/syl20bnr/evil-escape
(setq-default evil-escape-delay 0.3)
(setq evil-escape-excluded-major-modes '(dired-mode))
(setq-default evil-escape-key-sequence "kj")
;; disable evil-escape when input method is on
(evil-escape-mode 1)
;; }}

;; 主题
(setq custom-nw-file (expand-file-name "lisp/custom-nw.el" user-emacs-directory))
(setq custom-gui-file (expand-file-name "lisp/custom-gui.el" user-emacs-directory))
(if (display-graphic-p)
    (progn
      (setq custom-file custom-gui-file)
      (add-to-list 'default-frame-alist '(ns-apperance . dark))
                                        ;other settings
      )
  (progn
    (setq custom-file custom-nw-file)
    ;;other settings
    ))
(load custom-file)

;; end
(provide 'init)
