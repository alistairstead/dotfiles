;;; Display Layer

(setq display-packages
  '(
     ;; Language specific updates

     ;; Core Display Packages
     all-the-icons
     all-the-icons-dired
     spaceline-all-the-icons
     (prettify-utils :location (recipe :fetcher github
                                 :repo "Ilazki/prettify-utils.el"))
     hlinum
     ;; Local packages
     (pretty-code :location local)
     (pretty-fonts :location local)
     (pretty-outlines :location local)
     ))

;;; Locals
;;;; Pretty-code

(defun display/init-pretty-code ()
  (use-package pretty-code
    ;; :after hy-mode python
    :config
    (progn
      (global-prettify-symbols-mode 1)

      (setq elixir-pretty-pairs
        (pretty-code-get-pairs
          '(:pipe-right "|>"
             :pipe-left "<|"
             :arrow-left "<-"
             :arrow-right "->"
             :hashrocket-left "<="
             :hashrocket-right "=>"
             :not-equal "!="
             :equal "==")))

      (pretty-code-set-pairs `((elixir-mode-hook     ,elixir-pretty-pairs))))))

;;;; Pretty-fonts

(defun display/init-pretty-fonts ()
  (use-package pretty-fonts
    :config
    (progn
      (pretty-fonts-set-fontsets
        '(("fontawesome"
            ;;                         
            #xf07c #xf0c9 #xf0c4 #xf0cb #xf017 #xf101)

           ("all-the-icons"
             ;;    
             #xe907 #xe928)

           ("github-octicons"
             ;;                          
             #xf091 #xf059 #xf076 #xf075 #xf092 #xf016)

           ("material icons"
             ;;        
             #xe871 #xe918 #xe3e7
             ;;
             #xe3d0 #xe3d1 #xe3d2 #xe3d4)

           ("Symbola"
             ;; 𝕊    ⨂      ∅      ⟻    ⟼     ⊙      𝕋       𝔽
             #x1d54a #x2a02 #x2205 #x27fb #x27fc #x2299 #x1d54b #x1d53d
             ;; 𝔹    𝔇       𝔗
             #x1d539 #x1d507 #x1d517))))))

;;;; Pretty-magit

(defun display/init-pretty-magit ()
  (use-package pretty-magit
    :config
    (progn
      (pretty-magit "origin"  ? (:box t :height 1.2) t))))

;;;; Pretty-outlines

(defun display/init-pretty-outlines ()
  (use-package pretty-outlines
    :after outshine
    :config
    (progn
      ;; Ellipsis
      (add-hook 'outline-mode-hook 'pretty-outline-set-display-table)
      (add-hook 'outline-minor-mode-hook 'pretty-outline-set-display-table)

      ;; Outlines
      (add-hook 'emacs-lisp-mode-hook 'pretty-outline-add-bullets)
      (add-hook 'hy-mode-hook 'pretty-outline-add-bullets)
      (add-hook 'python-mode-hook 'pretty-outline-add-bullets)
      )))

;;;; Windows-frame-size-fix

(defun display/init-windows-frame-size-fix ()
  (use-package windows-frame-size-fix
    :if (not is-linuxp)))

;;; Core Packages
;;;; All-the-icons

(defun display/init-all-the-icons ()
  (use-package all-the-icons
    :config
    (progn
      ;; graphviz-dot-mode
      (add-to-list
        'all-the-icons-icon-alist
        '("\\.dot$" all-the-icons-fileicon "graphviz" :face all-the-icons-pink))
      (add-to-list
        'all-the-icons-mode-icon-alist
        '(graphviz-dot-mode all-the-icons-fileicon "graphviz" :face all-the-icons-pink))
      )))

;;;; All-the-icons-dired

(defun display/init-all-the-icons-dired ()
  (use-package all-the-icons-dired
    :config
    (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)))

;;;; Prettify-utils

(defun display/init-prettify-utils ()
  (use-package prettify-utils))

;;;; Spaceline-all-the-icons

(defun display/init-spaceline-all-the-icons ()
  (use-package spaceline-all-the-icons
    :after spaceline
    :config
    (progn
      (spaceline-all-the-icons-theme)

      ;; (setq spaceline-highlight-face-func 'spaceline-highlight-face-default)
      (setq spaceline-all-the-icons-icon-set-modified 'toggle
        spaceline-all-the-icons-icon-set-bookmark 'bookmark
        spaceline-all-the-icons-icon-set-dedicated 'pin
        spaceline-all-the-icons-icon-set-window-numbering 'solid
        spaceline-all-the-icons-icon-set-multiple-cursors 'pointer
        spaceline-all-the-icons-icon-set-git-status 'arrows
        spaceline-all-the-icons-icon-set-flycheck-slim 'solid
        spaceline-all-the-icons-icon-set-sun-time 'arrows
        spaceline-all-the-icons-flycheck-alternate t
        ;; spaceline-all-the-icons-highlight-file-name t
        spaceline-all-the-icons-hide-long-buffer-path t
        spaceline-all-the-icons-separator-type 'none)

      ;; Toggles
      (spaceline-toggle-all-the-icons-buffer-size-off)
      (spaceline-toggle-all-the-icons-buffer-position-off)
      (spaceline-toggle-all-the-icons-eyebrowse-workspace-off)
      ;; (spaceline-toggle-all-the-icons-modified-off)
      (spaceline-toggle-all-the-icons-bookmark-off)
      (spaceline-toggle-all-the-icons-dedicated-off)
      (spaceline-toggle-all-the-icons-fullscreen-off)

      ;; Optional dependencies
      (spaceline-all-the-icons--setup-git-ahead)
      (spaceline-all-the-icons--setup-paradox))))

;;;; hlinum

(defun display/init-hlinum ()
  (use-package hlinum
    :config
    (progn
      (hlinum-activate))))
