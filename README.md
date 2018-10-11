[![version](https://www.r-pkg.org/badges/version/docopt)](https://cran.r-project.org/package=docopt)
![downloads](https://cranlogs.r-pkg.org/badges/docopt)
[![Build Status](https://travis-ci.org/docopt/docopt.R.svg?branch=master)](https://travis-ci.org/docopt/docopt.R)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/docopt/docopt.R?branch=master&svg=true)](https://ci.appveyor.com/project/docopt/docopt.R)
[![Depsy](http://depsy.org/api/package/cran/docopt/badge.svg)](http://depsy.org/package/r/docopt)

docopt
========================================================

`docopt` helps you to:

- define an interface for your command-line app, and
- automatically generate a parser for it.

For more information see [docopt.org](http://docopt.org)

R package `docopt` is an implementation of [docopt](http://docopt.org) in the R language.
See my presentation on the [useR! 2014](http://www.slideshare.net/EdwindeJonge1/docopt-user2014) for more details.

Install
-------

The latest version of `docopt` can be installed using:

```S
library(devtools)  # make sure to have devtools 1.4!
install_github("docopt/docopt.R")
```


It is tested against the tests defined for the reference implementation.
It passes most tests. It currently fails tests that 

- count arguments: `my_prog.R -v -v` should return `list(v=2)`

The tests can be run using devtools `test()` and can be found in "inst/tests"

Usage
-----

docopt uses the description of the command-line interface to parse command line
arguments.


```S
'usage: my_prog.R [-a -r -m <msg>]

options:
 -a        Add
 -r        Remote
 -m <msg>  Message' -> doc

# load the docopt library
library(docopt)
# retrieve the command-line arguments
opts <- docopt(doc)
# what are the options? Note that stripped versions of the parameters are added to the returned list
str(opts)  
```

```
## List of 3
##  $ -a: logi FALSE
##  $ -r: logi FALSE
##  $ -m: chr "<msg>"
##  $ a: logi FALSE
##  $ r: logi FALSE
##  $ m: chr "<msg>"
```

```S

# or set them manually
opts <- docopt(doc, "-m Hello")
str(opts)
```

```
## List of 3
##  $ -a: logi FALSE
##  $ -r: logi FALSE
##  $ -m: chr "Hello"
##  $ a: logi FALSE
##  $ r: logi FALSE
##  $ m: chr "Hello"
```
