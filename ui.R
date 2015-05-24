shinyUI(pageWithSidebar(
  headerPanel("Calculate your child\'s adult height!"),
  sidebarPanel(
    img(src='pixshark.png', height = 130, width = 210),
    p("\n"),
    selectInput('measure', 'Centimeters or inches? [cm / inch]', c("cm","inch")),
    sliderInput('hM', 'Mother\'s height:',value = 160, min = 60, max = 220, step = 1),
    sliderInput('hF', 'Father\'s height:',value = 170, min = 60, max = 220, step = 1)
  ),
  mainPanel(
    div(strong("Based on your inputs, your child\'s adult height is:"), style = "color:black"),
    verbatimTextOutput("prediction"),
    plotOutput('newHist'),
    div(strong("About:"),"This app calcuates the child\'s height from the parent\'s height, where
        parent\'s height is calculated as the two parents weighted mean. 
        Calculation is based on linear prediction model based on the Galtons dataset."),
    p("\n"),
    div(strong("Extra information can be found here:"),"http://vedra.github.io/DDPSlidifyFull/index.html"),
    div(strong("Author:"),"Vedrana B.")
    )
))