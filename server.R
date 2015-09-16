library(RPostgreSQL)
library(dplyr)
library(ggplot2)
library(shiny)
library(tidyr)

con <- src_postgres(dbname = "sheds", host = "ecosheds.org", port = "5432",
                    user = getOption("SHEDS_USERNAME"),
                    password = getOption("SHEDS_PASSWORD"))
tbl_cov <- tbl(con, "covariates")

shinyServer(function(input, output) {
  output$message <- renderText({
    message = ""
    featureid <- as.integer(input$featureid)
    if (nchar(input$featureid) == 0) {
      message <- "Enter a featureid and click Go"
    } else if (is.na(featureid)) {
      message <- "Invalid featureid"
    }
    message
  })
  output$covariates <- renderDataTable({
    if (!is.na(as.integer(input$featureid))) {
      covariates <- filter(tbl_cov, featureid == input$featureid) %>%
        collect
      covariates <- covariates %>%
        spread(zone, value) %>%
        rename(local_value=local, upstream_value=upstream)
    } else {
      covariates <- data.frame()
    }
    covariates
  })
})