library(shiny)
library(datasets)
library(e1071)
library(caret)
library(rpart.plot)
library(rattle)

data(iris)

# create an rpart model & prediction that we can test our measurements against
inTrain=createDataPartition(iris$Species,p=3/4)[[1]]
training=iris[inTrain,]
testing=iris[-inTrain,]
modrp<-train(Species~.,method="rpart",data=training)
predrp<-predict(modrp,testing)
# interrogation of the confusion matrix gives us 97% accuracy with a 95% CI

# set up the dataframe for the prediction
df<-data.frame(Sepal.Length=NA,Sepal.Width=NA,Petal.Length=NA,Petal.Width=NA)

function(input, output) {
    
    res <- reactive({
        df[1,]<-c(input$slength,input$swidth,input$plength,input$pwidth)
        as.character(predict(modrp,df))[1]
    })
    
    output$oPetal<-renderText({
        paste('Your measurements are petals',input$plength,'x',input$pwidth,
              'cm, and sepals',input$slength,'x',input$swidth,'cm.')
    })
        
    output$oRes<-renderText({paste('Iris',{res()}) })

    output$oPic<-renderImage({
        list(src=paste0('www/Iris_',{res()},'.jpg'),width=400,height=300)
    },deleteFile=FALSE)
    
    output$oPlot<-renderPlot({fancyRpartPlot(modrp$finalModel,sub="")},height=300)

}