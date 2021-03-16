START: 16.03.2020 00:06

# in order to use the date that was created on tpsDig2, we need to download the
# open-source package "geomorph" from the CRAN-repository.

 WASPDATA1 <- readland.tps("GELINAE.TPS", specID = "ID", readcurves = TRUE)

# then a list of all specimens in WASPDATA1 is created from the pictures that
# were used to build the tps file

 write.xlsx(list.files(getwd()), file = "covariants_test.xlsx")

# To this list we can then upend classifiers such as tribe, aerolet and subtribe

# After this, we import the data as a table and inspect wether it was imported correctly

 library(readxl)
 covariants <- read_excel("NewName.xlsx", col_types = c("text","text", "text", "text"))
 View(covariants)

# A list of factors have to be created for all classifiers that want to be analyzed

 Tribe <- as.factor(covariants$TRIBE)
 Subtribe <- as.factor(covariants$SUBTRIBE)
 Aerolet <- as.factor(covariants$AEOROLET)

#Then we create the model(progressive analysis) that will be used for further analysis
 Gelinae <- gpagen(WASPDATA1)

#if we first plot WASPDATA1 itself we will get a noisy figure that seems to be slightly
# biased, which hopefully will show that Echthrini and Gelini have different positions

plot(WASPDATA1)

#Then we plot the Gelinae Model which gives us a representation of the fitted model
 plot(Gelinae)
#looking at it we can see that point 1,2,4,5,6 are highly variable, as well as the RS
#and 2m-cu curve. while 1m-cu&M doesnt really show high variability.

# Now we create our first Principal Component analysis
 PCA <- gm.prcomp(Gelinae$coords)

# Which can be visualised by its classifiers with:
 plot(PCA, col= Trib, pch= 16)))

# The figure that appears seems not to be very satisfying, since the whole picture is very noisy
# but there is some kind of tendancy of Echthrini towards the Equator and Gilini to be 
# vertically alined.

#END: 16.03.2021 02:24


