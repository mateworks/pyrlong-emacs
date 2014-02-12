;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 基础定义
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;sr-speedbar-toggle的实现，用作参考
;;(if (sr-speedbar-exist-p)
;;      (sr-speedbar-close)
;;    (sr-speedbar-open))

;;minimap-toggle的实现，用作参考
;;(if (and minimap-window
;;           (window-live-p minimap-window))
;;      (minimap-kill)
;;    (minimap-create)))

;;下面代码保证emacs在新打开compile窗口的时候只会水平分割窗口
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;;缩小的compile窗口（只占emacs窗体1/4），避免其和代码窗口平分屏幕，
;;尤其是代码窗口和compile窗口是上下分布的情况，这点更为重要。
(defun shrink-compile-window()
  "shrink compile window, avoid compile window occupy 1/2 hight of whole window"
  (interactive)
  
  (delete-other-windows)
  
  ;;(setq minimap-is-opened (and minimap-window (window-live-p minimap-window)))
  ;;(if minimap-is-opened
  ;;	(minimap-kill))
  
  ;;(sr-speedbar-toggle)
  (setq speedbar-is-opened (sr-speedbar-exist-p))
  (if speedbar-is-opened
	  (sr-speedbar-close))
  
  ;;-----------------------------------------------------------
  ;;(select-window (get-buffer-window "*compilation*"))
  (setq temp-buffer-name (buffer-name (current-buffer)))
  (switch-to-buffer-other-window "*compilation*")
  (if (< (/ (frame-height) 3) (window-height))
      (shrink-window (/ (window-height) 2)))
  (switch-to-buffer-other-window temp-buffer-name)
  ;;-----------------------------------------------------------
  ;;(sr-speedbar-toggle)
  ;;(if minimap-is-opened
  ;;	(minimap-create))
  (if speedbar-is-opened
	  (sr-speedbar-open))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 通用定义
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun compile-project (compile-cmd)
  "compile project"
  (interactive)
  
  (shrink-compile-window)
  (compile compile-cmd)
  )

(defun start-run-project ()
  "run project"
  (interactive)
  (progn
	(setq temp (split-string (directory-file-name default-directory) "/"))
	(setq lens (length temp))
	(setq dirname (nth (- lens 1) temp))
	(setq run-cmd (concat default-directory dirname))	;;(setq run-cmd (concat "goexec " default-directory dirname))
	;;(message run-cmd)
	(compile-project run-cmd)))

(defun stop-run-project ()
  "stop run project"
  (interactive)
  (progn
    (if (get-buffer "*compilation*") ; If old compile window exists
		(progn
		  (delete-windows-on (get-buffer "*compilation*"))
		  ;;(kill-buffer "*compilation*") ; and kill the buffers
		  (kill-compilation) ))))

(defun compilation-mode-key-bindings ()
  (global-set-key [C-f5] 'start-run-project)  			
  (global-set-key [S-f5] 'stop-run-project)
  (global-set-key (kbd "C-c z")  'shrink-compile-window))   	

(compilation-mode-key-bindings)
;;(add-hook 'go-mode-hook 'compilation-mode-key-bindings)


;;------------------------------------------------------------------------------
;;编译成功后自动关闭"compilation* buffer
;;------------------------------------------------------------------------------
(defun kill-buffer-when-compile-success (process)
  "Close current buffer when `when-compile-success'."
  (set-process-sentinel process
						(lambda (proc change)
						  (when (string-match "finished" change)
							(delete-windows-on (process-buffer proc))))))

;;(add-hook 'run-start-hook 'kill-buffer-when-compile-success)

(provide 'compilation-settings)
