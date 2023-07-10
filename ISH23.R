setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(BoolNet)


cc <- loadNetwork("reduced_cellcycle") # same as cell cycle net from 
                                       # Faure et. al 2006, but
                                       # update rules in DNF
# "knock out" p27
kocel <- fixGenes(cc, 6, 0)

att <- getAttractors(cc) #attractors of "wild type"
pla_wi <- plotAttractors(att) 


koat <- getAttractors(kocel) # attractors of "knockout"
pla_ko <- plotAttractors(koat)
# both wild-type and knockout exhibit one single-state, one cyclic attr, good 

initstate <- c(c(1,1), rep(0,8)) # arbitrary start state for illustrating
                                 # a path to attractor

atpath <- getPathToAttractor(cc, initstate)
atpath
plotSequence(sequence = atpath) # this for slides 

# looks the same for knockout net
atpath_ko <- getPathToAttractor(kocel,initstate)
atpath_ko

identical(atpath, atpath_ko)

plotSequence(sequence = atpath_ko) # this for slides 

# look more closely, for no reason

identical(pla_ko[[1]], pla_wi[[1]]) # static attractor not identical

#only thing that differs is p27 -- cannot be present in knockout (because set to 0)
attributes(pla_wi[[1]])$dimnames[[1]][which(pla_ko[[1]] != pla_wi[[1]])]

# cycle is identical
identical(pla_ko[[2]], pla_wi[[2]]) 

