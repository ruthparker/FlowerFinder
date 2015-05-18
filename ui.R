library(shiny)

fluidPage(
    
    titlePanel("  Identify your Iris!"),
    
    sidebarLayout(
        
        sidebarPanel(
            helpText('Move the sliders to your flower\'s measurements, then press GO:'),
            sliderInput('plength','Petal Length',min=1,max=7,value=3.8,step=0.1,round=-1),
            sliderInput('pwidth','Petal Width',min=0.1,max=3,value=1.2,step=0.1,round=-1),
            sliderInput('slength','Sepal Length',min=4,max=8,value=5.8,step=0.1,round=-1),
            sliderInput('swidth','Sepal Width',min=2,max=4,value=3,step=0.1,round=-1),
            helpText('(all measurements are in centimetres)'),
            submitButton('GO')
        ),
    
        mainPanel(
            tabsetPanel(id="pid",
                tabPanel('Results',
                    br(),
                    h5(textOutput('oPetal'),align='center'),
                    br(),
                    br(),
                    h5('We predict your iris is...',align='center'),
                    br(),
                    h4(strong(textOutput('oRes')),align='center'),
                    br(),
                    imageOutput('oPic')
                ),
                tabPanel('Documentation',
                    br(),
                    p('This application uses the ', strong('Iris data set '),  
                      'introduced by Sir Ronald Fisher in 1936 to demonstrate ',
                      'discriminant analysis by quantifying morphological ',
                      'variation in three related species. The data set contains ',
                      'petal and sepal measurements of 50 speciments each of Iris ',
                      'setosa, virginica, and versicolor, and is often used as a ',
                      'test case for machine learning classification techniques. ',
                      'Images are courtesy of Wikimedia Commons.'),
                    br(),
                    p('We fitted an rpart model to 75% of the data set, and used ',
                      'this model to make a prediction against the remaining 25%. ',
                      'Examination of our confusion matrix indicates 97% accuracy, ',
                      'giving us a 3% error rate with a confidence interval of 95%. ',
                      'The prediction is graphically illustrated below:'),
                    plotOutput('oPlot')

                )
            )
        )
    )
)