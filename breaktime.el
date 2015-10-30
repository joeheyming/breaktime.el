;;; breaktime.el --- Tells you to take a break.
;; Author: Joe Heyming <joeheyming@gmail.com>
;; URL: https://github.com/joeheyming/breaktime.el
;; Version: 1.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;; Commentary:
;;; See: https://www.reddit.com/r/emacs/comments/3icpo7/take_a_break_every_3_hours/

;;; Code:

(defvar breaktime-timer nil
  "Holds the running break timer (if any).")

(defvar breaktime-wait "3 hours"
  "How long to wait for the next break.")

(defvar breaktime-message "Time to take a break."
  "Configure the breaktime message.")

(defun breaktime--set-next-breaktime ()
  "If we kill a breaktime buffer, set another wait timeout."
  (when (string= (buffer-name) "*breaktime*")
    (setq breaktime-timer (run-at-time breaktime-wait nil 'breaktime--take-a-break))))

(add-hook 'kill-buffer-hook #'breaktime--set-next-breaktime)

(defun breaktime--take-a-break ()
  "Invasively create *breaktime* buffer and closes other windows."
  (switch-to-buffer (get-buffer-create "*breaktime*"))
  (let ((inhibit-read-only t))
    (erase-buffer)
    (delete-other-windows)
    (animate-string breaktime-message
                    (/ (window-height) 2) (- (/ (window-width) 2) 12)))
  (set-buffer-modified-p nil)
  (view-mode))

;;;###autoload
(defun breaktime-start ()
  "Start the breaktime loop."
  (interactive)
  (when breaktime-timer
    (cancel-timer breaktime-timer))
  (setq breaktime-timer
        (run-at-time breaktime-wait nil 'breaktime--take-a-break)))

;;;###autoload
(defun breaktime-stop ()
  "Stop the breaktime loop."
  (interactive)
  (when breaktime-timer
    (cancel-timer breaktime-timer)
    (setq breaktime-timer nil)))
(provide 'breaktime)

;;; breaktime.el ends here
