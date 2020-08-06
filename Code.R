#This code is made to generate a virtual field (VF) using Gaussian Simulation

#####################Generation of VF###################################

#We will start by VF generetion

rm(list=ls())
gc(reset = TRUE)

#We will use the following packages for this first part
library(pacman)
pacman::p_load(gstat, sp)

#We will first generate x and y 

x <- seq(1, 2000, by = 1)
y <- seq(1, 1000, by = 1)
area <- expand.grid(x = x, y = y)

#Unconditional Gaussian Simulation

#We firt define a model of semivariogram and its parameters
set.seed(43)
model <- gstat(formula=z ~ 1, 
               locations = ~ x+y,
               dummy=T,#Inconditional simulation term 
               beta=c(1.6746398,0.0016447,0.0003655), 
               model=vgm(nugget =0, psill= 0.2833884,
                         range= 391.5041, model='Sph'),  
               nmin = 4, #min number of nearest observations
               nmax=32,
               weights = T,#max nummber of nearest observations
               data = area)

#Now we perform the Simulation
t0 = Sys.time()
t1 = Sys.time()
set.seed(1993)
#number of simulations that will be done is seted in this part of the code
#simulation uses the model made in the previous step
vf <- predict(model, newdata=area, nsim= 10)
t2 = Sys.time()
print (t2-t1)