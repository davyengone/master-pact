(module hellomodule CAP
    (defcap CAP () true)
    
    (defun sayHi (name: string)
        (format "good morning, {}" [name]))
    )
