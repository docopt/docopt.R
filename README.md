[![version](https://www.r-pkg.org/badges/version/docopt)](https://cran.r-project.org/package=docopt)
![downloads](https://cranlogs.r-pkg.org/badges/docopt)
[![Build Status](https://travis-ci.org/docopt/docopt.R.svg?branch=master)](https://travis-ci.org/docopt/docopt.R)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/docopt/docopt.R?branch=master&svg=true)](https://ci.appveyor.com/project/docopt/docopt.R)
[![Depsy](http://depsy.org/api/package/cran/docopt/badge.svg)](http://depsy.org/package/r/docopt)

# docopt

`docopt` helps you to:

- define an interface for your command-line application, and
- automatically generate a parser for it.

R package `docopt` is an implementation of [docopt](http://docopt.org) in the R programming language.
See my presentation on the [useR! 2014](http://www.slideshare.net/EdwindeJonge1/docopt-user2014) for more details.

For more information see [docopt.org](http://docopt.org)

To try docopt in your browser visit [try.docopt.org](http://try.docopt.org/)


## Installation

The easiest way to get `docopt` is to install from 
[CRAN](https://cran.r-project.org/web/packages/docopt/index.html):

```R
install.packages("docopt")
library(docopt)
```
### Development version

The latest version of `docopt` can be installed from GitHub using 
[devtools](https://github.com/r-lib/devtools):

```R
library(devtools)  # make sure to have devtools 1.4!
install_github("docopt/docopt.R")
```


## Testing

It is tested against the tests defined for the reference implementation.
It passes most tests. It currently fails tests that 

- count arguments: `my_prog.R -v -v` should return `list(v=2)`

The tests can be run using `devtools::test()` and can be found in "tests" directory.

```R
library(devtools)
devtools::test()
```


## Usage

`docopt` uses the description of the command-line interface (i.e. help message docstring) 
to parse command-line arguments.

```R
'Naval Fate.

Usage:
  naval_fate.R ship new <name>...
  naval_fate.R ship <name> move <x> <y> [--speed=<kn>]
  naval_fate.R ship shoot <x> <y>
  naval_fate.R mine (set|remove) <x> <y> [--moored | --drifting]
  naval_fate.R (-h | --help)
  naval_fate.R --version

Options:
  -h --help     Show this screen.
  --version     Show version.
  --speed=<kn>  Speed in knots [default: 10].
  --moored      Moored (anchored) mine.
  --drifting    Drifting mine.

' -> doc

library(docopt)
arguments <- docopt(doc, version = 'Naval Fate 2.0')
print(arguments)
```

The option parser is generated based on the docstring above that is passed to `docopt` function. 
`docopt` parses the usage pattern (`"Usage: ..."`) and option descriptions 
(lines starting with dash `"-"`) and ensures that the program invocation matches the 
usage pattern; it parses options, arguments and commands based on that. 
The basic idea is that *a good help message has all necessary information in it to make a parser*.

To execute your command-line application you need to provide path to command-line executable file
(i.e. `naval_fate.R` in our case) and provide relevant command-line `arguments/options/commands`.

For example

* To print command-line application help message:

```
$ Rscript path/to/naval_fate.R --help
Naval Fate.

Usage:
  naval_fate.R ship new <name>...
  naval_fate.R ship <name> move <x> <y> [--speed=<kn>]
  naval_fate.R ship shoot <x> <y>
  naval_fate.R mine (set|remove) <x> <y> [--moored | --drifting]
  naval_fate.R (-h | --help)
  naval_fate.R --version

Options:
  -h --help     Show this screen.
  --version     Show version.
  --speed=<kn>  Speed in knots [default: 10].
  --moored      Moored (anchored) mine.
  --drifting    Drifting mine.
```

* To print command-line application version information:

```
$ Rscript path/to/naval_fate.R --version
Naval Fate 2.0
```

* `docopt` function returns a list of command-line parameters and their 
  corresponding values that can be accessed via `$` within your command-line 
  application.

```
$ Rscript path/to/naval_fate.R ship Guardian move 10 50 --speed=20
List of 23
 $ --help    : logi FALSE
 $ --version : logi FALSE
 $ --speed   : chr "20"
 $ --moored  : logi FALSE
 $ --drifting: logi FALSE
 $ ship      : logi TRUE
 $ new       : logi FALSE
 $ <name>    : chr "Guardian"
 $ move      : logi TRUE
 $ <x>       : chr "10"
 $ <y>       : chr "50"
 $ shoot     : logi FALSE
 $ mine      : logi FALSE
 $ set       : logi FALSE
 $ remove    : logi FALSE
 $ help      : logi FALSE
 $ version   : logi FALSE
 $ speed     : chr "20"
 $ moored    : logi FALSE
 $ drifting  : logi FALSE
 $ name      : chr "Guardian"
 $ x         : chr "10"
 $ y         : chr "50"
```

* In case if provided command-line parameters are inconsistent with the 
  `"Usage: ..."` pattern the error message will be printed along with
  usage pattern examples.

```
$ Rscript path/to/naval_fate.R ship mine
Error: 
 usage: naval_fate.R ship new <name>...
  
 usage: naval_fate.R ship <name> move <x> <y> [--speed=<kn>]
  
 usage: naval_fate.R ship shoot <x> <y>
  
 usage: naval_fate.R mine (set|remove) <x> <y> [--moored | --drifting]
  
 usage: naval_fate.R (-h | --help)
  
 usage: naval_fate.R --version
Execution halted
```
