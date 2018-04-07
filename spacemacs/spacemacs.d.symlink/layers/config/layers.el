(configuration-layer/declare-layers
  '(
     ;; Personal Layers
     macros

     emoji
     ;; Core Config layers
     ( git :variables
       git-magit-status-fullscreen t
       git-variable-example nil )
     ( github :variables
       gist-view-gist t )
     semantic
     ( syntax-checking :variables
       syntax-checking-use-original-bitmaps t
       syntax-checking-enable-by-default t
       syntax-checking-enable-tooltips nil )
     spell-checking
     smex
     theming
     ( auto-completion :variables
       auto-completion-return-key-behavior 'complete
       auto-completion-tab-key-behavior 'complete
       auto-completion-complete-with-key-sequence nil
       auto-completion-complete-with-key-sequence-delay 0.1
       auto-completion-private-snippets-directory nil
       auto-completion-enable-snippets-in-popup t )
     ;; ( helm :variables
     ;;   helm-mode-fuzzy-match t
     ;;   helm-completion-in-region-fuzzy-match t
     ;;   helm-candidate-number-limit 10 )
     (ivy :variables
       ivy-enable-advanced-buffer-information t
       ivy-extra-directories nil)
     ( org :variables
       org-enable-reveal-js-support t
       org-enable-bootstrap-support t
       org-enable-github-support t
       org-want-todo-bindings t
       :packages ( not org-present ) )
     ( shell :variables
       shell-default-term-shell "/usr/local/bin/zsh"
       shell-default-shell 'multi-term
       comint-scroll-show-maximum-output nil
       comint-move-point-for-output nil )
     ( version-control :variables
       version-control-global-margin t
      version-control-diff-tool 'git-gutter+ )
     ( osx :variables
       osx-use-option-as-meta nil )
     ( ibuffer :variables
       ibuffer-group-buffers-by 'projects )
     ))
