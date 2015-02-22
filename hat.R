rm(list = ls(all = TRUE))

library(knitr)
setwd("C:\\Users\\Lou\\Documents\\cowboyhat")

library(rgl)
library(evd)


df <- data.frame(x=numeric(),
                 y=numeric(), 
                 z=numeric(), 
                 stringsAsFactors=FALSE) 

cnti <- 0


for (i in seq(-5, 5 ,by=.25) )
  
{ 
    
    for (j in  seq(-5 , 5,by=.25))
    {
      cnti <- cnti +1      
      z <- 4 * (sin(sqrt(i*i+j*j)))
      
      df[cnti,1] <- i
      df[cnti,2] <- j
      df[cnti,3] <- z
    }
}


cr <- abs(df$z)/max(abs(df$z))
cg <- abs(df$x)/max(abs(df$x))
cb <- abs(df$y)/max(abs(df$y))


# clear scene:
clear3d("all")

# setup env:
bg3d(color="white")
light3d()


# draw shperes in an rgl window
spheres3d(df$x, df$y, df$z, radius=0.05, color=rgb(cr,cg,cb), zlim=range(df$z))

