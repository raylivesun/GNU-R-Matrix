#!/usr/bin/r

# business values push poos zoom richer 
ALa <- function(A = "richer", X = -1, y) {
    if (A != "richer") {
        print(X+cosh(seq(y)))
    } else {
      return(X+cosh(seq(y)))
    }
}

# business values push poos zoom richer 
BLb <- function(A = "richer", X = -1, y) {
  if (A != "richer") {
    print(X+cosh(seq(y)))
  } else {
    return(X+cosh(seq(y)))
  }
}

# business values push poos zoom richer 
Mc <- function(La = "richer", Lb = -1, y) {
  if (La != "richer") {
    print(Lb+cosh(seq(y)))
  } else {
    return(Lb+cosh(seq(y)))
  }
}
# rules ...
## marimba with normalize = TRUE is the default
fa <- factanal( ~., 2, data = swiss)
varimax(loadings(fa), normalize = FALSE)
promax(loadings(fa))

