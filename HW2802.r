data(iris)

dat <- iris 

dat[, "dĺžka"] <- dat[, "Sepal.Length"]
dat[, "šírka"] <- dat[, "Sepal.Width"]
dat <- dat[, !(names(dat) %in% c("Sepal.Length", "Sepal.Width"))]
str(dat)

summary(dat)

hist(dat$šírka, main = "Rozdelenie šírky kališných lístkov", xlab = "šírka", col = "skyblue")

hist(dat$dĺžka, main = "Rozdelenie dĺžky kališných lístkov", xlab = "dĺžka", col = "lightgreen")

means <- aggregate(. ~ Species, data = dat[, c("šírka", "dĺžka", "Species")], FUN = mean)
means


boxplot(šírka ~ Species, data = dat, main = "Rozdelenie šírky podľa druhov", xlab = "Typy", ylab = "šírka", col = c("skyblue", "lightgreen", "lightcoral"))

boxplot(dĺžka ~ Species, data = dat, main = "Rozdelenie dĺžky podľa druhov", xlab = "Typy", ylab = "dĺžka", col = c("skyblue", "lightgreen", "lightcoral"))

plot(dat$dĺžka, dat$dĺžka, main = "Vzťah medzi šírkou a dĺžkou kališného lístka", xlab = "šírka", ylab = "dĺžka", col = "blue")



plot(dĺžka ~ šírka, data = dat, col = as.numeric(dat$Species), pch = as.numeric(dat$Species), main = "Vzťah medzi šírkou a dĺžkou kališného lístka podľa druhu", xlab = "šírka", ylab = "dĺžka")
legend("topright", legend = levels(dat$Species), col = 1:length(levels(dat$Species)), pch = 1:length(levels(dat$Species)))


