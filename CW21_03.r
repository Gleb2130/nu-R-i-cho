install.packages("DT")
install.packages("ggplot2")
install.packages("plotly")
install.packages("crosstalk")
install.packages("carData")

library(DT)
library(plotly)
library(crosstalk)
library(carData)


un_data <- SharedData$new(carData::UN)
dt <- datatable(un_data, options = list(pageLength = 15, columnDefs = list(list(targets = '_all', className = 'dt-center'))))
dt <- dt %>% formatStyle(names(carData::UN), fontWeight = 'bold')

p_plotly <- plot_ly(data = un_data, x = ~fertility, y = ~lifeExpF, color = ~group, size = ~pctUrban, type = "scatter", mode = "markers")

filter_checkbox <- filter_checkbox("group", "Group", un_data, ~group)
filter_slider <- filter_slider("fertility", "fertility", un_data, ~fertility)
filter_select <- filter_select("region", "Region", un_data, ~region, multiple = TRUE)

bscols(p_plotly, filter_checkbox, filter_slider, filter_select, dt)
style(dt, height = '800px')
