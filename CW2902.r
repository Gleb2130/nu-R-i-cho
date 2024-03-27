library(carData)
library(dplyr)


data(UN)

UN <- UN %>%
  rename(
    Країна = region,
    Група = group,
    'народжуваність дітей' = fertility,
    Продуктивність_робітника = ppgdp,
    Урбанізація = lifeExpF,
    Місто = pctUrban,
    'дитяча смертність' = infantMortality
  )

UN <- UN %>%
  filter(Країна == "Europe")

UN <- UN %>%
  mutate(Група = if_else(Група %in% c("OECD", "EU"), "OECD", "other"))

UN <- UN %>%
  mutate(Пропорція_урбанізації = Урбанізація / 100)

grouped_UN <- UN %>%
  group_by(Група) %>%
  summarise(across(where(is.numeric), mean))

print(grouped_UN)

mean_values <- UN %>%
  summarise(across(where(is.numeric) & !contains(names(.), "Урбанізація", ignore.case = FALSE), mean))


print(mean_values)

sorted_UN <- UN %>%
  arrange(Урбанізація)

print(sorted_UN)

