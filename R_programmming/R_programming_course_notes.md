# Introduction

## R history

 - New Zealand
 - 1991: Ross Ihaka and Robert Gentleman.
 - 1995: GNU
 - 2013: R 3.0.2
  - R implementation/dialogue of S language as created (surprise) in bell labs 1976 by John Chambers.
 -  In 2004 insightful purchased S for $2mil. Several other iterations of purchases etc.
 - Fundamentals of S have not changed much since 1998
 - Basically a DSL for empowered users to do statistics
 - The base R system that you download from CRAN

## Console input and evaluation

``` R
 # comments
 # assignment
 x <- 1
 x
# notice by default it's a vector. Also vectors 1-based
x <- 1:20
x
# [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20

``` 

## Basic data types

Base types: character,  numeric,  integer, complex , logical (boolean)

Most basic object is a vector. All same atomic types.
A vector can only contain objects of the same class. Except for lists which is a vector that contain objects of different classes.

## Numbers

Numbers treated as "numeric" objects by default (double precision real numbers)

##  Inf for infinity, NaN for Not a number

R objects can have attributes

names, dimnames
dimensions (e.g. matrices, arrays)
class
length
other user-defined attributes/metadata

inspect with atttributes function

# Vectors and Lists

c() function to create vectors of objects ("concatenate")

``` R
x <- c(TRUE,FALSE)
x <- c(T,F)
x<-  c("a","b","c")
x<- 9:29
x <- vector("numeric", length=10)

``` 
## mixing

Mixing results in least common denominator, meaning the one that can be represented most generally

``` R
y <- c(1.7,"a")
[1] "1.7" "a"

``` 


## explicit coercion

resulting in NAS

# Matrices

constructed column-wise

``` R
> m <-matrix(nrow=1,ncol=1)
> m
     [,1]
[1,]   NA
> m <-matrix(nrow=1,ncol=3)
> m
     [,1] [,2] [,3]
[1,]   NA   NA   NA
> dim (m)
[1] 1 3
> attributes(m)
$dim
[1] 1 3


m <- matrix(1:6, nrow=2, ncol=3)

m <- 1:10
m
dim(m) <- c(2,5)
m

> m
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    3    5    7    9
[2,]    2    4    6    8   10

``` 

# cbind, rbind

``` R

x <- 1:10
y <- 11:20

``` 

cbind(x,y) #consider them columns in the resulting matrix
rbind(x,y)


# Factors
ordered (profs) or unordered categorical data (labels)
treated specially by modeling functions such as lm and glm

``` R
 


> x
[1] yes no  yes no  yes
Levels: no yes
> table(x)
x
 no yes 
  2   3 
> x<-factor(c("yes","no","yes"),c("yes"))
> x
[1] yes  <NA> yes 
Levels: yes
> x<-factor(c("yes","no","yes"),c("yes","no"),c("YES","nooope"))
> x
[1] YES    nooope YES   
Levels: YES nooope
> x<-factor(c("yes","no","yes"),c("yes","no"),c("Si","nooope"))
> x
[1] Si     nooope Si    
Levels: Si nooope
``` 
## unclass

``` R
 

 > unclass(x)
[1] 2 1 2 1 2
attr(,"levels")
[1] "no"  "yes"
```

## missing values

NaN and NA

every NaN missing and therefore an NA, converse not necessarily true.

``` R
 
x<-c(1,2,NA,NaN,3,1,NaN)

> x<-c(1,2,NA,NaN,3,1,NaN)
> is.a(x)
Error: could not find function "is.a"
> is.na(x)
[1] FALSE FALSE  TRUE  TRUE FALSE FALSE  TRUE
> is.nan(x)
[1] FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE


x <- c("a","b","c")
as.numeric(x)
 x <- c("a","b","c")
> as.numeric(x)
[1] NA NA NA
Warning message:
NAs introduced by coercion

``` 

## Data Frames

Used to store tabular data. Elements not all of the same type unlike matrices.

they have attribute row.names
read.table, read.csv, data.matrix

