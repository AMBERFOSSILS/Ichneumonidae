#START: 16.03.2020 00:06 (modified on 17.03.2020 01:39)

# in order to use the date that was created on tpsDig2, we need to download the
# open-source package "geomorph" from the CRAN-repository.

 WASPDATA1 <- readland.tps("DATA_GELINAE.TPS", specID = "ID", readcurves = TRUE)
species <- as.factor(substr(dimnames(WASPDATA1)[[3]],1,6))

#in order to create a list of our covariants we first need a list of all images that are used in the data
library(xlsx)
write.xlsx(as.factor(dimnames(WASPDATA1)[[3]]), file = "covariants_test.xlsx")
#then we simply apply our excel template with the formulas on the document and it will calculate all features (modified! 17.03.2020 18.22)


# After this, we import the data as a table and inspect wether it was imported correctly

 library(readxl)
 covariants <- read_excel("Classifiers_CurveDataSet.xlsx", col_types = c("text","text", "text", "text"))
 View(covariants)

# A list of factors have to be created for all classifiers that want to be analyzed

 Tribe <- as.factor(covariants$TRIBE)
 Subtribe <- as.factor(covariants$Subtribe)
 Aerolet <- as.factor(covariants$AREOLET)

#Then we create the model(progressive analysis) that will be used for further analysis which
# creates a fitted overlay of our landmark coordinates
 Gelinae <- gpagen(WASPDATA1)

#if we first plot WASPDATA1 itself we will get a noisy figure of our coordinates

plot(WASPDATA1)

#Then we plot the Gelinae Model which gives us a representation of the fitted model
 plot(Gelinae)
#looking at it we can see that point 1,2,4,5,6 are highly variable, as well as the RS
#and 2m-cu curve. while 1m-cu&M doesnt really show high variability.

# Now we create our first Principal Component analysis
 PCA <- gm.prcomp(Gelinae$coords)

# Which can be visualised by its classifiers with:
 plot(PCA$x[,1],PCA$x[,2], col= Tribe, pch= 16)

# The figure shows clear differences from Gelini to Echthrini and Mesostenini (
# although there is an outlier (Grasseiteles from Endaseina), which probably even doesnt belong to Gelinae or was
# not correctly created
 
 legend(-0.62 , 0.2, unique(Tribe), col= 1:length(Tribe), pch=16)
 
#END: 16.03.2021 02:24

