
library(testthat)

#####################

context('doc01')
doc <- 
'Usage: prog'

  
    test_that('parsing "" works',{
		#$ prog
		#{}
      args <- ''
      expected <- list()

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--xxx" works',{
		#$ prog --xxx
		#"user-error"
      args <- '--xxx'

      expect_error(docopt(doc, args))
    })

#####################

context('doc02')
doc <- 
'Usage: prog [options]

Options: -a  All.'

  
    test_that('parsing "" works',{
		#$ prog
		#{"-a": false}
      args <- ''
      expected <- list("-a" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true}
      args <- '-a'
      expected <- list("-a" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-x" works',{
		#$ prog -x
		#"user-error"
      args <- '-x'

      expect_error(docopt(doc, args))
    })

#####################

context('doc03')
doc <- 
'Usage: prog [options]

Options: --all  All.'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--all": false}
      args <- ''
      expected <- list("--all" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--all" works',{
		#$ prog --all
		#{"--all": true}
      args <- '--all'
      expected <- list("--all" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--xxx" works',{
		#$ prog --xxx
		#"user-error"
      args <- '--xxx'

      expect_error(docopt(doc, args))
    })

#####################

context('doc04')
doc <- 
'Usage: prog [options]

Options: -v, --verbose  Verbose.'

  
    test_that('parsing "--verbose" works',{
		#$ prog --verbose
		#{"--verbose": true}
      args <- '--verbose'
      expected <- list("--verbose" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--ver" works',{
		#$ prog --ver
		#{"--verbose": true}
      args <- '--ver'
      expected <- list("--verbose" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"--verbose": true}
      args <- '-v'
      expected <- list("--verbose" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc05')
doc <- 
'Usage: prog [options]

Options: -p PATH'

  
    test_that('parsing "-p home/" works',{
		#$ prog -p home/
		#{"-p": "home/"}
      args <- '-p home/'
      expected <- list("-p" = "home/")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-phome/" works',{
		#$ prog -phome/
		#{"-p": "home/"}
      args <- '-phome/'
      expected <- list("-p" = "home/")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-p" works',{
		#$ prog -p
		#"user-error"
      args <- '-p'

      expect_error(docopt(doc, args))
    })

#####################

context('doc06')
doc <- 
'Usage: prog [options]

Options: --path <path>'

  
    test_that('parsing "--path home/" works',{
		#$ prog --path home/
		#{"--path": "home/"}
      args <- '--path home/'
      expected <- list("--path" = "home/")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--path=home/" works',{
		#$ prog --path=home/
		#{"--path": "home/"}
      args <- '--path=home/'
      expected <- list("--path" = "home/")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--pa home/" works',{
		#$ prog --pa home/
		#{"--path": "home/"}
      args <- '--pa home/'
      expected <- list("--path" = "home/")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--pa=home/" works',{
		#$ prog --pa=home/
		#{"--path": "home/"}
      args <- '--pa=home/'
      expected <- list("--path" = "home/")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--path" works',{
		#$ prog --path
		#"user-error"
      args <- '--path'

      expect_error(docopt(doc, args))
    })

#####################

context('doc07')
doc <- 
'Usage: prog [options]

Options: -p PATH, --path=<path>  Path to files.'

  
    test_that('parsing "-proot" works',{
		#$ prog -proot
		#{"--path": "root"}
      args <- '-proot'
      expected <- list("--path" = "root")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc08')
doc <- 
'Usage: prog [options]

Options:    -p --path PATH  Path to files.'

  
    test_that('parsing "-p root" works',{
		#$ prog -p root
		#{"--path": "root"}
      args <- '-p root'
      expected <- list("--path" = "root")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--path root" works',{
		#$ prog --path root
		#{"--path": "root"}
      args <- '--path root'
      expected <- list("--path" = "root")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc09')
doc <- 
'Usage: prog [options]

Options:
 -p PATH  Path to files [default: ./]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"-p": "./"}
      args <- ''
      expected <- list("-p" = "./")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-phome" works',{
		#$ prog -phome
		#{"-p": "home"}
      args <- '-phome'
      expected <- list("-p" = "home")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc10')
doc <- 
'UsAgE: prog [options]

OpTiOnS: --path=<files>  Path to files
                [dEfAuLt: /root]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--path": "/root"}
      args <- ''
      expected <- list("--path" = "/root")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--path=home" works',{
		#$ prog --path=home
		#{"--path": "home"}
      args <- '--path=home'
      expected <- list("--path" = "home")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc11')
doc <- 
'usage: prog [options]

options:
    -a        Add
    -r        Remote
    -m <msg>  Message'

  
    test_that('parsing "-a -r -m Hello" works',{
		#$ prog -a -r -m Hello
		#{"-a": true, "-r": true, "-m": "Hello"}
      args <- '-a -r -m Hello'
      expected <- list("-a" = TRUE, "-r" = TRUE, "-m" = "Hello")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-armyourass" works',{
		#$ prog -armyourass
		#{"-a": true, "-r": true, "-m": "yourass"}
      args <- '-armyourass'
      expected <- list("-a" = TRUE, "-r" = TRUE, "-m" = "yourass")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-a -r" works',{
		#$ prog -a -r
		#{"-a": true, "-r": true, "-m": null}
      args <- '-a -r'
      expected <- list("-a" = TRUE, "-r" = TRUE, "-m" = NULL)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc12')
doc <- 
'Usage: prog [options]

Options: --version
         --verbose'

  
    test_that('parsing "--version" works',{
		#$ prog --version
		#{"--version": true, "--verbose": false}
      args <- '--version'
      expected <- list("--version" = TRUE, "--verbose" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--verbose" works',{
		#$ prog --verbose
		#{"--version": false, "--verbose": true}
      args <- '--verbose'
      expected <- list("--version" = FALSE, "--verbose" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--ver" works',{
		#$ prog --ver
		#"user-error"
      args <- '--ver'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "--verb" works',{
		#$ prog --verb
		#{"--version": false, "--verbose": true}
      args <- '--verb'
      expected <- list("--version" = FALSE, "--verbose" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc13')
doc <- 
'usage: prog [-a -r -m <msg>]

options:
 -a        Add
 -r        Remote
 -m <msg>  Message'

  
    test_that('parsing "-armyourass" works',{
		#$ prog -armyourass
		#{"-a": true, "-r": true, "-m": "yourass"}
      args <- '-armyourass'
      expected <- list("-a" = TRUE, "-r" = TRUE, "-m" = "yourass")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc14')
doc <- 
'usage: prog [-armmsg]

options: -a        Add
         -r        Remote
         -m <msg>  Message'

  
    test_that('parsing "-a -r -m Hello" works',{
		#$ prog -a -r -m Hello
		#{"-a": true, "-r": true, "-m": "Hello"}
      args <- '-a -r -m Hello'
      expected <- list("-a" = TRUE, "-r" = TRUE, "-m" = "Hello")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc15')
doc <- 
'usage: prog -a -b

options:
 -a
 -b'

  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#{"-a": true, "-b": true}
      args <- '-a -b'
      expected <- list("-a" = TRUE, "-b" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}
      args <- '-b -a'
      expected <- list("-a" = TRUE, "-b" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"
      args <- '-a'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"
      args <- ''

      expect_error(docopt(doc, args))
    })

#####################

context('doc16')
doc <- 
'usage: prog (-a -b)

options: -a
         -b'

  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#{"-a": true, "-b": true}
      args <- '-a -b'
      expected <- list("-a" = TRUE, "-b" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}
      args <- '-b -a'
      expected <- list("-a" = TRUE, "-b" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"
      args <- '-a'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"
      args <- ''

      expect_error(docopt(doc, args))
    })

#####################

context('doc17')
doc <- 
'usage: prog [-a] -b

options: -a
 -b'

  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#{"-a": true, "-b": true}
      args <- '-a -b'
      expected <- list("-a" = TRUE, "-b" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}
      args <- '-b -a'
      expected <- list("-a" = TRUE, "-b" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"
      args <- '-a'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#{"-a": false, "-b": true}
      args <- '-b'
      expected <- list("-a" = FALSE, "-b" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"
      args <- ''

      expect_error(docopt(doc, args))
    })

#####################

context('doc18')
doc <- 
'usage: prog [(-a -b)]

options: -a
         -b'

  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#{"-a": true, "-b": true}
      args <- '-a -b'
      expected <- list("-a" = TRUE, "-b" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}
      args <- '-b -a'
      expected <- list("-a" = TRUE, "-b" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"
      args <- '-a'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#"user-error"
      args <- '-b'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-a": false, "-b": false}
      args <- ''
      expected <- list("-a" = FALSE, "-b" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc19')
doc <- 
'usage: prog (-a|-b)

options: -a
         -b'

  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#"user-error"
      args <- '-a -b'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"
      args <- ''

      expect_error(docopt(doc, args))
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true, "-b": false}
      args <- '-a'
      expected <- list("-a" = TRUE, "-b" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#{"-a": false, "-b": true}
      args <- '-b'
      expected <- list("-a" = FALSE, "-b" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc20')
doc <- 
'usage: prog [ -a | -b ]

options: -a
         -b'

  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#"user-error"
      args <- '-a -b'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-a": false, "-b": false}
      args <- ''
      expected <- list("-a" = FALSE, "-b" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true, "-b": false}
      args <- '-a'
      expected <- list("-a" = TRUE, "-b" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#{"-a": false, "-b": true}
      args <- '-b'
      expected <- list("-a" = FALSE, "-b" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc21')
doc <- 
'usage: prog <arg>'

  
    test_that('parsing "10" works',{
		#$ prog 10
		#{"<arg>": "10"}
      args <- '10'
      expected <- list("<arg>" = "10")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#"user-error"
      args <- '10 20'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"
      args <- ''

      expect_error(docopt(doc, args))
    })

#####################

context('doc22')
doc <- 
'usage: prog [<arg>]'

  
    test_that('parsing "10" works',{
		#$ prog 10
		#{"<arg>": "10"}
      args <- '10'
      expected <- list("<arg>" = "10")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#"user-error"
      args <- '10 20'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<arg>": null}
      args <- ''
      expected <- list("<arg>" = NULL)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc23')
doc <- 
'usage: prog <kind> <name> <type>'

  
    test_that('parsing "10 20 40" works',{
		#$ prog 10 20 40
		#{"<kind>": "10", "<name>": "20", "<type>": "40"}
      args <- '10 20 40'
      expected <- list("<kind>" = "10", "<name>" = "20", "<type>" = "40")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#"user-error"
      args <- '10 20'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"
      args <- ''

      expect_error(docopt(doc, args))
    })

#####################

context('doc24')
doc <- 
'usage: prog <kind> [<name> <type>]'

  
    test_that('parsing "10 20 40" works',{
		#$ prog 10 20 40
		#{"<kind>": "10", "<name>": "20", "<type>": "40"}
      args <- '10 20 40'
      expected <- list("<kind>" = "10", "<name>" = "20", "<type>" = "40")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"<kind>": "10", "<name>": "20", "<type>": null}
      args <- '10 20'
      expected <- list("<kind>" = "10", "<name>" = "20", "<type>" = NULL)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"
      args <- ''

      expect_error(docopt(doc, args))
    })

#####################

context('doc25')
doc <- 
'usage: prog [<kind> | <name> <type>]'

  
    test_that('parsing "10 20 40" works',{
		#$ prog 10 20 40
		#"user-error"
      args <- '10 20 40'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "20 40" works',{
		#$ prog 20 40
		#{"<kind>": null, "<name>": "20", "<type>": "40"}
      args <- '20 40'
      expected <- list("<kind>" = NULL, "<name>" = "20", "<type>" = "40")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<kind>": null, "<name>": null, "<type>": null}
      args <- ''
      expected <- list("<kind>" = NULL, "<name>" = NULL, "<type>" = NULL)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc26')
doc <- 
'usage: prog (<kind> --all | <name>)

options:
 --all'

  
    test_that('parsing "10 --all" works',{
		#$ prog 10 --all
		#{"<kind>": "10", "--all": true, "<name>": null}
      args <- '10 --all'
      expected <- list("<kind>" = "10", "--all" = TRUE, "<name>" = NULL)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"<kind>": null, "--all": false, "<name>": "10"}
      args <- '10'
      expected <- list("<kind>" = NULL, "--all" = FALSE, "<name>" = "10")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"
      args <- ''

      expect_error(docopt(doc, args))
    })

#####################

context('doc27')
doc <- 
'usage: prog [<name> <name>]'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"<name>": ["10", "20"]}
      args <- '10 20'
      expected <- list("<name>" = c("10", "20"))

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"<name>": ["10"]}
      args <- '10'
      expected <- list("<name>" = "10")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<name>": []}
      args <- ''
      expected <- list("<name>" = list())

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc28')
doc <- 
'usage: prog [(<name> <name>)]'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"<name>": ["10", "20"]}
      args <- '10 20'
      expected <- list("<name>" = c("10", "20"))

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#"user-error"
      args <- '10'

      expect_error(docopt(doc, args))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<name>": []}
      args <- ''
      expected <- list("<name>" = list())

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc29')
doc <- 
'usage: prog NAME...'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}
      args <- '10 20'
      expected <- list(NAME = c("10", "20"))

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}
      args <- '10'
      expected <- list(NAME = "10")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"
      args <- ''

      expect_error(docopt(doc, args))
    })

#####################

context('doc30')
doc <- 
'usage: prog [NAME]...'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}
      args <- '10 20'
      expected <- list(NAME = c("10", "20"))

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}
      args <- '10'
      expected <- list(NAME = "10")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}
      args <- ''
      expected <- list(NAME = list())

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc31')
doc <- 
'usage: prog [NAME...]'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}
      args <- '10 20'
      expected <- list(NAME = c("10", "20"))

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}
      args <- '10'
      expected <- list(NAME = "10")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}
      args <- ''
      expected <- list(NAME = list())

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc32')
doc <- 
'usage: prog [NAME [NAME ...]]'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}
      args <- '10 20'
      expected <- list(NAME = c("10", "20"))

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}
      args <- '10'
      expected <- list(NAME = "10")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}
      args <- ''
      expected <- list(NAME = list())

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc33')
doc <- 
'usage: prog (NAME | --foo NAME)

options: --foo'

  
    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": "10", "--foo": false}
      args <- '10'
      expected <- list(NAME = "10", "--foo" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--foo 10" works',{
		#$ prog --foo 10
		#{"NAME": "10", "--foo": true}
      args <- '--foo 10'
      expected <- list(NAME = "10", "--foo" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--foo=10" works',{
		#$ prog --foo=10
		#"user-error"
      args <- '--foo=10'

      expect_error(docopt(doc, args))
    })

#####################

context('doc34')
doc <- 
'usage: prog (NAME | --foo) [--bar | NAME]

options: --foo
options: --bar'

  
    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"], "--foo": false, "--bar": false}
      args <- '10'
      expected <- list(NAME = "10", "--foo" = FALSE, "--bar" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"], "--foo": false, "--bar": false}
      args <- '10 20'
      expected <- list(NAME = c("10", "20"), "--foo" = FALSE, "--bar" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--foo --bar" works',{
		#$ prog --foo --bar
		#{"NAME": [], "--foo": true, "--bar": true}
      args <- '--foo --bar'
      expected <- list(NAME = list(), "--foo" = TRUE, "--bar" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc35')
doc <- 
'Naval Fate.

Usage:
  prog ship new <name>...
  prog ship [<name>] move <x> <y> [--speed=<kn>]
  prog ship shoot <x> <y>
  prog mine (set|remove) <x> <y> [--moored|--drifting]
  prog -h | --help
  prog --version

Options:
  -h --help     Show this screen.
  --version     Show version.
  --speed=<kn>  Speed in knots [default: 10].
  --moored      Mored (anchored) mine.
  --drifting    Drifting mine.'

  
    test_that('parsing "ship Guardian move 150 300 --speed=20" works',{
		#$ prog ship Guardian move 150 300 --speed=20
		#{"--drifting": false, "--help": false, "--moored": false, "--speed": "20", "--version": false, "<name>": ["Guardian"], "<x>": "150", "<y>": "300", "mine": false, "move": true, "new": false, "remove": false, "set": false, "ship": true, "shoot": false}
      args <- 'ship Guardian move 150 300 --speed=20'
      expected <- list("--drifting" = FALSE, "--help" = FALSE, "--moored" = FALSE, ,    "--speed" = "20", "--version" = FALSE, "<name>" = "Guardian", ,    "<x>" = "150", "<y>" = "300", mine = FALSE, move = TRUE, ,    new = FALSE, remove = FALSE, set = FALSE, ship = TRUE, shoot = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc36')
doc <- 
'usage: prog --hello'

  
    test_that('parsing "--hello" works',{
		#$ prog --hello
		#{"--hello": true}
      args <- '--hello'
      expected <- list("--hello" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc37')
doc <- 
'usage: prog [--hello=<world>]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--hello": null}
      args <- ''
      expected <- list("--hello" = NULL)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--hello wrld" works',{
		#$ prog --hello wrld
		#{"--hello": "wrld"}
      args <- '--hello wrld'
      expected <- list("--hello" = "wrld")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc38')
doc <- 
'usage: prog [-o]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"-o": false}
      args <- ''
      expected <- list("-o" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-o" works',{
		#$ prog -o
		#{"-o": true}
      args <- '-o'
      expected <- list("-o" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc39')
doc <- 
'usage: prog [-opr]'

  
    test_that('parsing "-op" works',{
		#$ prog -op
		#{"-o": true, "-p": true, "-r": false}
      args <- '-op'
      expected <- list("-o" = TRUE, "-p" = TRUE, "-r" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc40')
doc <- 
'usage: prog --aabb | --aa'

  
    test_that('parsing "--aa" works',{
		#$ prog --aa
		#{"--aabb": false, "--aa": true}
      args <- '--aa'
      expected <- list("--aabb" = FALSE, "--aa" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc41')
doc <- 
'Usage: prog -v'

  
    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": true}
      args <- '-v'
      expected <- list("-v" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc42')
doc <- 
'Usage: prog [-v -v]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"-v": 0}
      args <- ''
      expected <- list("-v" = 0)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": 1}
      args <- '-v'
      expected <- list("-v" = 1)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-vv" works',{
		#$ prog -vv
		#{"-v": 2}
      args <- '-vv'
      expected <- list("-v" = 2)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc43')
doc <- 
'Usage: prog -v ...'

  
    test_that('parsing "" works',{
		#$ prog
		#"user-error"
      args <- ''

      expect_error(docopt(doc, args))
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": 1}
      args <- '-v'
      expected <- list("-v" = 1)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-vv" works',{
		#$ prog -vv
		#{"-v": 2}
      args <- '-vv'
      expected <- list("-v" = 2)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-vvvvvv" works',{
		#$ prog -vvvvvv
		#{"-v": 6}
      args <- '-vvvvvv'
      expected <- list("-v" = 6)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc44')
doc <- 
'Usage: prog [-v | -vv | -vvv]

This one is probably most readable user-friednly variant.'

  
    test_that('parsing "" works',{
		#$ prog
		#{"-v": 0}
      args <- ''
      expected <- list("-v" = 0)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": 1}
      args <- '-v'
      expected <- list("-v" = 1)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-vv" works',{
		#$ prog -vv
		#{"-v": 2}
      args <- '-vv'
      expected <- list("-v" = 2)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-vvvv" works',{
		#$ prog -vvvv
		#"user-error"
      args <- '-vvvv'

      expect_error(docopt(doc, args))
    })

#####################

context('doc45')
doc <- 
'usage: prog [--ver --ver]'

  
    test_that('parsing "--ver --ver" works',{
		#$ prog --ver --ver
		#{"--ver": 2}
      args <- '--ver --ver'
      expected <- list("--ver" = 2)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc46')
doc <- 
'usage: prog [go]'

  
    test_that('parsing "go" works',{
		#$ prog go
		#{"go": true}
      args <- 'go'
      expected <- list(go = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc47')
doc <- 
'usage: prog [go go]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"go": 0}
      args <- ''
      expected <- list(go = 0)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "go" works',{
		#$ prog go
		#{"go": 1}
      args <- 'go'
      expected <- list(go = 1)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "go go" works',{
		#$ prog go go
		#{"go": 2}
      args <- 'go go'
      expected <- list(go = 2)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "go go go" works',{
		#$ prog go go go
		#"user-error"
      args <- 'go go go'

      expect_error(docopt(doc, args))
    })

#####################

context('doc48')
doc <- 
'usage: prog go..."""
$ prog go go go go go
{"go": 5}


options: -a
         -b'

  
    test_that('parsing "go go go go go" works',{
		#$ prog go go go go go
		#{"go": 5}
      args <- 'go go go go go'
      expected <- list(go = 5)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true, "-b": false}
      args <- '-a'
      expected <- list("-a" = TRUE, "-b" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-aa" works',{
		#$ prog -aa
		#"user-error"
      args <- '-aa'

      expect_error(docopt(doc, args))
    })

#####################

context('doc49')
doc <- 
'Usage: prog [options] A
Options:
    -q  Be quiet
    -v  Be verbose.'

  
    test_that('parsing "arg" works',{
		#$ prog arg
		#{"A": "arg", "-v": false, "-q": false}
      args <- 'arg'
      expected <- list(A = "arg", "-v" = FALSE, "-q" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-v arg" works',{
		#$ prog -v arg
		#{"A": "arg", "-v": true, "-q": false}
      args <- '-v arg'
      expected <- list(A = "arg", "-v" = TRUE, "-q" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-q arg" works',{
		#$ prog -q arg
		#{"A": "arg", "-v": false, "-q": true}
      args <- '-q arg'
      expected <- list(A = "arg", "-v" = FALSE, "-q" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc50')
doc <- 
'NA'

  
    test_that('parsing "-" works',{
		#$ prog -
		#{"-": true}
      args <- '-'
      expected <- list("-" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-": false}
      args <- ''
      expected <- list("-" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc51')
doc <- 
'NA'

  
    test_that('parsing "a b" works',{
		#$ prog a b
		#{"NAME": ["a", "b"]}
      args <- 'a b'
      expected <- list(NAME = c("a", "b"))

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}
      args <- ''
      expected <- list(NAME = list())

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc52')
doc <- 
'usage: prog [options]
options:
 -a        Add
 -m <msg>  Message'

  
    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-m": null, "-a": true}
      args <- '-a'
      expected <- list("-m" = NULL, "-a" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc53')
doc <- 
'usage: prog --hello'

  
    test_that('parsing "--hello" works',{
		#$ prog --hello
		#{"--hello": true}
      args <- '--hello'
      expected <- list("--hello" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc54')
doc <- 
'usage: prog [--hello=<world>]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--hello": null}
      args <- ''
      expected <- list("--hello" = NULL)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--hello wrld" works',{
		#$ prog --hello wrld
		#{"--hello": "wrld"}
      args <- '--hello wrld'
      expected <- list("--hello" = "wrld")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc55')
doc <- 
'usage: prog [-o]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"-o": false}
      args <- ''
      expected <- list("-o" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "-o" works',{
		#$ prog -o
		#{"-o": true}
      args <- '-o'
      expected <- list("-o" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc56')
doc <- 
'usage: prog [-opr]'

  
    test_that('parsing "-op" works',{
		#$ prog -op
		#{"-o": true, "-p": true, "-r": false}
      args <- '-op'
      expected <- list("-o" = TRUE, "-p" = TRUE, "-r" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc57')
doc <- 
'usage: git [-v | --verbose]'

  
    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": true, "--verbose": false}
      args <- '-v'
      expected <- list("-v" = TRUE, "--verbose" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc58')
doc <- 
'usage: git remote [-v | --verbose]'

  
    test_that('parsing "remote -v" works',{
		#$ prog remote -v
		#{"remote": true, "-v": true, "--verbose": false}
      args <- 'remote -v'
      expected <- list(remote = TRUE, "-v" = TRUE, "--verbose" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc59')
doc <- 
'usage: prog'

  
    test_that('parsing "" works',{
		#$ prog
		#{}
      args <- ''
      expected <- list()

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc60')
doc <- 
'usage: prog
           prog <a> <b>'

  
    test_that('parsing "1 2" works',{
		#$ prog 1 2
		#{"<a>": "1", "<b>": "2"}
      args <- '1 2'
      expected <- list("<a>" = "1", "<b>" = "2")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<a>": null, "<b>": null}
      args <- ''
      expected <- list("<a>" = NULL, "<b>" = NULL)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc61')
doc <- 
'usage: prog <a> <b>
           prog'

  
    test_that('parsing "" works',{
		#$ prog
		#{"<a>": null, "<b>": null}
      args <- ''
      expected <- list("<a>" = NULL, "<b>" = NULL)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc62')
doc <- 
'usage: prog [--file=<f>]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--file": null}
      args <- ''
      expected <- list("--file" = NULL)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc63')
doc <- 
'usage: prog [--file=<f>]

options: --file <a>'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--file": null}
      args <- ''
      expected <- list("--file" = NULL)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc64')
doc <- 
'Usage: prog [-a <host:port>]

Options: -a, --address <host:port>  TCP address [default: localhost:6283].'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--address": "localhost:6283"}
      args <- ''
      expected <- list("--address" = "localhost:6283")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc65')
doc <- 
'NA'

  
    test_that('parsing "--long one" works',{
		#$ prog --long one
		#{"--long": ["one"]}
      args <- '--long one'
      expected <- list("--long" = "one")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "--long one --long two" works',{
		#$ prog --long one --long two
		#{"--long": ["one", "two"]}
      args <- '--long one --long two'
      expected <- list("--long" = c("one", "two"))

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc66')
doc <- 
'usage: prog (go <direction> --speed=<km/h>)...'

  
    test_that('parsing "go left --speed=5  go right --speed=9" works',{
		#$ prog  go left --speed=5  go right --speed=9
		#{"go": 2, "<direction>": ["left", "right"], "--speed": ["5", "9"]}
      args <- 'go left --speed=5  go right --speed=9'
      expected <- list(go = 2, "<direction>" = c("left", "right"), "--speed" = c("5", ,"9"))

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc67')
doc <- 
'usage: prog [options] -a

options: -a'

  
    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true}
      args <- '-a'
      expected <- list("-a" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc68')
doc <- 
'usage: prog [-o <o>]...

options: -o <o>  [default: x]'

  
    test_that('parsing "-o this -o that" works',{
		#$ prog -o this -o that
		#{"-o": ["this", "that"]}
      args <- '-o this -o that'
      expected <- list("-o" = c("this", "that"))

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-o": ["x"]}
      args <- ''
      expected <- list("-o" = "x")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc69')
doc <- 
'usage: prog [-o <o>]...

options: -o <o>  [default: x y]'

  
    test_that('parsing "-o this" works',{
		#$ prog -o this
		#{"-o": ["this"]}
      args <- '-o this'
      expected <- list("-o" = "this")

      expect_equivalent(docopt(doc, args), expected)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-o": ["x", "y"]}
      args <- ''
      expected <- list("-o" = c("x", "y"))

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc70')
doc <- 
'usage: prog -pPATH

options: -p PATH'

  
    test_that('parsing "-pHOME" works',{
		#$ prog -pHOME
		#{"-p": "HOME"}
      args <- '-pHOME'
      expected <- list("-p" = "HOME")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc71')
doc <- 
'Usage: foo (--xx=x|--yy=y)...'

  
    test_that('parsing "--xx=1 --yy=2" works',{
		#$ prog --xx=1 --yy=2
		#{"--xx": ["1"], "--yy": ["2"]}
      args <- '--xx=1 --yy=2'
      expected <- list("--xx" = "1", "--yy" = "2")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc72')
doc <- 
'usage: prog [<input file>]'

  
    test_that('parsing "f.txt" works',{
		#$ prog f.txt
		#{"<input file>": "f.txt"}
      args <- 'f.txt'
      expected <- list("<input file>" = "f.txt")

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc73')
doc <- 
'usage: prog [--input=<file name>]...'

  
    test_that('parsing "--input a.txt --input=b.txt" works',{
		#$ prog --input a.txt --input=b.txt
		#{"--input": ["a.txt", "b.txt"]}
      args <- '--input a.txt --input=b.txt'
      expected <- list("--input" = c("a.txt", "b.txt"))

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc74')
doc <- 
'usage: prog good [options]
           prog fail [options]

options: --loglevel=N'

  
    test_that('parsing "fail --loglevel 5" works',{
		#$ prog fail --loglevel 5
		#{"--loglevel": "5", "fail": true, "good": false}
      args <- 'fail --loglevel 5'
      expected <- list("--loglevel" = "5", fail = TRUE, good = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc75')
doc <- 
'usage:prog --foo'

  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true}
      args <- '--foo'
      expected <- list("--foo" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc76')
doc <- 
'PROGRAM USAGE: prog --foo'

  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true}
      args <- '--foo'
      expected <- list("--foo" = TRUE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc77')
doc <- 
'Usage: prog --foo
           prog --bar
NOT PART OF SECTION'

  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true, "--bar": false}
      args <- '--foo'
      expected <- list("--foo" = TRUE, "--bar" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc78')
doc <- 
'Usage:
 prog --foo
 prog --bar

NOT PART OF SECTION'

  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true, "--bar": false}
      args <- '--foo'
      expected <- list("--foo" = TRUE, "--bar" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc79')
doc <- 
'Usage:
 prog --foo
 prog --bar
NOT PART OF SECTION'

  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true, "--bar": false}
      args <- '--foo'
      expected <- list("--foo" = TRUE, "--bar" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })

#####################

context('doc80')
doc <- 
'Usage: prog [options]

global options: --foo
local options: --baz
               --bar
other options:
 --egg
 --spam
-not-an-option-'

  
    test_that('parsing "--baz --egg" works',{
		#$ prog --baz --egg
		#{"--foo": false, "--baz": true, "--bar": false, "--egg": true, "--spam": false}
      args <- '--baz --egg'
      expected <- list("--foo" = FALSE, "--baz" = TRUE, "--bar" = FALSE, "--egg" = TRUE, ,    "--spam" = FALSE)

      expect_equivalent(docopt(doc, args), expected)
    })


