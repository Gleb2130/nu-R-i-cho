#! 1
library(datasets)
dat <- datasets::mtcars
#! 2
str(dat)
head(dat,n=5)

#! 3
dat$kml <- dat$mpg * 0.425144 
#! 4
mean(dat$kml[dat$am == 1])
mean(dat$kml[dat$am == 0])

#! 5
subset(dat, gear == 5 & wt < 3)

#! 6
convert_units <- function(x, impunit, toSI) {
    switch(impunit,
        mile = {
             temp <- 1.60934
         },
         gallon = {
             temp <- 3.78541
         },
         inch = {
             temp <- 2.54
         },
         pound = {
             temp <- 0.453592
         },
         stop("ERROR")
    )
    if (toSI){
        return(x * temp)
    }
    else{
        return(x / temp)
    }
}
#! 7
# dat$disp <- sapply(dat$disp, convert_units, impunit = "inch", toSI = TRUE) 

#||

for (identifier in seq_along(dat$disp)) {
  dat$disp[identifier] <- convert_units(dat$disp[identifier], impunit = "inch", toSI = TRUE)
}
dat$disp


#dat$wt <- sapply(dat$wt, convert_units, impunit = "pound", toSI = TRUE) 

#||

for (identifier in seq_along(dat$wt)) {
   dat$wt[identifier] <- convert_units(dat$wt[identifier],impunit = "pound", toSI = TRUE)
}
dat$wt

#! 8
# setwd("") #TODO vložte cestu k pracovnému adresáru 
# dat_from_file <- read.table("mtcars.txt", header = TRUE, sep = "\t", dec = ".", na.strings = "NA")
# identical(dat, dat_from_file)


