
library(testthat)
  
doc <- 
'Usage: prog'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{}

      args <- parse_args('', options)
      output <- list()
      expect_equivalent(args, output)
    })

    test_that('parsing "--xxx" works',{
		#$ prog --xxx
		#"user-error"

      args <- parse_args('--xxx', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [options]

Options: -a  All.'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"-a": false}

      args <- parse_args('', options)
      output <- list("-a" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true}

      args <- parse_args('-a', options)
      output <- list("-a" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-x" works',{
		#$ prog -x
		#"user-error"

      args <- parse_args('-x', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [options]

Options: --all  All.'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"--all": false}

      args <- parse_args('', options)
      output <- list("--all" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "--all" works',{
		#$ prog --all
		#{"--all": true}

      args <- parse_args('--all', options)
      output <- list("--all" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "--xxx" works',{
		#$ prog --xxx
		#"user-error"

      args <- parse_args('--xxx', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [options]

Options: -v, --verbose  Verbose.'
  # TODO parse options
  
    test_that('parsing "--verbose" works',{
		#$ prog --verbose
		#{"--verbose": true}

      args <- parse_args('--verbose', options)
      output <- list("--verbose" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "--ver" works',{
		#$ prog --ver
		#{"--verbose": true}

      args <- parse_args('--ver', options)
      output <- list("--verbose" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"--verbose": true}

      args <- parse_args('-v', options)
      output <- list("--verbose" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [options]

Options: -p PATH'
  # TODO parse options
  
    test_that('parsing "-p home/" works',{
		#$ prog -p home/
		#{"-p": "home/"}

      args <- parse_args('-p home/', options)
      output <- list("-p" = "home/")
      expect_equivalent(args, output)
    })

    test_that('parsing "-phome/" works',{
		#$ prog -phome/
		#{"-p": "home/"}

      args <- parse_args('-phome/', options)
      output <- list("-p" = "home/")
      expect_equivalent(args, output)
    })

    test_that('parsing "-p" works',{
		#$ prog -p
		#"user-error"

      args <- parse_args('-p', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [options]

Options: --path <path>'
  # TODO parse options
  
    test_that('parsing "--path home/" works',{
		#$ prog --path home/
		#{"--path": "home/"}

      args <- parse_args('--path home/', options)
      output <- list("--path" = "home/")
      expect_equivalent(args, output)
    })

    test_that('parsing "--path=home/" works',{
		#$ prog --path=home/
		#{"--path": "home/"}

      args <- parse_args('--path=home/', options)
      output <- list("--path" = "home/")
      expect_equivalent(args, output)
    })

    test_that('parsing "--pa home/" works',{
		#$ prog --pa home/
		#{"--path": "home/"}

      args <- parse_args('--pa home/', options)
      output <- list("--path" = "home/")
      expect_equivalent(args, output)
    })

    test_that('parsing "--pa=home/" works',{
		#$ prog --pa=home/
		#{"--path": "home/"}

      args <- parse_args('--pa=home/', options)
      output <- list("--path" = "home/")
      expect_equivalent(args, output)
    })

    test_that('parsing "--path" works',{
		#$ prog --path
		#"user-error"

      args <- parse_args('--path', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [options]

Options: -p PATH, --path=<path>  Path to files.'
  # TODO parse options
  
    test_that('parsing "-proot" works',{
		#$ prog -proot
		#{"--path": "root"}

      args <- parse_args('-proot', options)
      output <- list("--path" = "root")
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [options]

Options:    -p --path PATH  Path to files.'
  # TODO parse options
  
    test_that('parsing "-p root" works',{
		#$ prog -p root
		#{"--path": "root"}

      args <- parse_args('-p root', options)
      output <- list("--path" = "root")
      expect_equivalent(args, output)
    })

    test_that('parsing "--path root" works',{
		#$ prog --path root
		#{"--path": "root"}

      args <- parse_args('--path root', options)
      output <- list("--path" = "root")
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [options]

Options:
 -p PATH  Path to files [default: ./]'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"-p": "./"}

      args <- parse_args('', options)
      output <- list("-p" = "./")
      expect_equivalent(args, output)
    })

    test_that('parsing "-phome" works',{
		#$ prog -phome
		#{"-p": "home"}

      args <- parse_args('-phome', options)
      output <- list("-p" = "home")
      expect_equivalent(args, output)
    })
  
doc <- 
'UsAgE: prog [options]

OpTiOnS: --path=<files>  Path to files
                [dEfAuLt: /root]'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"--path": "/root"}

      args <- parse_args('', options)
      output <- list("--path" = "/root")
      expect_equivalent(args, output)
    })

    test_that('parsing "--path=home" works',{
		#$ prog --path=home
		#{"--path": "home"}

      args <- parse_args('--path=home', options)
      output <- list("--path" = "home")
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [options]

options:
    -a        Add
    -r        Remote
    -m <msg>  Message'
  # TODO parse options
  
    test_that('parsing "-a -r -m Hello" works',{
		#$ prog -a -r -m Hello
		#{"-a": true, "-r": true, "-m": "Hello"}

      args <- parse_args('-a -r -m Hello', options)
      output <- list("-a" = TRUE, "-r" = TRUE, "-m" = "Hello")
      expect_equivalent(args, output)
    })

    test_that('parsing "-armyourass" works',{
		#$ prog -armyourass
		#{"-a": true, "-r": true, "-m": "yourass"}

      args <- parse_args('-armyourass', options)
      output <- list("-a" = TRUE, "-r" = TRUE, "-m" = "yourass")
      expect_equivalent(args, output)
    })

    test_that('parsing "-a -r" works',{
		#$ prog -a -r
		#{"-a": true, "-r": true, "-m": null}

      args <- parse_args('-a -r', options)
      output <- list("-a" = TRUE, "-r" = TRUE, "-m" = NULL)
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [options]

Options: --version
         --verbose'
  # TODO parse options
  
    test_that('parsing "--version" works',{
		#$ prog --version
		#{"--version": true, "--verbose": false}

      args <- parse_args('--version', options)
      output <- list("--version" = TRUE, "--verbose" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "--verbose" works',{
		#$ prog --verbose
		#{"--version": false, "--verbose": true}

      args <- parse_args('--verbose', options)
      output <- list("--version" = FALSE, "--verbose" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "--ver" works',{
		#$ prog --ver
		#"user-error"

      args <- parse_args('--ver', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "--verb" works',{
		#$ prog --verb
		#{"--version": false, "--verbose": true}

      args <- parse_args('--verb', options)
      output <- list("--version" = FALSE, "--verbose" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [-a -r -m <msg>]

options:
 -a        Add
 -r        Remote
 -m <msg>  Message'
  # TODO parse options
  
    test_that('parsing "-armyourass" works',{
		#$ prog -armyourass
		#{"-a": true, "-r": true, "-m": "yourass"}

      args <- parse_args('-armyourass', options)
      output <- list("-a" = TRUE, "-r" = TRUE, "-m" = "yourass")
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [-armmsg]

options: -a        Add
         -r        Remote
         -m <msg>  Message'
  # TODO parse options
  
    test_that('parsing "-a -r -m Hello" works',{
		#$ prog -a -r -m Hello
		#{"-a": true, "-r": true, "-m": "Hello"}

      args <- parse_args('-a -r -m Hello', options)
      output <- list("-a" = TRUE, "-r" = TRUE, "-m" = "Hello")
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog -a -b

options:
 -a
 -b'
  # TODO parse options
  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#{"-a": true, "-b": true}

      args <- parse_args('-a -b', options)
      output <- list("-a" = TRUE, "-b" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}

      args <- parse_args('-b -a', options)
      output <- list("-a" = TRUE, "-b" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"

      args <- parse_args('-a', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      args <- parse_args('', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog (-a -b)

options: -a
         -b'
  # TODO parse options
  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#{"-a": true, "-b": true}

      args <- parse_args('-a -b', options)
      output <- list("-a" = TRUE, "-b" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}

      args <- parse_args('-b -a', options)
      output <- list("-a" = TRUE, "-b" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"

      args <- parse_args('-a', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      args <- parse_args('', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [-a] -b

options: -a
 -b'
  # TODO parse options
  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#{"-a": true, "-b": true}

      args <- parse_args('-a -b', options)
      output <- list("-a" = TRUE, "-b" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}

      args <- parse_args('-b -a', options)
      output <- list("-a" = TRUE, "-b" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"

      args <- parse_args('-a', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#{"-a": false, "-b": true}

      args <- parse_args('-b', options)
      output <- list("-a" = FALSE, "-b" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      args <- parse_args('', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [(-a -b)]

options: -a
         -b'
  # TODO parse options
  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#{"-a": true, "-b": true}

      args <- parse_args('-a -b', options)
      output <- list("-a" = TRUE, "-b" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}

      args <- parse_args('-b -a', options)
      output <- list("-a" = TRUE, "-b" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"

      args <- parse_args('-a', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#"user-error"

      args <- parse_args('-b', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-a": false, "-b": false}

      args <- parse_args('', options)
      output <- list("-a" = FALSE, "-b" = FALSE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog (-a|-b)

options: -a
         -b'
  # TODO parse options
  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#"user-error"

      args <- parse_args('-a -b', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      args <- parse_args('', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true, "-b": false}

      args <- parse_args('-a', options)
      output <- list("-a" = TRUE, "-b" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#{"-a": false, "-b": true}

      args <- parse_args('-b', options)
      output <- list("-a" = FALSE, "-b" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [ -a | -b ]

options: -a
         -b'
  # TODO parse options
  
    test_that('parsing "-a -b" works',{
		#$ prog -a -b
		#"user-error"

      args <- parse_args('-a -b', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-a": false, "-b": false}

      args <- parse_args('', options)
      output <- list("-a" = FALSE, "-b" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true, "-b": false}

      args <- parse_args('-a', options)
      output <- list("-a" = TRUE, "-b" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#{"-a": false, "-b": true}

      args <- parse_args('-b', options)
      output <- list("-a" = FALSE, "-b" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog <arg>'
  # TODO parse options
  
    test_that('parsing "10" works',{
		#$ prog 10
		#{"<arg>": "10"}

      args <- parse_args('10', options)
      output <- list("<arg>" = "10")
      expect_equivalent(args, output)
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#"user-error"

      args <- parse_args('10 20', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      args <- parse_args('', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [<arg>]'
  # TODO parse options
  
    test_that('parsing "10" works',{
		#$ prog 10
		#{"<arg>": "10"}

      args <- parse_args('10', options)
      output <- list("<arg>" = "10")
      expect_equivalent(args, output)
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#"user-error"

      args <- parse_args('10 20', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<arg>": null}

      args <- parse_args('', options)
      output <- list("<arg>" = NULL)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog <kind> <name> <type>'
  # TODO parse options
  
    test_that('parsing "10 20 40" works',{
		#$ prog 10 20 40
		#{"<kind>": "10", "<name>": "20", "<type>": "40"}

      args <- parse_args('10 20 40', options)
      output <- list("<kind>" = "10", "<name>" = "20", "<type>" = "40")
      expect_equivalent(args, output)
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#"user-error"

      args <- parse_args('10 20', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      args <- parse_args('', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog <kind> [<name> <type>]'
  # TODO parse options
  
    test_that('parsing "10 20 40" works',{
		#$ prog 10 20 40
		#{"<kind>": "10", "<name>": "20", "<type>": "40"}

      args <- parse_args('10 20 40', options)
      output <- list("<kind>" = "10", "<name>" = "20", "<type>" = "40")
      expect_equivalent(args, output)
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"<kind>": "10", "<name>": "20", "<type>": null}

      args <- parse_args('10 20', options)
      output <- list("<kind>" = "10", "<name>" = "20", "<type>" = NULL)
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      args <- parse_args('', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [<kind> | <name> <type>]'
  # TODO parse options
  
    test_that('parsing "10 20 40" works',{
		#$ prog 10 20 40
		#"user-error"

      args <- parse_args('10 20 40', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "20 40" works',{
		#$ prog 20 40
		#{"<kind>": null, "<name>": "20", "<type>": "40"}

      args <- parse_args('20 40', options)
      output <- list("<kind>" = NULL, "<name>" = "20", "<type>" = "40")
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<kind>": null, "<name>": null, "<type>": null}

      args <- parse_args('', options)
      output <- list("<kind>" = NULL, "<name>" = NULL, "<type>" = NULL)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog (<kind> --all | <name>)

options:
 --all'
  # TODO parse options
  
    test_that('parsing "10 --all" works',{
		#$ prog 10 --all
		#{"<kind>": "10", "--all": true, "<name>": null}

      args <- parse_args('10 --all', options)
      output <- list("<kind>" = "10", "--all" = TRUE, "<name>" = NULL)
      expect_equivalent(args, output)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"<kind>": null, "--all": false, "<name>": "10"}

      args <- parse_args('10', options)
      output <- list("<kind>" = NULL, "--all" = FALSE, "<name>" = "10")
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      args <- parse_args('', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [<name> <name>]'
  # TODO parse options
  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"<name>": ["10", "20"]}

      args <- parse_args('10 20', options)
      output <- list("<name>" = c("10", "20"))
      expect_equivalent(args, output)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"<name>": ["10"]}

      args <- parse_args('10', options)
      output <- list("<name>" = "10")
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<name>": []}

      args <- parse_args('', options)
      output <- list("<name>" = list())
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [(<name> <name>)]'
  # TODO parse options
  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"<name>": ["10", "20"]}

      args <- parse_args('10 20', options)
      output <- list("<name>" = c("10", "20"))
      expect_equivalent(args, output)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#"user-error"

      args <- parse_args('10', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<name>": []}

      args <- parse_args('', options)
      output <- list("<name>" = list())
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog NAME...'
  # TODO parse options
  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}

      args <- parse_args('10 20', options)
      output <- list(NAME = c("10", "20"))
      expect_equivalent(args, output)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}

      args <- parse_args('10', options)
      output <- list(NAME = "10")
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      args <- parse_args('', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [NAME]...'
  # TODO parse options
  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}

      args <- parse_args('10 20', options)
      output <- list(NAME = c("10", "20"))
      expect_equivalent(args, output)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}

      args <- parse_args('10', options)
      output <- list(NAME = "10")
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}

      args <- parse_args('', options)
      output <- list(NAME = list())
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [NAME...]'
  # TODO parse options
  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}

      args <- parse_args('10 20', options)
      output <- list(NAME = c("10", "20"))
      expect_equivalent(args, output)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}

      args <- parse_args('10', options)
      output <- list(NAME = "10")
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}

      args <- parse_args('', options)
      output <- list(NAME = list())
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [NAME [NAME ...]]'
  # TODO parse options
  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}

      args <- parse_args('10 20', options)
      output <- list(NAME = c("10", "20"))
      expect_equivalent(args, output)
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}

      args <- parse_args('10', options)
      output <- list(NAME = "10")
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}

      args <- parse_args('', options)
      output <- list(NAME = list())
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog (NAME | --foo NAME)

options: --foo'
  # TODO parse options
  
    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": "10", "--foo": false}

      args <- parse_args('10', options)
      output <- list(NAME = "10", "--foo" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "--foo 10" works',{
		#$ prog --foo 10
		#{"NAME": "10", "--foo": true}

      args <- parse_args('--foo 10', options)
      output <- list(NAME = "10", "--foo" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "--foo=10" works',{
		#$ prog --foo=10
		#"user-error"

      args <- parse_args('--foo=10', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog (NAME | --foo) [--bar | NAME]

options: --foo
options: --bar'
  # TODO parse options
  
    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"], "--foo": false, "--bar": false}

      args <- parse_args('10', options)
      output <- list(NAME = "10", "--foo" = FALSE, "--bar" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"], "--foo": false, "--bar": false}

      args <- parse_args('10 20', options)
      output <- list(NAME = c("10", "20"), "--foo" = FALSE, "--bar" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "--foo --bar" works',{
		#$ prog --foo --bar
		#{"NAME": [], "--foo": true, "--bar": true}

      args <- parse_args('--foo --bar', options)
      output <- list(NAME = list(), "--foo" = TRUE, "--bar" = TRUE)
      expect_equivalent(args, output)
    })
  
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
  # TODO parse options
  
    test_that('parsing "ship Guardian move 150 300 --speed=20" works',{
		#$ prog ship Guardian move 150 300 --speed=20
		#{"--drifting": false, "--help": false, "--moored": false, "--speed": "20", "--version": false, "<name>": ["Guardian"], "<x>": "150", "<y>": "300", "mine": false, "move": true, "new": false, "remove": false, "set": false, "ship": true, "shoot": false}

      args <- parse_args('ship Guardian move 150 300 --speed=20', options)
      output <- list("--drifting" = FALSE, "--help" = FALSE, "--moored" = FALSE, ,    "--speed" = "20", "--version" = FALSE, "<name>" = "Guardian", ,    "<x>" = "150", "<y>" = "300", mine = FALSE, move = TRUE, ,    new = FALSE, remove = FALSE, set = FALSE, ship = TRUE, shoot = FALSE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog --hello'
  # TODO parse options
  
    test_that('parsing "--hello" works',{
		#$ prog --hello
		#{"--hello": true}

      args <- parse_args('--hello', options)
      output <- list("--hello" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [--hello=<world>]'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"--hello": null}

      args <- parse_args('', options)
      output <- list("--hello" = NULL)
      expect_equivalent(args, output)
    })

    test_that('parsing "--hello wrld" works',{
		#$ prog --hello wrld
		#{"--hello": "wrld"}

      args <- parse_args('--hello wrld', options)
      output <- list("--hello" = "wrld")
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [-o]'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"-o": false}

      args <- parse_args('', options)
      output <- list("-o" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-o" works',{
		#$ prog -o
		#{"-o": true}

      args <- parse_args('-o', options)
      output <- list("-o" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [-opr]'
  # TODO parse options
  
    test_that('parsing "-op" works',{
		#$ prog -op
		#{"-o": true, "-p": true, "-r": false}

      args <- parse_args('-op', options)
      output <- list("-o" = TRUE, "-p" = TRUE, "-r" = FALSE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog --aabb | --aa'
  # TODO parse options
  
    test_that('parsing "--aa" works',{
		#$ prog --aa
		#{"--aabb": false, "--aa": true}

      args <- parse_args('--aa', options)
      output <- list("--aabb" = FALSE, "--aa" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog -v'
  # TODO parse options
  
    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": true}

      args <- parse_args('-v', options)
      output <- list("-v" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [-v -v]'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"-v": 0}

      args <- parse_args('', options)
      output <- list("-v" = 0)
      expect_equivalent(args, output)
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": 1}

      args <- parse_args('-v', options)
      output <- list("-v" = 1)
      expect_equivalent(args, output)
    })

    test_that('parsing "-vv" works',{
		#$ prog -vv
		#{"-v": 2}

      args <- parse_args('-vv', options)
      output <- list("-v" = 2)
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog -v ...'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      args <- parse_args('', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": 1}

      args <- parse_args('-v', options)
      output <- list("-v" = 1)
      expect_equivalent(args, output)
    })

    test_that('parsing "-vv" works',{
		#$ prog -vv
		#{"-v": 2}

      args <- parse_args('-vv', options)
      output <- list("-v" = 2)
      expect_equivalent(args, output)
    })

    test_that('parsing "-vvvvvv" works',{
		#$ prog -vvvvvv
		#{"-v": 6}

      args <- parse_args('-vvvvvv', options)
      output <- list("-v" = 6)
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [-v | -vv | -vvv]

This one is probably most readable user-friednly variant.'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"-v": 0}

      args <- parse_args('', options)
      output <- list("-v" = 0)
      expect_equivalent(args, output)
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": 1}

      args <- parse_args('-v', options)
      output <- list("-v" = 1)
      expect_equivalent(args, output)
    })

    test_that('parsing "-vv" works',{
		#$ prog -vv
		#{"-v": 2}

      args <- parse_args('-vv', options)
      output <- list("-v" = 2)
      expect_equivalent(args, output)
    })

    test_that('parsing "-vvvv" works',{
		#$ prog -vvvv
		#"user-error"

      args <- parse_args('-vvvv', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [--ver --ver]'
  # TODO parse options
  
    test_that('parsing "--ver --ver" works',{
		#$ prog --ver --ver
		#{"--ver": 2}

      args <- parse_args('--ver --ver', options)
      output <- list("--ver" = 2)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [go]'
  # TODO parse options
  
    test_that('parsing "go" works',{
		#$ prog go
		#{"go": true}

      args <- parse_args('go', options)
      output <- list(go = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [go go]'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"go": 0}

      args <- parse_args('', options)
      output <- list(go = 0)
      expect_equivalent(args, output)
    })

    test_that('parsing "go" works',{
		#$ prog go
		#{"go": 1}

      args <- parse_args('go', options)
      output <- list(go = 1)
      expect_equivalent(args, output)
    })

    test_that('parsing "go go" works',{
		#$ prog go go
		#{"go": 2}

      args <- parse_args('go go', options)
      output <- list(go = 2)
      expect_equivalent(args, output)
    })

    test_that('parsing "go go go" works',{
		#$ prog go go go
		#"user-error"

      args <- parse_args('go go go', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog go..."""
$ prog go go go go go
{"go": 5}


options: -a
         -b'
  # TODO parse options
  
    test_that('parsing "go go go go go" works',{
		#$ prog go go go go go
		#{"go": 5}

      args <- parse_args('go go go go go', options)
      output <- list(go = 5)
      expect_equivalent(args, output)
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true, "-b": false}

      args <- parse_args('-a', options)
      output <- list("-a" = TRUE, "-b" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-aa" works',{
		#$ prog -aa
		#"user-error"

      args <- parse_args('-aa', options)
      output <- "user-error"
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [options] A
Options:
    -q  Be quiet
    -v  Be verbose.'
  # TODO parse options
  
    test_that('parsing "arg" works',{
		#$ prog arg
		#{"A": "arg", "-v": false, "-q": false}

      args <- parse_args('arg', options)
      output <- list(A = "arg", "-v" = FALSE, "-q" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-v arg" works',{
		#$ prog -v arg
		#{"A": "arg", "-v": true, "-q": false}

      args <- parse_args('-v arg', options)
      output <- list(A = "arg", "-v" = TRUE, "-q" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-q arg" works',{
		#$ prog -q arg
		#{"A": "arg", "-v": false, "-q": true}

      args <- parse_args('-q arg', options)
      output <- list(A = "arg", "-v" = FALSE, "-q" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'NA'
  # TODO parse options
  
    test_that('parsing "-" works',{
		#$ prog -
		#{"-": true}

      args <- parse_args('-', options)
      output <- list("-" = TRUE)
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-": false}

      args <- parse_args('', options)
      output <- list("-" = FALSE)
      expect_equivalent(args, output)
    })
  
doc <- 
'NA'
  # TODO parse options
  
    test_that('parsing "a b" works',{
		#$ prog a b
		#{"NAME": ["a", "b"]}

      args <- parse_args('a b', options)
      output <- list(NAME = c("a", "b"))
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}

      args <- parse_args('', options)
      output <- list(NAME = list())
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [options]
options:
 -a        Add
 -m <msg>  Message'
  # TODO parse options
  
    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-m": null, "-a": true}

      args <- parse_args('-a', options)
      output <- list("-m" = NULL, "-a" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog --hello'
  # TODO parse options
  
    test_that('parsing "--hello" works',{
		#$ prog --hello
		#{"--hello": true}

      args <- parse_args('--hello', options)
      output <- list("--hello" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [--hello=<world>]'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"--hello": null}

      args <- parse_args('', options)
      output <- list("--hello" = NULL)
      expect_equivalent(args, output)
    })

    test_that('parsing "--hello wrld" works',{
		#$ prog --hello wrld
		#{"--hello": "wrld"}

      args <- parse_args('--hello wrld', options)
      output <- list("--hello" = "wrld")
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [-o]'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"-o": false}

      args <- parse_args('', options)
      output <- list("-o" = FALSE)
      expect_equivalent(args, output)
    })

    test_that('parsing "-o" works',{
		#$ prog -o
		#{"-o": true}

      args <- parse_args('-o', options)
      output <- list("-o" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [-opr]'
  # TODO parse options
  
    test_that('parsing "-op" works',{
		#$ prog -op
		#{"-o": true, "-p": true, "-r": false}

      args <- parse_args('-op', options)
      output <- list("-o" = TRUE, "-p" = TRUE, "-r" = FALSE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: git [-v | --verbose]'
  # TODO parse options
  
    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": true, "--verbose": false}

      args <- parse_args('-v', options)
      output <- list("-v" = TRUE, "--verbose" = FALSE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: git remote [-v | --verbose]'
  # TODO parse options
  
    test_that('parsing "remote -v" works',{
		#$ prog remote -v
		#{"remote": true, "-v": true, "--verbose": false}

      args <- parse_args('remote -v', options)
      output <- list(remote = TRUE, "-v" = TRUE, "--verbose" = FALSE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{}

      args <- parse_args('', options)
      output <- list()
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog
           prog <a> <b>'
  # TODO parse options
  
    test_that('parsing "1 2" works',{
		#$ prog 1 2
		#{"<a>": "1", "<b>": "2"}

      args <- parse_args('1 2', options)
      output <- list("<a>" = "1", "<b>" = "2")
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<a>": null, "<b>": null}

      args <- parse_args('', options)
      output <- list("<a>" = NULL, "<b>" = NULL)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog <a> <b>
           prog'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"<a>": null, "<b>": null}

      args <- parse_args('', options)
      output <- list("<a>" = NULL, "<b>" = NULL)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [--file=<f>]'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"--file": null}

      args <- parse_args('', options)
      output <- list("--file" = NULL)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [--file=<f>]

options: --file <a>'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"--file": null}

      args <- parse_args('', options)
      output <- list("--file" = NULL)
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [-a <host:port>]

Options: -a, --address <host:port>  TCP address [default: localhost:6283].'
  # TODO parse options
  
    test_that('parsing "" works',{
		#$ prog
		#{"--address": "localhost:6283"}

      args <- parse_args('', options)
      output <- list("--address" = "localhost:6283")
      expect_equivalent(args, output)
    })
  
doc <- 
'NA'
  # TODO parse options
  
    test_that('parsing "--long one" works',{
		#$ prog --long one
		#{"--long": ["one"]}

      args <- parse_args('--long one', options)
      output <- list("--long" = "one")
      expect_equivalent(args, output)
    })

    test_that('parsing "--long one --long two" works',{
		#$ prog --long one --long two
		#{"--long": ["one", "two"]}

      args <- parse_args('--long one --long two', options)
      output <- list("--long" = c("one", "two"))
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog (go <direction> --speed=<km/h>)...'
  # TODO parse options
  
    test_that('parsing "go left --speed=5  go right --speed=9" works',{
		#$ prog  go left --speed=5  go right --speed=9
		#{"go": 2, "<direction>": ["left", "right"], "--speed": ["5", "9"]}

      args <- parse_args('go left --speed=5  go right --speed=9', options)
      output <- list(go = 2, "<direction>" = c("left", "right"), "--speed" = c("5", ,"9"))
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [options] -a

options: -a'
  # TODO parse options
  
    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true}

      args <- parse_args('-a', options)
      output <- list("-a" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [-o <o>]...

options: -o <o>  [default: x]'
  # TODO parse options
  
    test_that('parsing "-o this -o that" works',{
		#$ prog -o this -o that
		#{"-o": ["this", "that"]}

      args <- parse_args('-o this -o that', options)
      output <- list("-o" = c("this", "that"))
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-o": ["x"]}

      args <- parse_args('', options)
      output <- list("-o" = "x")
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [-o <o>]...

options: -o <o>  [default: x y]'
  # TODO parse options
  
    test_that('parsing "-o this" works',{
		#$ prog -o this
		#{"-o": ["this"]}

      args <- parse_args('-o this', options)
      output <- list("-o" = "this")
      expect_equivalent(args, output)
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-o": ["x", "y"]}

      args <- parse_args('', options)
      output <- list("-o" = c("x", "y"))
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog -pPATH

options: -p PATH'
  # TODO parse options
  
    test_that('parsing "-pHOME" works',{
		#$ prog -pHOME
		#{"-p": "HOME"}

      args <- parse_args('-pHOME', options)
      output <- list("-p" = "HOME")
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: foo (--xx=x|--yy=y)...'
  # TODO parse options
  
    test_that('parsing "--xx=1 --yy=2" works',{
		#$ prog --xx=1 --yy=2
		#{"--xx": ["1"], "--yy": ["2"]}

      args <- parse_args('--xx=1 --yy=2', options)
      output <- list("--xx" = "1", "--yy" = "2")
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [<input file>]'
  # TODO parse options
  
    test_that('parsing "f.txt" works',{
		#$ prog f.txt
		#{"<input file>": "f.txt"}

      args <- parse_args('f.txt', options)
      output <- list("<input file>" = "f.txt")
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog [--input=<file name>]...'
  # TODO parse options
  
    test_that('parsing "--input a.txt --input=b.txt" works',{
		#$ prog --input a.txt --input=b.txt
		#{"--input": ["a.txt", "b.txt"]}

      args <- parse_args('--input a.txt --input=b.txt', options)
      output <- list("--input" = c("a.txt", "b.txt"))
      expect_equivalent(args, output)
    })
  
doc <- 
'usage: prog good [options]
           prog fail [options]

options: --loglevel=N'
  # TODO parse options
  
    test_that('parsing "fail --loglevel 5" works',{
		#$ prog fail --loglevel 5
		#{"--loglevel": "5", "fail": true, "good": false}

      args <- parse_args('fail --loglevel 5', options)
      output <- list("--loglevel" = "5", fail = TRUE, good = FALSE)
      expect_equivalent(args, output)
    })
  
doc <- 
'usage:prog --foo'
  # TODO parse options
  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true}

      args <- parse_args('--foo', options)
      output <- list("--foo" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'PROGRAM USAGE: prog --foo'
  # TODO parse options
  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true}

      args <- parse_args('--foo', options)
      output <- list("--foo" = TRUE)
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog --foo
           prog --bar
NOT PART OF SECTION'
  # TODO parse options
  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true, "--bar": false}

      args <- parse_args('--foo', options)
      output <- list("--foo" = TRUE, "--bar" = FALSE)
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage:
 prog --foo
 prog --bar

NOT PART OF SECTION'
  # TODO parse options
  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true, "--bar": false}

      args <- parse_args('--foo', options)
      output <- list("--foo" = TRUE, "--bar" = FALSE)
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage:
 prog --foo
 prog --bar
NOT PART OF SECTION'
  # TODO parse options
  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true, "--bar": false}

      args <- parse_args('--foo', options)
      output <- list("--foo" = TRUE, "--bar" = FALSE)
      expect_equivalent(args, output)
    })
  
doc <- 
'Usage: prog [options]

global options: --foo
local options: --baz
               --bar
other options:
 --egg
 --spam
-not-an-option-'
  # TODO parse options
    #
    # TEST GENERATION FAILED
    #
		#"""Usage: prog [options]
		#
		#global options: --foo
		#local options: --baz
		#               --bar
		#other options:
		# --egg
		# --spam
		#-not-an-option-
		#
		#"""
		#$ prog --baz --egg
		#{"--foo": false, "--baz": true, "--bar": false, "--egg": true, "--spam": false}
    test_that('failed', stop())
  

