;;; Dotspacemacs

;; -- Alistair Stead's Spacemacs Configuration --
;; -- Contact: alistair_stead@me.com --
;; -- MIT License --
;; -- Emacs 25.2.1 - Dev Branch - Release 0.200.9.x - pulled/pkgs updated: 5/29 --
;; -- See README for details and VERSION for updates --
;;
;; All configuration is housed in personal layers

(defvar linux? (eq system-type 'gnu/linux)
    "Are we on a gnu/linux machine?")

(defvar desktop? (= 1440 (display-pixel-height))
    "Am I on my desktop? For determining font size.")

(defun os-path (path)
  "Prepend drive label to PATH if on windows machine."
  (if linux?
    path
    (expand-file-name path "c:")))

;;;; Spacemacs Initialization

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (dotspacemacs/init/coding)
  (dotspacemacs/init/display)
  (dotspacemacs/init/evil)
  (dotspacemacs/init/keys)
  (dotspacemacs/init/layouts)
  (dotspacemacs/init/misc)
  (dotspacemacs/init/packages)
  (dotspacemacs/init/startup)
  )

;;;; Spacemacs Layers

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
 values."
  (dotspacemacs/layers/config)
  (dotspacemacs/layers/packages)
  )

;;;; Spacemacs User Initialization

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (setq custom-file "./elisp/.custom-settings.el"))

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (dotspacemacs/user-config/toggles)
  (dotspacemacs/user-config/experiments))

;;; Spacemacs/Layers

;;;; Local

(defvar dotspacemacs/layers/local
  '(
     (macros :location local)    ; All local layers inherit these macros
     (config :location local)    ; Org, Avy, Evil, Misc... config
     (display :location local)   ; Pretty-eshell/code/outlines... pkgs
     (langs :location local)     ; Language config
     (personal :location local)  ; Personal pkgs
     )
  "Local layers housed in '~/.spacemacs.d/layers'.")

;;;; Core

(defvar dotspacemacs/layers/core
  '(
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; helm
     ;; better-defaults
     git
     auto-completion
     ivy
     )
  "Layers I consider core to Spacemacs")

;;;; Language Support

(defvar dotspacemacs/layers/langs
  '(
     html
     javascript
     markdown
     ruby
     yaml
     )
  "Programming and markup language layers")
;;;; Extra

(defvar dotspacemacs/layers/extra
  '(dash
     docker
     )
  "Miscellaneous layers")

;;;; Layers/config

(defun dotspacemacs/layers/config ()
  (setq-default
    ;; Base distribution to use. This is a layer contained in the directory
    ;; `+distribution'. For now available distributions are `spacemacs-base'
    ;; or `spacemacs'. (default 'spacemacs)
    dotspacemacs-distribution 'spacemacs
    ;; Lazy installation of layers (i.e. layers are installed only when a file
    ;; with a supported type is opened). Possible values are `all', `unused'
    ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
    ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
    ;; lazy install any layer that support lazy installation even the layers
    ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
    ;; installation feature and you have to explicitly list a layer in the
    ;; variable `dotspacemacs-configuration-layers' to install it.
    ;; (default 'unused)
    dotspacemacs-enable-lazy-installation 'unused
    ;; If non-nil then Spacemacs will ask for confirmation before installing
    ;; a layer lazily. (default t)
    dotspacemacs-ask-for-lazy-installation t
    ;; If non-nil layers with lazy install support are lazy installed.
    ;; List of additional paths where to look for configuration layers.
    ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
    dotspacemacs-configuration-layer-path `(,(os-path "~/.spacemacs.d/layers/"))
    ;; List of configuration layers to load.
    dotspacemacs-configuration-layers
    (append
      dotspacemacs/layers/core
      dotspacemacs/layers/langs
      dotspacemacs/layers/extra
      dotspacemacs/layers/local
      )
    ))

;;;; Layers/packages

"Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
(defun dotspacemacs/layers/packages ()
  (setq-default
    ;; List of additional packages that will be installed without being
    ;; wrapped in a layer. If you need some configuration for these
    ;; packages, then consider creating a layer. You can also put the
    ;; configuration in `dotspacemacs/user-config'.
    dotspacemacs-additional-packages '(solarized-theme
                                        yaml-mode
                                        nord-theme
                                        all-the-icons
                                        prettier-js
                                        editorconfig)
    ;; A list of packages that will not be installed and loaded.
    dotspacemacs-excluded-packages '()
    ;; A list of packages that cannot be updated.
    dotspacemacs-frozen-packages '()
    ;; Defines the behaviour of Spacemacs when installing packages.
    ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
    ;; `used-only' installs only explicitly used packages and uninstall any
    ;; unused packages as well as their unused dependencies.
    ;; `used-but-keep-unused' installs only the used packages but won't uninstall
    ;; them if they become unused. `all' installs *all* packages supported by
    ;; Spacemacs and never uninstall them. (default is `used-only')
    dotspacemacs-install-packages 'used-only
    ))

;;; Spacemacs/Init
;;;; Coding

(defun dotspacemacs/init/coding ()
  (setq-default
    ;; list of search tool executable names. spacemacs uses the first installed
    ;; tool of the list. supported tools are `ag', `pt', `ack' and `grep'.
    ;; (default '("ag" "pt" "ack" "grep"))
    dotspacemacs-search-tools '("ag" "rg" "pt" "ack" "grep")
    ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
    ;; scrolling overrides the default behavior of Emacs which recenters point
    ;; when it reaches the top or bottom of the screen. (default t)
    dotspacemacs-smooth-scrolling t
    ;; code folding method. possible values are `evil' and `origami'.
    ;; (default 'evil)
    dotspacemacs-folding-method 'evil
    ;; if non-nil smartparens-strict-mode will be enabled in programming modes.
    ;; (default nil)
    dotspacemacs-smartparens-strict-mode t
    ;; if non-nil pressing the closing parenthesis `)' key in insert mode passes
    ;; over any automatically added closing parenthesis, bracket, quote, etc…
    ;; this can be temporary disabled by pressing `c-q' before `)'. (default nil)
    dotspacemacs-smart-closing-parenthesis t
    ;; select a scope to highlight delimiters. possible values are `any',
    ;; `current', `all' or `nil'. default is `all' (highlight any scope and
    ;; emphasis the current one). (default 'all)
    dotspacemacs-highlight-delimiters 'all
    ;; Control line numbers activation.
    ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
    ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
    ;; This variable can also be set to a property list for finer control:
    dotspacemacs-line-numbers '(:relative nil
      :disabled-for-modes dired-mode
                          doc-view-mode
                          markdown-mode
                          org-mode
                          pdf-view-mode
                          text-mode
      :size-limit-kb 1000)
    ;; (default nil)
    ;; dotspacemacs-line-numbers 't
    ;; delete whitespace while saving buffer. possible values are `all'
    ;; to aggressively delete empty line and long sequences of whitespace,
    ;; `trailing' to delete only the whitespace at end of lines, `changed'to
    ;; delete only whitespace for changed lines or `nil' to disable cleanup.
    ;; (default nil)
    dotspacemacs-whitespace-cleanup 'all
    ))

;;;; Display

(defun dotspacemacs/init/display ()
  (setq-default
    dotspacemacs-themes
    '(
       ;; ( atom-material :location local )
       sanityinc-tomorrow-eighties
       twilight-anti-bright
       darktooth
       spacemacs-dark
       spacemacs-light
       solarized-dark
       solarized-light
       leuven
       monokai
       zenburn
    )
    dotspacemacs-default-font
    `(
       "Operator Mono Medium"
       :size ,(cond ((not linux?) 16)
                (desktop? 18)
                (t 20))
       :powerline-scale 1.5
       )
    ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
    ;; (Emacs 24.4+ only)
    dotspacemacs-fullscreen-at-startup (if linux? nil t)
    ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
    ;; Use to disable fullscreen animations in OSX. (default nil)
    dotspacemacs-fullscreen-use-non-native nil
    ;; If non nil the frame is maximized when Emacs starts up.
    ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
    ;; (default nil) (Emacs 24.4+ only)
    dotspacemacs-maximized-at-startup nil
    ;; A value from the range (0..100), in increasing opacity, which describes
    ;; the transparency level of a frame when it's active or selected.
    ;; Transparency can be toggled through `toggle-transparency'. (default 90)
    dotspacemacs-active-transparency 90
    ;; A value from the range (0..100), in increasing opacity, which describes
    ;; the transparency level of a frame when it's inactive or deselected.
    ;; Transparency can be toggled through `toggle-transparency'. (default 90)
    dotspacemacs-inactive-transparency 70
    ;; If non nil unicode symbols are displayed in the mode line. (default t)
    dotspacemacs-mode-line-unicode-symbols t
    dotspacemacs-mode-line-theme '(all-the-icons :separator arrow :separator-scale 1.5)
    ))

;;;; Evil

(defun dotspacemacs/init/evil ()
  (setq-default
    ;; One of `vim', `emacs' or `hybrid'.
    ;; `hybrid' is like `vim' except that `insert state' is replaced by the
    ;; `hybrid state' with `emacs' key bindings. The value can also be a list
    ;; with `:variables' keyword (similar to layers). Check the editing styles
    ;; section of the documentation for details on available variables.
    ;; (default 'vim)
    dotspacemacs-editing-style 'vim
    ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
    dotspacemacs-remap-Y-to-y$ nil
    ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
    ;; there. (default t)
    dotspacemacs-retain-visual-state-on-shift t
    ;; If non-nil, J and K move lines up and down when in visual mode.
    ;; (default nil)
    dotspacemacs-visual-line-move-text nil
    ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
    ;; (default nil)
    dotspacemacs-ex-substitute-global nil
    dotspacemacs-colorize-cursor-according-to-state t
    ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
    ;; several times cycle between the kill ring content. (default nil)
    dotspacemacs-enable-paste-transient-state t
    ;; If non nil show the titles of transient states. (default t)
    dotspacemacs-show-transient-state-title t
    ;; If non nil show the color guide hint for transient state keys. (default t)
    dotspacemacs-show-transient-state-color-guide t
    ))

;;;; Keys

(defun dotspacemacs/init/keys ()
  (setq-default
    dotspacemacs-leader-key "SPC"
    ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
    ;; (default "SPC")
    dotspacemacs-emacs-command-key "SPC"
    ;; The key used for Vim Ex commands (default ":")
    dotspacemacs-ex-command-key ":"
    ;; The leader key accessible in `emacs state' and `insert state'
    ;; (default "M-m")
    dotspacemacs-emacs-leader-key "M-m"
    ;; Major mode leader key is a shortcut key which is the equivalent of
    ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
    dotspacemacs-major-mode-leader-key ","
    ;; Major mode leader key accessible in `emacs state' and `insert state'.
    ;; (default "C-M-m")
    dotspacemacs-major-mode-emacs-leader-key "C-M-m"
    ;; Which-key delay in seconds. The which-key buffer is the popup listing
    ;; the commands bound to the current keystroke sequence. (default 0.4)
    dotspacemacs-which-key-delay 0.2
    ;; Which-key frame position. Possible values are `right', `bottom' and
    ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
    ;; right; if there is insufficient space it displays it at the bottom.
    ;; (default 'bottom)
    dotspacemacs-which-key-position 'bottom
    ;; These variables control whether separate commands are bound in the GUI to
    ;; the key pairs C-i, TAB and C-m, RET.
    ;; Setting it to a non-nil value, allows for separate commands under <C-i>
    ;; and TAB or <C-m> and RET.
    ;; In the terminal, these pairs are generally indistinguishable, so this only
    ;; works in the GUI. (default nil)
    dotspacemacs-distinguish-gui-tab nil
    ))

;;;; Layouts

(defun dotspacemacs/init/layouts ()
  (setq-default
    ;; Name of the default layout (default "Default")
    dotspacemacs-default-layout-name "Default"
    ;; If non nil the default layout name is displayed in the mode-line.
    ;; (default nil)
    dotspacemacs-display-default-layout nil
    ;; If non nil then the last auto saved layouts are resume automatically upon
    ;; start. (default nil)
    dotspacemacs-auto-resume-layouts nil
    ;; Default major mode of the scratch buffer (default `text-mode')
    dotspacemacs-scratch-mode 'org-mode
    dotspacemacs-auto-generate-layout-names t
    dotspacemacs-switch-to-buffer-prefers-purpose nil
    ))

;;;; Misc

(defun dotspacemacs/init/misc ()
  (setq-default
    ;; Size (in MB) above which spacemacs will prompt to open the large file
    ;; literally to avoid performance issues. Opening a file literally means that
    ;; no major mode or minor modes are active. (default is 1)
    dotspacemacs-large-file-size 1
    ;; Location where to auto-save files. Possible values are `original' to
    ;; auto-save the file in-place, `cache' to auto-save the file to another
    ;; file stored in the cache directory and `nil' to disable auto-saving.
    ;; (default 'cache)
    dotspacemacs-auto-save-file-location 'cache
    ;; Maximum number of rollback slots to keep in the cache. (default 5)
    dotspacemacs-max-rollback-slots 5
    ;; if non nil, advise quit functions to keep server open when quitting.
    ;; (default nil)
    dotspacemacs-persistent-server t
    ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
    ;; dotspacemacs-helm-resize nil
    ;; if non nil, the helm header is hidden when there is only one source.
    ;; (default nil)
    ;; dotspacemacs-helm-no-header nil
    ;; define the position to display `helm', options are `bottom', `top',
    ;; `left', or `right'. (default 'bottom)
    ;; dotspacemacs-helm-position 'bottom
    ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
    ;; in all non-asynchronous sources. If set to `source', preserve individual
    ;; source settings. Else, disable fuzzy matching in all sources.
    ;; (default 'always)
    ;; dotspacemacs-helm-use-fuzzy 'always
    ))

;;;; Packages

(defun dotspacemacs/init/packages ()
  (setq-default
    ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
    ;; possible. Set it to nil if you have no way to use HTTPS in your
    ;; environment, otherwise it is strongly recommended to let it set to t.
    ;; This variable has no effect if Emacs is launched with the parameter
    ;; `--insecure' which forces the value of this variable to nil.
    ;; (default t)
    dotspacemacs-elpa-https nil
    ;; Maximum allowed time in seconds to contact an ELPA repository.
    dotspacemacs-elpa-timeout 5
    ;; If non nil then spacemacs will check for updates at startup
    ;; when the current branch is not `develop'. Note that checking for
    ;; new versions works via git commands, thus it calls GitHub services
    ;; whenever you start Emacs. (default nil)
    dotspacemacs-check-for-update nil
    ;; If non-nil, a form that evaluates to a package directory. For example, to
    ;; use different package directories for different Emacs versions, set this
    ;; to `emacs-version'.
    dotspacemacs-elpa-subdirectory nil
    ;; the default package repository used if no explicit repository has been
    ;; specified with an installed package.
    ;; not used for now. (default nil)
    dotspacemacs-default-package-repository nil
    ))

;;;; Startup

(defun dotspacemacs/init/startup ()
  (setq-default
    exec-path-from-shell-check-startup-files nil
    ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
    dotspacemacs-verbose-loading nil
    ;; Specify the startup banner. Default value is `official', it displays
    ;; the official spacemacs logo. An integer value is the index of text
    ;; banner, `random' chooses a random text banner in `core/banners'
    ;; directory. A string value must be a path to an image format supported
    ;; by your Emacs build.
    ;; If the value is nil then no banner is displayed. (default 'official)
    dotspacemacs-startup-banner 'official
    ;; List of items to show in startup buffer or an association list of
    ;; the form `(list-type . list-size)`. If nil then it is disabled.
    ;; Possible values for list-type are:
    ;; `recents' `bookmarks' `projects' `agenda' `todos'."
    ;; List sizes may be nil, in which case
    ;; `spacemacs-buffer-startup-lists-length' takes effect.
    dotspacemacs-startup-lists '((projects . 10)
                                  (recents . 10))
    ;; True if the home buffer should respond to resize events.
    dotspacemacs-startup-buffer-responsive t
    ;; If non nil a progress bar is displayed when spacemacs is loading. This
    ;; may increase the boot time on some systems and emacs builds, set it to
    ;; nil to boost the loading time. (default t)
    dotspacemacs-loading-progress-bar nil
    ))

;;; Spacemacs/User-Config
;;;; Toggles

(defun dotspacemacs/user-config/toggles ()
  "Spacemacs toggles not intended to be put into layers."
  (spacemacs/toggle-highlight-long-lines-globally-on)
<<<<<<< Updated upstream
  ;; (spacemacs/toggle-mode-line-minor-modes-off)
=======
>>>>>>> Stashed changes
  ;; (spacemacs/toggle-aggressive-indent-globally-on)
  (global-highlight-parentheses-mode t)
  (global-company-mode t)
  (fringe-mode '(20 . 20))
  )

;;;; Experiments

<<<<<<< Updated upstream
(defun dotspacemacs/user-config/experiments ()
   "Space for trying out configuration updates."
   (setq tab-always-indent 'complete)
=======
((defun dotspacemacs/user-config/experiments ()
   "Space for trying out configuration updates."
   (setq tab-always-indent 'complete)
   (add-hook 'js2-mode-hook 'prettier-js-mode)
   (add-hook 'web-mode-hook 'prettier-js-mode)
>>>>>>> Stashed changes
   (exec-path-from-shell-copy-env "PATH")
   (set-frame-parameter nil 'background-mode 'light)
   (set-terminal-parameter nil 'background-mode 'light)
   (add-hook 'alchemist-mode-hook 'company-mode)
   (add-hook 'elixir-mode-hook
     (function (lambda ()
                 (setq evil-shift-width elixir-smie-indent-basic))))
<<<<<<< Updated upstream
   )
=======
   ))
>>>>>>> Stashed changes
