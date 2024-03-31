# Načítanie potrebných knižníc
library(ggplot2)
library(dplyr)
library(car)

# 1. Odhad strednej hodnoty dojazdu automobilov
mean_mpg_mtcars <- mean(mtcars$mpg)
print(paste("Stredná hodnota dojazdu automobilov:", mean_mpg_mtcars))

# 2. Odhad strednej hodnoty dojazdu v závislosti od zdvihového objemu valcov (lineárny regresný model)
mpg_model_mtcars <- lm(mpg ~ disp, data = mtcars)

# Vizualizácia modelu
ggplot(mtcars, aes(x = disp, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Zdvihový objem valcov", y = "Dojazd (MPG)")

# 3. Rozšírenie modelu o počet valcov
mpg_model_with_cylinders_mtcars <- lm(mpg ~ disp + cyl, data = mtcars)

# Vizualizácia modelu s počtom valcov
ggplot(mtcars, aes(x = disp, y = mpg, color = factor(cyl))) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Zdvihový objem valcov", y = "Dojazd (MPG)", color = "Počet valcov")

# 4. Interakcia medzi objemom valcov a počtom valcov
mpg_model_interaction_mtcars <- lm(mpg ~ disp * cyl, data = mtcars)

# Vizualizácia interakcie
ggplot(mtcars, aes(x = disp, y = mpg, color = factor(cyl))) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, aes(group = cyl)) +
  labs(x = "Zdvihový objem valcov", y = "Dojazd (MPG)", color = "Počet valcov")

# 5. Priemerný dojazd štvorvalcového automobilu podľa posledného modelu
mtcars$predicted_mpg <- predict(mpg_model_interaction_mtcars, mtcars)
max_mpg_car_mtcars <- mtcars[which.max(mtcars$predicted_mpg), ]
print(paste("Priemer dojazdu štvorvalcového automobilu:", mean(max_mpg_car_mtcars$mpg)))

# 6. Zmena odpovede pri použití komplexnejšieho súboru údajov (auto-mpg.data)
auto_mpg_full <- read.table("./auto/auto-mpg.data", header = FALSE, sep = "", na.strings = "?")
colnames(auto_mpg_full) <- c("mpg", "cylinders", "displacement", "horsepower", "weight", "acceleration", "model_year", "origin", "car_name")
mpg_model_interaction_full <- lm(mpg ~ displacement * cylinders, data = auto_mpg_full)
auto_mpg_full$predicted_mpg <- predict(mpg_model_interaction_full, auto_mpg_full)
max_mpg_car_full <- auto_mpg_full[which.max(auto_mpg_full$predicted_mpg), ]
print(paste("Priemer dojazdu štvorvalcového automobilu (komplexný dataset):", mean(max_mpg_car_full$mpg)))

# 7. Porovnanie modelov podľa RMSE
rmse_values <- c(
  sqrt(mean((auto_mpg$mpg - predict(mpg_model, auto_mpg))^2)),
  sqrt(mean((auto_mpg$mpg - predict(mpg_model_with_cylinders, auto_mpg))^2)),
  sqrt(mean((auto_mpg$mpg - predict(mpg_model_interaction, auto_mpg))^2)),
  sqrt(mean((auto_mpg_full$mpg - predict(mpg_model_interaction_full, auto_mpg_full))^2))
)

# Poradie modelov podľa RMSE
ranked_models <- c("Model 1", "Model 2", "Model 3", "Model 4")
names(rmse_values) <- ranked_models
print(rmse_values)

# Predikcia priemerneho dojazdu štvorvalcového automobilu so zdvihovým objemom 160 kubických palcov
predicted_mpg <- predict(mpg_model_interaction_full, data.frame(displacement = 160, cylinders = 4))
print(paste("Predikovaný dojazd štvorvalcového automobilu so zdvihovým objemom 160 kubických palcov:", predicted_mpg))

# 8. Model závislosti dojazdu iba od zdvihového objemu s vhodnou transformáciou
mpg_model_displacement_only <- lm(mpg ~ log(displacement), data = auto_mpg)

# Vizualizácia modelu
ggplot(auto_mpg, aes(x = displacement, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ log(x), se = FALSE) +
  labs(x = "Zdvihový objem valcov", y = "Dojazd (MPG)")
