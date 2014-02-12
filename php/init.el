;;php-mode
(add-to-list 'load-path "~/.emacs.d/php")
;;(autoload 'php-mode "php-mode" "PHP editing mode." t)
(require 'php-mode)
;;根据文件扩展名自动php-mode
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))
;;开发项目时，php源文件使用其他扩展名
(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))
;;自动补全设置 
;;(setq php-manual-path "~/.emacs.d/php/php-manual")
;;ls -1 function*.html | sed -e 's/^function\.\([-a-zA-Z_0-9]*\)\.html/\1/' | tr - _ > ~/.emacs.d/php/php-completion-file
(setq php-completion-file "~/.emacs.d/php/php-completion-file")
;;因为php-model只设置了在窗口方式下的功能键M-tab。
(global-set-key [(control f8)] 'php-complete-function)
;;;;;;;;;;;;;;;;;;;;;;;;;结束配置;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
