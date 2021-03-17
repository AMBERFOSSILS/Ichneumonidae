#START: 16.03.2020 00:06 (modified on 17.03.2020 01:39)

# in order to use the date that was created on tpsDig2, we need to download the
# open-source package "geomorph" from the CRAN-repository.

 WASPDATA1 <- readland.tps("DATA_GELINAE.TPS", specID = "ID", readcurves = TRUE)

# In order to get all Images as a list as they are ordered in the TPS File:
# 1.Create a .txt file and copy all information from the tps file inside
# 2.read the file with read.table
 NewName <- read.table("Species.txt", sep= '\n')
# 3.only get Lines containing our Name
 NewName<- NewName[grepl("ID=",NewName$V1)==TRUE,]
# 4. get rid of backslashes
 NewName <-gsub("\\", "", NewName, fixed = TRUE)
# 5. plot the Names
 NewName
# 6. copy the path in front of our actual Data and delete it from the name
 NewName <- gsub("ID=C:UsersRobinDropboxMein PC (Gemeinsamer-PC)DocumentsGitHubIchneumonidaeR-Scripts", "", NewName, fixed = TRUE)
# 7. write an excel file with all names in it.
 write.xlsx(NewName, file = "covariants_test.xlsx")
# 8. copy the names into the template to create a covariant List.
 


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
 plot(PCA, col= Tribe, pch= 16)

# The figure shows clear differences from Gelini to Echthrini and Mesostenini (
# although there is an outlier (Grasseiteles from Endaseina), which probably even doesnt belong to Gelinae or was
# not correctly created
 
 legend(-0.62 , 0.2, unique(Tribe), col= 1:length(Tribe), pch=16)
 
#END: 16.03.2021 02:24


