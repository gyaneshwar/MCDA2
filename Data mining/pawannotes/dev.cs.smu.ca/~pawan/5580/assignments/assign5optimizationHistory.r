#install.packages("genalg")
library(genalg)
library(ggplot2)
dataset <- data.frame(item = c("pocketknife", "beans", "potatoes", "unions", 
    "sleeping bag", "rope", "compass"), survivalpoints = c(10, 20, 15, 2, 30, 
    10, 30), weight = c(1, 5, 10, 1, 7, 5, 1))
weightlimit <- 20
dataset
chromosome = c(1, 0, 0, 1, 1, 0, 0)
dataset[chromosome == 1, ]
evalFunc <- function(x) {
    current_solution_survivalpoints <- x %*% dataset$survivalpoints
    current_solution_weight <- x %*% dataset$weight
    if (current_solution_weight > weightlimit) 
        return(0) else return(-current_solution_survivalpoints)
}
iter = 100
GAmodel <- rbga.bin(size = 7, popSize = 200, iters = iter, mutationChance = 0.01,  elitism = T, evalFunc = evalFunc)
plot(GAmodel)
plot(GAmodel,type="hist")
bestSolution<-GAmodel$population[which.min(GAmodel$evaluations),]
bestSolution
