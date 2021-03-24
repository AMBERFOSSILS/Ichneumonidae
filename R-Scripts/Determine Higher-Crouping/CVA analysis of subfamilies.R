library(Morpho)
setwd("~/GitHub/Ichneumonidae/R-Scripts/Determine Higher-Crouping")
landmark = readland.tps("blockcourse_highersub.tps",specID = "ID", readcurves = T, warnmsg = TRUE)

##      define classifiers (subfam or tribes)
species = as.factor( substr( dimnames(landmark)[[3]], 1, 6))
subfam = as.factor( substr( dimnames(landmark)[[3]], 8, 13))
areolet = as.factor( substr( dimnames(landmark)[[3]], 15, 15))
tribe = as.factor( substr( dimnames(landmark)[[3]], 17, 19))


##      define Semilandmarks, first LM is the start, last one the end (those are both
##      fixed landmarks, in between are the semilandmarks):
sliders = define.sliders(c(15,22:29,16))

##      procrustes fit - "superimposition" - rotates and scales the landmarks to their closest distance,
##      minimizing the shape and size difference:
proD<-gpagen(landmark, surfaces = NULL, curves= sliders,
             PrinAxes = FALSE, max.iter = NULL, ProcD = F, Proj = TRUE,
             print.progress = TRUE)
use= c("pimpli", "banchi", "gelina", "ophion", "ichneu")
reduced<- proD$coords[,,subfam%in% use]
pro_red<-gpagen(reduced, surfaces = NULL, curves= sliders,
                PrinAxes = FALSE, max.iter = NULL, ProcD = F, Proj = TRUE,
                print.progress = TRUE)
subfam1<-as.factor(substr(dimnames(pro_red$coords)[[3]],8,13))
```
#CVA
cva<- CVA(pro_red$coords, groups = subfam1, plot= T)

# plot the CVA
plot(cva$CVscores, col=subfam1, pch=as.numeric(subfam1), typ="n",asp=1,
     xlab=paste("1st canonical axis", paste(round(cva$Var[1,2],1),"%")),
     ylab=paste("2nd canonical axis", paste(round(cva$Var[2,2],1),"%")))
text(cva$CVscores, as.character(subfam1), col=as.numeric(subfam1), cex=.7)

