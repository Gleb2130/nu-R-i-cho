install.packages("dplyr")
install.packages("ggplot2")
install.packages("patchwork")

library(dplyr)
library(ggplot2)
library(patchwork)

# Úloha 1: Načítanie údajov a premenovanie stĺpcov
dat <- datasets::iris %>%
    rename(šírka = Sepal.Width, dĺžka = Sepal.Length)



# Úloha 2: Histogramy rozdelenia pravdepodobnosti
p1 <- ggplot(dat, aes(x = šírka)) + geom_histogram(bins = 30) + ggtitle("Rozdelenie šírky") # počet stĺpcov 30
p2 <- ggplot(dat, aes(x = dĺžka)) + geom_histogram(bins = 30) + ggtitle("Rozdelenie dĺžky") # počet stĺpcov 30

(p1 | p2) + plot_layout()

# Úloha 3: Zmena priemerných hodnôt podľa druhov
group_dat <- dat %>%
  group_by(Species)

p4<-ggplot(group_dat,aes(x=Species,y= šírka,fill=Species))+geom_bar(stat = "summary", fun = "mean") + ggtitle("priemerná šírka podľa druhu")
p4<-ggplot(group_dat,aes(x=Species,y= dĺžka,fill=Species))+geom_bar(stat = "summary", fun = "mean") + ggtitle("priemerná dĺžka podľa druhu")

(p3 | p4)

# Úloha 4: Vzťah medzi šírkou a dĺžkou
p5 <- ggplot(dat, aes(x = šírka, y = dĺžka)) + geom_point() + ggtitle("Vzťah medzi šírkou a dĺžkou")

p5

# Úloha 5: Vzťah medzi šírkou a dĺžkou podľa relácií
p6 <- ggplot(dat, aes(x = šírka, y = dĺžka, color = Species)) + geom_point() + ggtitle("Vzťah medzi šírkou a dĺžkou podľa druhu") + theme(legend.position = "bottom") #vycentrovať symboly na grafe   
p6


# všetky grafy
wrap_plots(p1, p2, p3,p4,p5,p6,ncol=2)