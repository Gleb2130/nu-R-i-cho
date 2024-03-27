install.packages("ggplot2")
install.packages("tidyr")
install.packages("readxl")
install.packages("tidyverse")


library(ggplot2) 
library(tidyr)
library(readxl)
library(tidyverse)


dat <- data.frame(deň = c("Po", "Ut", "St", "Št", "Pi"), 
           meranie = c(23, 20, 18, 26, 20),
           predpoveď = c(20, 18, 16, 23, 21)
           )


clean_dat <- dat%>%
    pivot_longer(cols = c(meranie, predpoveď),
                names_to = "Type",
                values_to = "Temperature")
clean_dat
p1<- ggplot(clean_dat, aes(x = deň,y=Temperature,color=Type))+geom_point()
p1


iris_data <- read_excel("Rk/iris.xlsx")

iris_data <- iris_data %>% select(-contains("NA"))


names(iris_data) <- c("Species", "Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")


iris_clean <- iris_data %>%
  pivot_longer(cols = -Species,
               names_to = "Measurement",
               values_to = "value") %>%
  mutate(value = as.numeric(value))


  
ggplot(iris_clean, aes(x = value, y = Species, color = Species, shape = Measurement)) +
  geom_point(size = 3) +
  labs(x = "Význam", y = "Zobrazenie Iris", color = "Zobrazenie dúhovky ", shape = "Meranie")