x<-data.frame(x = 1:4,y = c(T,F,T,F))
> x<-data.frame(x = 1:4,y = c(T,F,T,F))
> x
  x     y
1 1  TRUE
2 2 FALSE
3 3  TRUE
4 4 FALSE
> ncols(x)
Error: could not find function "ncols"
> ncol(x)
[1] 2

## Name attribute

lists and vectors can have them

x <- list(foo=1,bar=3)

## Reading Data

read.table, read.csv
readLines
source (inverse of dump)
dget (inverse of dput)
load (for reading in saved workspaces)
unserialize

### read.table

read everything on memory.
optimize by specifiying type of data. Easy trick: read first 100 lines and deduce classes from it, specify classes for the rest using deduced classes:

``` R
firstHondo <- read.table("datatable.txt",nrows=100)
classes <- sapply(firstHondo,class)
all <- read.table("datatable.txt",colClasses=classes)

``` 

rule of thumb according to video: guess  twice as much memory as the size of the object calculated colsxrowsx size of data cell.

Apply functions over array margins (columns or rows):

apply(X, MARGIN, FUN, ...)

similar is lapply which is a bit more typical, just apply function to list

## MARGIN	
a vector giving the subscripts which the function will be applied over. E.g., for a matrix 1 indicates rows, 2 indicates columns, c(1, 2) indicates rows and columns. Where X has named dimnames, it can be a character vector selecting dimension names.

This is why the question regarding means in a given table for a subset of the columns has an answer like

``` R
 apply(iris[, 1:4], 2, mean)

``` 

serialize and desirialize including metadata with dput and dget

``` R
 
> y <- data.frame(a=1,b="foo")
> dput(y)
structure(list(a = 1, b = structure(1L, .Label = "foo", class = "factor")), .Names = c("a", 
"b"), row.names = c(NA, -1L), class = "data.frame")
> dput(y,file="Y.R")

``` 


## Connection interfaces

Trivially simple functions to open files, urls, gzipped files.

# Subsetting

 [ ] single bracket always subsets and returns the same type.
 [[ ]] double bracket an element
 $ extract from data frame or list by name

### Extra: cheatsheet on subsetting matrices

``` R
m <- matrix(1:12,ncol=4)
colnames(m) <- c("A","B","C","D")
m
     A B C  D
[1,] 1 4 7 10
[2,] 2 5 8 11
[3,] 3 6 9 12

m[3,]
 A  B  C  D 
 3  6  9 12 

m[,3]
[1] 7 8 9

m[,"C"] %% 2 > 0
[1]  TRUE FALSE  TRUE

m[m[,"C"] %% 2 > 0,]
     A B C  D
[1,] 1 4 7 10
[2,] 3 6 9 12

``` 

### Subsetting as shown in the videos

using a condition for subsetting is referred to as "logical index" in the video:

``` R
> x <- c("a","b","c","d","e")
> x[x>"b"]
[1] "c" "d" "e"
> x[y>"b"]
[1] NA NA
Warning message:
In Ops.factor(left, right) : ‘>’ not meaningful for factors

``` 

## Subsetting lists

``` R
 


> x <- list(foo = 1:4, bar = 0.6, baz = "hello")
> name <- "foo"
> x[[name]] ## computed index for ‘foo’
[1] 1 2 3 4
> x$name ## element ‘name’ doesn’t exist!
NULL
> x$foo
[1] 1 2 3 4 ## element ‘foo’ does exist

x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x[[c(1, 3)]]
#[1] 14
 x[[1]][[3]]
#[1] 14
x[[c(2, 1)]]
#[1] 3.14
```

## Subsetting matrices

Similarly, subsetting a single column or a single row will give you a vector, not a matrix (by default).

``` R
 

> x <- matrix(1:6, 2, 3)
> x[1, ]
[1] 1 3 5
> x[1, , drop = FALSE]
 [,1] [,2] [,3]
[1,] 1 3 5
``` 

## Partial Matching

