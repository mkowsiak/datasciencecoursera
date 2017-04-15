add2 <- function(x,y) {
  x+y
}

above10 <- function(x) {
  use <- x > 10
  x[use]
}

above <- function(x, n = 10) {
  use <- x > n
  x[use]
}

columnmean <- function(x, removeNA = true) {
  nc <- ncol(x)
  means <- numeric(nc)
  for(i in 1:nc) {
    means[i] <- mean(x[i], na.rm = removeNA)
  }
  means
}

embedprint <- function() {
  fun <- function() {
    print("Hello")
  }
  fun()
}

y <- 10

f <- function(x) {
  y <- 2
  g(x)
}

g <- function(x) {
  y
}

