# breaktime.el
Naive breaktime enforcement in emacs

Breaktime will close all your buffers every 3 hours (configurable)
 and then tell you to take a break.

You can start the loop by invoking
```lisp
M-x breaktime-start
```

You can stop the loop by invoking
```lisp
M-x breaktime-stop
```

You can customize your breaktime message by setting this variable:
```lisp
(setq breaktime-message "Hey!!!  Take a break dude!!!")
```
