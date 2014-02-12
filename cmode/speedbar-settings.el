;;==============================================================================
;;speedbar显示方式
;;==============================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;独立模式
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; switch between main frame and speedbar frame. 
;;(global-set-key [(f4)] 'speedbar-get-focus) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;镶嵌模式
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'sr-speedbar)
(global-set-key [(s-f4)] 'sr-speedbar-toggle)


;;==============================================================================
;;speedbar基本设置
;;==============================================================================
;; 左侧/右侧显示(左:nil 右:t)
(setq sr-speedbar-right-side nil)

;; 排序
(setq speedbar-sort-tags t)

;; 不显示图标
(setq speedbar-use-images nil)

;; 自动刷新
(setq sr-speedbar-auto-refresh t)

;; prevent the speedbar to update the current state, since it is always changing
;;(setq dframe-update-speed t)   

;; 开启时删除其他窗口
;;(setq sr-speedbar-delete-windows t)

;; 设置宽度
(setq sr-speedbar-max-width 35)	;;最大宽度
(setq sr-speedbar-width 35) ;;宽度

;; 显示所有格式文件
(setq speedbar-show-unknown-files t)

;;(setq sr-speedbar-right-side nil)
;;(setq sr-speedbar-width 35)
;;(setq speedbar-show-unknown-files t)
;;(setq dframe-update-speed t)        ;; prevent the speedbar to update the current state, since it is always changing

(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)

;; inhibit tags grouping and sorting 
(setq speedbar-tag-hierarchy-method '(speedbar-simple-group-tag-hierarchy) ) 

;;最后这个的缺省值是 
;;(defcustom speedbar-tag-hierarchy-method '(speedbar-prefix-group-tag-hierarchy speedbar-trim-words-tag-hierarchy))
;;它会将tags排列、提取前缀、并分组。但通常都希望按照 tag出现行号的先后依次排列，就像vim的taglist一样， 所以改成speedbar-simple-group-tag-hierarchy。


;; fix speedbar in left, and set auto raise mode 
;;(add-hook 'speedbar-mode-hook 
;;    (lambda () 
;;        (auto-raise-mode 1) 
;;        (add-to-list 'speedbar-frame-parameters '(top . 40)) 
;;        (add-to-list 'speedbar-frame-parameters '(left . 0))))


(provide 'speedbar-settings)
