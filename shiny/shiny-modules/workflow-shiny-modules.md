workflow-shiny-modules.md


Develeop your module

1. Write down your goal in plain text
2. Hand-draw an image of your goal
3. Start a new R script
4. Write the UI elements input and output elements and wrap them in fluidPage()
5. Write the server elements as a function(input, output) {renderX({})}
on server side of a Shiny app that achieves your goal.
6. Run the shinyApp(ui, server)
7. Mame the UI part of the module with ending UI (e.g. moduleNameUI)
8. Write a function(id) with id <- NS(id) and wrap input and output in tagList()
9. Rename ids of input and output to ns("your-input") and ns("your-output")
10. Name the server part of the module without ending UI (e.g. moduleName)
11. Include session in function(input, output, session)
12. Use thge exact same body elemtents fom point 5
13. Name input and out the same as ids from 9
14. Your module is ready
15. In your UI inside fluidPage() replace content with moduleNameUI and add a unique id
16. On your server side of the app use callModule() with your moduleName and the same unique id as defined in moduleNameUI
17. Add as many modules as you like, but give each one a unique id 

Rules for making modules Modular

1. Pass all inputs into the module as **arguments** of a module function
2. Return all outputs as the **return value** of a module function 

Add reactivity to your app

There are two ways:

1. A module to pass reactive input from the parent app into the module

- the reactive function is in the server of the parent app
- the textOutput stays in the UI of the module

2. A module to return reactive output from the module to the parent app

- the reactive function is in the server of the module
- the textOutput is in the UI of the parent app


## My idea

- Pass the variable to filter by through an argument in the server function
- Make another Shiny module that collects the data instead of using a UI and server function