Partial matching of names is allowed with [[ and $.

``` R
 
> x <- list(aardvark = 1:5)
> x$a
[1] 1 2 3 4 5
> x[["a"]]
NULL
> x[["a", exact = FALSE]]
[1] 1 2 3 4 5

``` 

## Removing NA values

A common task is to remove missing values (NAs).

``` R
 > x <- c(1, 2, NA, 4, NA, 5)
> bad <- is.na(x)
> x[!bad]
[1] 1 2 4 5
``` 

## Removing NA Values , more cases

use complete.cases if you have to make the decision of completeness based on multiple vectors or multiple values in data frames

``` R
 
 x <- c(1, 2, NA, 4, NA, 5)
> y <- c("a", "b", NA, "d", NA, "f")
> good <- complete.cases(x, y)
> good
[1] TRUE TRUE FALSE TRUE FALSE TRUE
> x[good]
[1] 1 2 4 5
> y[good]
[1] "a" "b" "d" "f"

``` 

Also very important but not mentioned in slides: subsetting by condition on a row:

``` R
       one two three four
 [1,]   1   6    11   16
 [3,]   3   8    11   18
 [4,]   4   9    11   19
``` 

``` R
m[m[, "three"] == 11,] 
```

more examples of subsetting:

``` R
> airquality[1:6, ]
 Ozone Solar.R Wind Temp Month Day
1 41 190 7.4 67 5 1
2 36 118 8.0 72 5 2
3 12 149 12.6 74 5 3
4 18 313 11.5 62 5 4
5 NA NA 14.3 56 5 5
6 28 NA 14.9 66 5 6
> good <- complete.cases(airquality)
> airquality[good, ][1:6, ]
 Ozone Solar.R Wind Temp Month Day
1 41 190 7.4 67 5 1
2 36 118 8.0 72 5 2
3 12 149 12.6 74 5 3
4 18 313 11.5 62 5 4
7 23 299 8.6 65 5 7

``` 


## Vectorize operations

``` R
 
> x <- 1:4; y <- 6:9
> x + y
[1] 7 9 11 13
> x > 2
[1] FALSE FALSE TRUE TRUE
> x >= 2
[1] FALSE TRUE TRUE TRUE
> y == 8
[1] FALSE FALSE TRUE FALSE
> x * y
[1] 6 14 24 36
> x / y
[1] 0.1666667 0.2857143 0.3750000 0.4444444

``` 


## Vectorized Matrix operations

``` R
 
x <- matrix(1:4, 2, 2); y <- matrix(rep(10, 4), 2, 2)
x * y ## element-wise multiplication
# [,1] [,2]
#[1,] 10 30
#[2,] 20 40
x / y
# [,1] [,2]
#[1,] 0.1 0.3
#[2,] 0.2 0.4
x %*% y ## true matrix multiplication
# [,1] [,2]
#[1,] 40 40
#[2,] 60 60



> d <- matrix(c(3,3,4,4,-2,-2),3,2)
> d
     [,1] [,2]
[1,]    3    4
[2,]    3   -2
[3,]    4   -2
> e %*% d
     [,1] [,2]
[1,]   35  -20
[2,]   32   -2
> e <- matrix(c(0,5,3,5,5,2),3,2)
> e %*% d
Error in e %*% d : non-conformable arguments
> e <- matrix(c(0,5,3,5,5,2),2,3)
> e %*% d
     [,1] [,2]
[1,]   29  -16
[2,]   38    6
> e
     [,1] [,2] [,3]
[1,]    0    3    5
[2,]    5    5    2
> d
     [,1] [,2]
[1,]    3    4
[2,]    3   -2
[3,]    4   -2
> e %*% d
     [,1] [,2]
[1,]   29  -16
[2,]   38    6
```


Notice that R "fills out" the matrices using the data frame into the matrtx from "top to bottom, left to right"

# Control Structures

## Conditional

The typical, plus repeat for infinite loops and this syntactic sugar for assignments:

``` R
y <- if (x > 3) {
  10
}else{
0
}
```

## Loops

``` R
x <- c("a", "b", "c", "d")
for(i in 1:4) {
 print(x[i])
}
for(i in seq_along(x)) {
 print(x[i])
}
for(letter in x) {
 print(letter)
}
for(i in 1:4) print(x[i])
```

# Functions

See trivial_functions.R

Functions are first class objects . Can be passed as arguments, used anonymously, and declared inside other functions.

formal arguments can be inspected using the formals function.

Argument matching can be done by position of name:

``` R
# all equivalent:
 sd(mydata)
 sd(x = mydata)
 sd(x = mydata, na.rm = FALSE)
 sd(na.rm = FALSE, x = mydata)
 sd(na.rm = FALSE, mydata)
```

Parameter matching rules:
 1. Check for exact match for a named argument
 2. Check for a partial match
 3. Check for a positional match

Lazy evaluation, of course. Variable argument number with "...". Any arguments that appear after ... on the argument list must be named explicitly and cannot be partially matched 

## Scoping Rules

Given a name and no specific environment listed, R firsts looks on the global environment, if not found look for it in the order of environments as specified in the search list:

search()

``` R
search()
# [1] ".GlobalEnv"        "tools:rstudio"     "package:stats"     "package:graphics"  "package:grDevices" "package:utils"     "package:datasets" 
# [8] "package:methods"   "Autoloads"         "package:base"     
```

package.base always last.

When a user loads a package with library the namespace of that package is put in position 2.

### Lexical Scoping

``` R
foo <- function(x,y){
    x/y*z
    #where is Z taken from?
}
 

``` 
The values of free variables are searched for in the environment for which the function was defined.

an enviroment is a collection of symbol, value pares.
environments have parents (except for the empty environment)
function + environment = a closure or function closure

To figure out the environment of a free variable, R recursively looks, starting with the environment where a function was defined

``` R
environment(cube)
#<environment: 0x10c567a70>
#ls(environment(cube))
#[1] "n"   "pow"
get("n",environment(cube))
#[1] 3
```

Lexical scoping (R) looks for definition of free variables in the environment in which the function was defined. Dynamic scoping would do so in the environment it was called.

## Dates and times

POSIXct and POSIXlt for times. Dates as integers since the unix epoch.

basic comments about time date for non-programmers. Just do as.Date and as.POSIXct ?strptime.

### An example of how ugly and antiquated R can look

``` R
 h <- function(x, y = NULL, d = 3L) {
        z <- cbind(x, d)
        if(!is.null(y))
                z <- z + y
        else
                z <- z + f
        g <- x + y / z
        if(d == 3L)
                return(g)
        g <- g + 10
        g
}

```

## apply ( basic forward stl-like generics)

 the two most fundamental members of R's *apply family of functions: lapply() and sapply(). Both take a list as input, apply a function to each element of the list, then combine and return the result. lapply() always returns a list, whereas sapply() attempts to simplify the result.

- lapply(list,function,...)  apply to each. always returns a list. args may be coerced
 -  lists ~ associative arrays
 - sapply tries to simplify the result of lapply. e.g. if every element on the list only has one number, turn it into a vector.


``` R
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x
$a
 [,1] [,2]
[1,] 1 3
[2,] 2 4
$b
 [,1] [,2]
[1,] 1 4
[2,] 2 5
[3,] 3 6

lapply(x, function(elt) elt[,1])
$a
[1] 1 2
$b
[1] 1 2 3


> x <- matrix(rnorm(200), 20, 10)
> apply(x, 2, mean)
 [1] 0.04868268 0.35743615 -0.09104379
 [4] -0.05381370 -0.16552070 -0.18192493
 [7] 0.10285727 0.36519270 0.14898850
[10] 0.26767260
> apply(x, 1, sum)
 [1] -1.94843314 2.60601195 1.51772391
 [4] -2.80386816 3.73728682 -1.69371360
 [7] 0.02359932 3.91874808 -2.39902859
[10] 0.48685925 -1.77576824 -3.34016277
[13] 4.04101009 0.46515429 1.83687755
[16] 4.36744690 2.21993789 2.60983764
[19] -1.48607630 3.58709251


``` 
 - rowSums = apply(x, 1, sum)
 - rowMeans = apply(x, 1, mean)
 - colSums = apply(x, 2, sum)
 - colMeans = apply(x, 2, mean)

## mapply, tapply

a way to apply a funcition to multiple sets of arguments. multivariate apply

can be used to roughly vectorize a function.

tapply similar but used to apply to groups

common idiom to do lapply in combination with split. This is sometimes termed as The Split-Apply-Combine Strategy for Data Analysis'

``` R
> lapply(split(x, f), mean)
$‘1‘
[1] 0.1144464
$‘2‘
[1] 0.5163468
$‘3‘
[1] 1.246368 

```

## Splitting on more than one level

``` R
 > x <- rnorm(10)
> f1 <- gl(2, 5)
> f2 <- gl(5, 2)
> f1
 [1] 1 1 1 1 1 2 2 2 2 2
Levels: 1 2
> f2
 [1] 1 1 2 2 3 3 4 4 5 5
Levels: 1 2 3 4 5
> interaction(f1, f2)
 [1] 1.1 1.1 1.2 1.2 1.3 2.3 2.4 2.4 2.5 2.5
10 Levels: 1.1 2.1 1.2 2.2 1.3 2.3 1.4 ... 2.5

```

## Debugging

 - traceback
 - debug
 - trace
 - browser
 - recover

error messages produced by the stop() function. Conditions and Warnings by the obvious.

## Swirl (exercise package)

vapply() as a safer alternative to sapply(), specifies expected type of return.
tapply() to split your data into groups based on the value of some variable, then apply a function to each group.

# Simulation and Profiling

## str function

Display structure of the function or object passed (really string). Simply a quick way to inspect similar to a toString() in other languages.

## Generating Random Numbers

 - rnorm: generate random Normal variables with a given mean and std deviation
 - dnorm: evaluate the normal probabilty distribution at a point
  - pnorm: evaluate the cumulative distribution function for a normal dist
  - rpois: generate a random poisson variables with a given rate

probablility distributions usually have four flavors associated with them: d for density, r for random number generation, p for cumulative distribution, q for quantile function

``` R
 > set.seed(20)
> x <- rnorm(20000)
> summary(x)
     Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
-3.819000 -0.676800  0.006453  0.002063  0.683100  3.714000
```

## Generating Randoms from a linear model

What about generating random not from a typical distribution but a linear model?

Suppose y = Bo + B1*x + e

where e ~ N(0.2^2). Assume x ~ N(0.1^2), Bo = 0.5 and B1 = 2

``` R
 set.seed(20)
 x <- rnorm(100)
 e <- rnorm(100,0,2)
 y <- 0.5 + 2 * x + e
 summary(y)
 plot(x,y)

``` 

Generating random numbers from a linear model with binary x:

``` R
 set.seed(20)
 x <- rbinom(100,1,0.5)
 e <- rnorm(100,0,2)
 y <- 0.5 + 2 * x + e
 summary(y)
 plot(x,y)
```

An example with a non-linear error:

``` R
 set.seed(20)
 x <- rnorm(100)
 log.mu <- 0.5 +0.3 * x
 y <- rpois(100,exp(log.mu))
 summary(y)
 plot(x,y)
```

## Random Sampling

sample takes a sample of the specified size from the elements of x using either with or without replacement.

sample(x, size, replace = FALSE, prob = NULL)

# R Profiling

## System.time

 - system.time()

``` R
system.time(readLines("http://www.jhsph.edu"))
 user system elapsed
 0.004 0.002 0.431
```

Normally elapsed (perceived)  >= user (cpu usage)

elapsed can be smaller than user in multi-core. R isn't multi-core enabled but linear algebra and other libraries it links to are.

## R Profiler

 - Rprof() function starts to profiler.
 - summaryRprof() summarizes results in readable format

Rprof keeps track of the function call stack at regularly sampled intervals and tabulates how much time is spent on each functions. Default sampling interval is 0.02.

normalizing the data:
 - by.total
  -by.self (divides the time spent in each function by the total run time but first substracts out time spent in functions above in the call stack). More often useful according to video to identify bottlenecks.


https://www.coursera.org/account/accomplishments/certificate/KMKCVBW4PSYS