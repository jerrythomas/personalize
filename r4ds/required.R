#create a function to check for installed packages and install them if they are not installed
install <- function(packages){
  new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
  if (length(new.packages))
    install.packages(new.packages, dependencies = TRUE)
  sapply(packages, require, character.only = TRUE)
}

# usage

#required.packages <- c("ggplot2", "dplyr", "reshape2", "devtools", "shiny", "shinydashboard", "caret","randomForest","gbm","tm","forecast","knitr","Rcpp","stringr","lubridate","manipulate","Scale","sqldf","RMongo","foreign","googleVis","XML","roxygen2","plotly","parallel","car")

required.packages <- c("devtools", "packrat")
chooseCRANmirror(graphics=FALSE, ind = 1)
install(required.packages)

update.packages(ask = FALSE, checkBuilt = TRUE)

broken = names(which(
  sapply(.packages(TRUE), function(i) {
    system2('Rscript', c('-e', shQuote(sprintf('library(%s)', i))))
  }) != 0
))

if (length(broken)) install.packages(broken)

