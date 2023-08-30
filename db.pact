(module db-academy CAP
    (defcap CAP() true)
    
    (defschema todoschema 
        title:string
        complete:bool
    )

    (deftable todos-table: {todoschema})

    (defun add-todo(id:string title:string) 
        (insert todos-table id {
            "title":title,
            "complete":false
        })
    )

    (defun read-todo(id:string)
        (read todos-table id)
    )
    
    (defun update-todo(id:string title:string)
       (with-read todos-table id {
            "complete":=comp 
       }
        (enforce (!= comp true) "you cannot update a task that is complete. Toggle first!")
        (update todos-table id {
            "title":title,
            "complete":false
        })
       ) 
    )

    (defun toggle-todo(id:string)
       (with-read todos-table id {
            "complete":= lg
       }(update todos-table id {
            "complete": (not lg)
       })) 
    )

    (defun complete-todo(id:string)
        (update todos-table id {
            "complete":true
        })
    )
)

(create-table todos-table)
