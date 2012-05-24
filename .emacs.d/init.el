
;; -------------------------------------
;; Load all the bits where the real action happens

(push "~/bin" exec-path)
(push "/usr/local/bin" exec-path)
(push "/usr/texbin" exec-path)
(setenv "PATH" (mapconcat (lambda (dir) (expand-file-name (or dir ".")))
                          exec-path path-separator))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; This path is used by lots of different single-file packages
(add-to-list 'load-path "~/.emacs.d/packages")

;; Visual/GUI settings
(load "~/.emacs.d/init.d/visual.el")
(load "~/.emacs.d/init.d/visual-line-mode.el")

;; File editing/writing settings
(load "~/.emacs.d/init.d/editing.el")
(load "~/.emacs.d/init.d/printing.el")

;; Global key bindings
(load "~/.emacs.d/init.d/keys.el")

;; These are used by several of the below
(require 'filladapt)
(require 'todochiku)
(setq todochiku-icons-directory "~/.emacs.d/packages/todochiku-icons")

;; Package configurations
(load "~/.emacs.d/init.d/ido.el")
(load "~/.emacs.d/init.d/dired.el")
(load "~/.emacs.d/init.d/eshell.el")
(load "~/.emacs.d/init.d/mu4e.el")
(load "~/.emacs.d/init.d/org.el")
(load "~/.emacs.d/init.d/jabber.el")
(load "~/.emacs.d/init.d/yasnippet.el")
(load "~/.emacs.d/init.d/code.el")

;; -------------------------------------
;; Magit

(add-to-list 'load-path "~/.emacs.d/packages/magit.git")
(require 'magit)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))
(set-face-foreground 'magit-diff-add "green3")
(set-face-foreground 'magit-diff-del "red3")

(global-set-key [f6] 'magit-status)

;; -------------------------------------
;; Markdown mode

(add-to-list 'load-path "~/.emacs.d/packages/markdown-mode.git")
(autoload 'markdown-mode "markdown-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;; -------------------------------------
;; Fill Column Indicator mode

(add-to-list 'load-path "~/.emacs.d/packages/fill-column-indicator.git")
(autoload 'fci-mode "fill-column-indicator" nil t)
(setq fci-rule-color "#282A2E")

;; -------------------------------------
;; AUCTeX

(add-to-list 'load-path "~/.emacs.d/packages/auctex-11.86")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(add-to-list 'completion-ignored-extensions ".aux")
(add-to-list 'completion-ignored-extensions ".ent")
(add-to-list 'completion-ignored-extensions ".toc")
(add-to-list 'completion-ignored-extensions ".bbl")
(add-to-list 'completion-ignored-extensions ".blg")
(add-to-list 'completion-ignored-extensions ".fdb_latexmk")

(setq TeX-save-query nil
      TeX-parse-self t
      TeX-auto-save t
      TeX-auto-untabify t
      TeX-command-default "Latexmk"
      TeX-view-program-list '(("Open" "open %s.pdf"))
      TeX-view-program-selection '((output-pdf "Open"))
      font-latex-fontify-sectioning 'color
      TeX-command-list '(
                         ("Latexmk" "latexmk -pdf -ps- -dvi- -pdflatex='pdflatex -interaction=nonstopmode %%O %%S' %s" TeX-run-command nil t :help "Run Latexmk on file")
                         ("XeLatexmk" "latexmk -pdf -ps- -dvi- -pdflatex='xelatex -interaction=nonstopmode %%O %%S' %s" TeX-run-command nil t :help "Run Latexmk on file")
                         ("View" "%V" TeX-run-discard-or-function nil t :help "Run Viewer")
                         ("Clean" "latexmk -c %s" TeX-run-command nil t :help "Delete generated intermediate files")))

;; -------------------------------------
;; CSS mode

(autoload 'css-mode "css-mode-1.0" nil t)
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-hook 'css-mode-hook '(lambda ()
                            (setq css-indent-level 2)
                            (setq css-indent-offset 2)))

;; -------------------------------------
;; Ruby mode

(autoload 'ruby-mode "ruby-mode-1.1" nil t)
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'completion-ignored-extensions ".rbc")

;; -------------------------------------
;; YAML mode

(add-to-list 'load-path "~/.emacs.d/packages/yaml-mode.git/")
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; -------------------------------------
;; RHTML mode

(add-to-list 'load-path "~/.emacs.d/packages/rhtml.git/")
(autoload 'rhtml-mode "rhtml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))

;; -------------------------------------
;; Cucumber feature mode

(add-to-list 'load-path "~/.emacs.d/packages/cucumber.el.git/")
(autoload 'feature-mode "feature-mode" nil t)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; -------------------------------------
;; JS2 mode

(add-to-list 'load-path "~/.emacs.d/packages/js2-mode.git/")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\(on\\)?$" . js2-mode))

;; -------------------------------------
;; Python mode

(add-to-list 'load-path "~/.emacs.d/packages/python-mode.git/")
(autoload 'python-mode "python-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; -------------------------------------
;; Haml mode

(add-to-list 'load-path "~/.emacs.d/packages/haml-mode.git/")
(autoload 'haml-mode "haml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

;; ----------------------------------------------------
;; CMake mode

(require 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt$" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake$" . cmake-mode))

;; ----------------------------------------------------
;; C mode

(defun cpence-c-mode-hook ()
  (interactive)

  ;; Engage automatic-everything mode
  (c-toggle-auto-state 1)

  ;; Don't indent namespaces, do indent comments
  (c-set-offset 'innamespace 0)
  (setq c-comment-only-line-offset 0)

  ;; Set cleanups
  (add-to-list 'c-cleanup-list 'defun-close-semi)
)
(add-hook 'c-mode-common-hook 'cpence-c-mode-hook)

;; Set indentation options
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; H files should be in C++ by default
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; -------------------------------------
;; Mode hooks

(defun cpence-text-mode-hook ()
  (interactive)

  (hl-line-mode)
  (set (make-local-variable 'hl-line-range-function) 'visual-line-line-range)

  (visual-line-mode)
  (set-visual-wrap-column 82)

  (set-tab-stop-width 2)
)
(add-hook 'text-mode-hook 'cpence-text-mode-hook)

(defun cpence-latex-mode-hook ()
  (interactive)

  ;; Patch up some variables
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'LaTeX-indent-line)

  ;; Make sure these stay set right
  (TeX-PDF-mode-on)
  (setq TeX-command-default "Latexmk")

  ;; Check spelling
  (flyspell-mode 1)
)
(add-hook 'LaTeX-mode-hook 'cpence-latex-mode-hook)

(defun cpence-markdown-mode-hook ()
  (interactive)

  (setq mode-name "md")
  
  ;; Actually insert tab characters and newlines, indentation stuff
  ;; goes crazy in markdown-mode for some reason
  (define-key markdown-mode-map (kbd "<tab>") 'tab-to-tab-stop)
  (define-key markdown-mode-map (kbd "C-m") 'newline)

  (set-tab-stop-width 4)
)
(add-hook 'markdown-mode-hook 'cpence-markdown-mode-hook)

;; When killing a line, strip the indentation characters off
;; of the front
(defun kill-and-join-forward (&optional arg)
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (progn (forward-char 1)
             (just-one-space 0)
             (backward-char 1)
             (kill-line arg))
    (kill-line arg)))

(defun cpence-code-mode-hook ()
  (interactive)

  ;; Highlight current line
  (hl-line-mode)
  
  ;; Newline = indent
  (local-set-key (kbd "RET") 'newline-and-indent)

  ;; And bind kill-line to indent-killing-kill-line in
  ;; all source modes
  (local-set-key (kbd "C-k") 'kill-and-join-forward)

  ;; Show me the fill column
  (fci-mode 1)
)

;; There's no "general" mode-hook that handles all of the
;; programming modes, so we have to set all these hooks
;; ourselves.
(add-hook 'c-mode-common-hook 'cpence-code-mode-hook)
(add-hook 'cmake-mode-hook 'cpence-code-mode-hook)
(add-hook 'html-mode-hook 'cpence-code-mode-hook)
(add-hook 'css-mode-hook 'cpence-code-mode-hook)
(add-hook 'asm-mode-hook 'cpence-code-mode-hook)
(add-hook 'xml-mode-hook 'cpence-code-mode-hook)
(add-hook 'js2-mode-hook 'cpence-code-mode-hook)
(add-hook 'python-mode-hook 'cpence-code-mode-hook)
(add-hook 'ruby-mode-hook 'cpence-code-mode-hook)
(add-hook 'rhtml-mode-hook 'cpence-code-mode-hook)
(add-hook 'haml-mode-hook 'cpence-code-mode-hook)
(add-hook 'yaml-mode-hook 'cpence-code-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'cpence-code-mode-hook)


;; Set up the modeline last, so we override all the crazy things other
;; packages do to global-mode-string
(load "~/.emacs.d/init.d/modeline.el")
