add_two_numbers <- function(a,b){
  # no return statement, just value of last expression
  a + b
}

filter_greater_than <- function(vector,threshold = 10){
  # booleans
  use <- vector > threshold  
  vector[use]
}

column_mean <- function(m, removeNA=TRUE){
  cols <- ncol(m)
  result <- numeric(cols)
  for(i in 1:cols){
    result[i] <- mean(m[,i], na.rm = removeNA)
  }
  result
}

make.power <- function(n){
  pow <- function(m){
    n ^ m
  }
  pow
}
