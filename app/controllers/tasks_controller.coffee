load 'application'


# Entry point
action 'index', ->
   render
       title: "Cozy To-do"


# Helpers

# Return to client a task list like this
# { length: number of taks, rows: task list }
returnTasks = (err, tasks) ->
    if err
        console.log err
        send error: "Retrieve tasks failed.", 500
    else
        send number: tasks.length, rows: tasks


before 'load task', ->
    Task.find params.id, (err, task) =>
        if err
            send error: 'An error occured', 500
        else if task is null
            send error: 'Task not found', 404
        else
            @task = task
            next()
, only: ['update', 'destroy', 'show']


# Controllers


action 'todo', ->
    Task.all {"where": { "done": false } }, returnTasks


action 'archives', ->
    Task.all {"where": { "done": true } }, returnTasks


action 'create', ->
    task = new Task body
    Task.create task, (err, note) =>
        if err
            console.log err
            send error: 'Task cannot be created'
        else
            send task, 201

# Update task and perform completionDate modification depending on whether
# is finished or not.
action 'update', ->

    if body.done? and body.done
        body.completionDate = Date.now()
    else if body.done? and not body.done
        body.completionDate = null

    @task.updateAttributes body, (err) =>
        if err
            console.log err
            send error: 'Task cannot be updated', 500
        else
            send success: 'Task updated'


action 'destroy', ->
    @task.destroy (err) ->
        if err
            console.log err
            send error: 'Cannot destroy task', 500
        else
            send success: 'Task succesfuly deleted'

action 'show', ->
    returnTasks null, [@task]

