docopt.R
========================================================

`docopt` helps you:

- define interface for your command-line app, and
- automatically generate parser for it.

For more information see [docopt.org](http://docopt.org)

docopt.R is an implementation of [docopt](http://docopt.org) in the R language.

Install
-------

`docopt.R` is currently in heavy development and not available on CRAN.
To test it out use
```
library(devtools)
install_github("docopt.R", "edwindj")
```

It is tested against the tests defined for the reference implementation.
Currently it fails many tests. 
The tests can be run using devtools `test()` and can be found in "inst/tests"

Usage
-----

docopt uses the description of the commandline interface to parse command line
arguments.


```r
'usage: prog [-a -r -m <msg>]

options:
 -a        Add
 -r        Remote
 -m <msg>  Message' -> doc

library(docopt)
```

```
## Loading required package: stringr
```

```r
docopt(doc, "-m Hello")
```

```
## $`-a`
## [1] FALSE
## 
## $`-r`
## [1] FALSE
## 
## $`-m`
## [1] "Hello"
```

