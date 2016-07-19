# Notes

 - R implementation/dialogue of S language as created (surprise) in bell labs 1976 by John Chambers.
 -  In 2004 insightful purchased S for $2mil. Several other iterations of purchases etc.
 - Fundamentals of S have not changed much since 1998
 - Typical old school programming environment for empowered users to


## R

 -
 - 1991: Ross Ihaka and Robert Gentleman.
 - 1995: GNU
 - 2013: R 3.0.2

# Design of R

 - The base R system that you download from CRAN

# Console input and evaluation

> # comments
> # assignment
> x <- 1
> x
[1] 1
> # notice by default it's a vector. Also vectors 1-based
> x <- 1:20
> x
 [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20

# Basic data types

Base types:

> # character
> # numeric
> # integer
> # complex 
> # logical (boolean)

Most basic object is a vector. All same atomic types.
A vector can only contain objects of the same class. Except for lists which is a vector that contain objects of different classes.

## Numbers

Numbers treated as "numeric" objects by default (double precision real numbers)

#  Inf for infinity, NaN for Not a number

R objects can have attributes

names, dimnames
dimensions (e.g. matrices, arrays)
class
length
other user-defined attributes/metadata

inspect with atttributes function

# Vectors and Lists

c() function to create vectors of objects ("concatenate")

x <- c(TRUE,FALSE)
x <- c(T,F)
x<-  c("a","b","c")
x<- 9:29
x <- vector("numeric", length=10)

## mixing
Mixing results in least common denominator, meaning the one that can be represented most generally


y <- c(1.7,"a")
[1] "1.7" "a"


## explicit coercion

resulting in NAS

# Matrices

constructed column-wise

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

# cbind, rbind

x <- 1:10
y <- 11:20

cbind(x,y) #consider them columns in the resulting matrix
rbind(x,y)


# Factors
ordered (profs) or unordered categorical data (labels)
treated specially by modeling functions such as lm and glm

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

# unclass
> unclass(x)
[1] 2 1 2 1 2
attr(,"levels")
[1] "no"  "yes"

# missing values

NaN and NA

every NaN missing and therefore an NA, converse not necessarily true.

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

# Data Frames

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

# Name attribute

lists and vectors can have them

x <- list(foo=1,bar=3)

# Reading Data

read.table, read.csv
readLines
source (inverse of dump)
dget (inverse of dput)
load (for reading in saved workspaces)
unserialize

## read.table

read everything on memory.
optimize by specifiying type of data. Easy trick: read first 100 lines and deduce classes from it, specify classes for the rest using deduced classes:

firstHondo <- read.table("datatable.txt",nrows=100)
classes <- sapply(firstHondo,class)
all <- read.table("datatable.txt",colClasses=classes)

rule of thumb according to video: guess  twice as much memory as the size of the object calculated colsxrowsx size of data cell

serialize and desirialize including metadata with dput and dget

> y <- data.frame(a=1,b="foo")
> dput(y)
structure(list(a = 1, b = structure(1L, .Label = "foo", class = "factor")), .Names = c("a", 
"b"), row.names = c(NA, -1L), class = "data.frame")
> dput(y,file="Y.R")


## Connection interfaces

Trivially simple functions to open files, urls, gzipped files.

## Subsetting

 [ ] single bracket always subsets and returns the same type.
 [[ ]] double bracket an element
 $ extract from data frame or list by name

using a condition for subsetting is referred to as "logical index" in the video:

> x <- c("a","b","c","d","e")
> x[x>"b"]
[1] "c" "d" "e"
> x[y>"b"]
[1] NA NA
Warning message:
In Ops.factor(left, right) : ‘>’ not meaningful for factors

## Subsetting lists

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

## Subsetting matrices

Similarly, subsetting a single column or a single row will give you a vector, not a matrix (by default).
> x <- matrix(1:6, 2, 3)
> x[1, ]
[1] 1 3 5
> x[1, , drop = FALSE]
 [,1] [,2] [,3]
[1,] 1 3 5

## Partial Matching

Partial matching of names is allowed with [[ and $.
> x <- list(aardvark = 1:5)
> x$a
[1] 1 2 3 4 5
> x[["a"]]
NULL
> x[["a", exact = FALSE]]
[1] 1 2 3 4 5

## Removing NA values

A common task is to remove missing values (NAs).
> x <- c(1, 2, NA, 4, NA, 5)
> bad <- is.na(x)
> x[!bad]
[1] 1 2 4 5

## Removing NA Values , more cases

use complete.cases if you have to make the decision of completeness based on multiple vectors or multiple values in data frames

 x <- c(1, 2, NA, 4, NA, 5)
> y <- c("a", "b", NA, "d", NA, "f")
> good <- complete.cases(x, y)
> good
[1] TRUE TRUE FALSE TRUE FALSE TRUE
> x[good]
[1] 1 2 4 5
> y[good]
[1] "a" "b" "d" "f"


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

## Vectorize operations

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

## Vectorized Matrix operations

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

Notice that R "fills out" the matrices using the data frame into the matrtx from "top to bottom, left to right"

## Control Structures

### Conditional

The typical, plus repeat for infinite loops and this syntactic sugar for assignments:

``` R
y <- if (x > 3) {
  10
}else{
0
}
```

### Loops

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

# First functions

See trivial_functions.R