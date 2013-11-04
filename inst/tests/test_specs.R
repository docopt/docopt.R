
library(testthat)

#####################

context('doc01')
doc <- 
'Usage: prog'

  
    test_that('parsing "" works',{
		#$ prog
		#{}
      res <- docopt(doc, '')
      expect_equivalent(res, list())
    })

    test_that('parsing "--xxx" works',{
		#$ prog --xxx
		#"user-error"

      expect_error(docopt(doc, '--xxx'))
    })

#####################

context('doc02')
doc <- 
'Usage: prog [options]

Options: -a  All.'

  
    test_that('parsing "" works',{
		#$ prog
		#{"-a": false}
      res <- docopt(doc, '')
      expect_equivalent(res, list("-a" = FALSE))
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true}
      res <- docopt(doc, '-a')
      expect_equivalent(res, list("-a" = TRUE))
    })

    test_that('parsing "-x" works',{
		#$ prog -x
		#"user-error"

      expect_error(docopt(doc, '-x'))
    })

#####################

context('doc03')
doc <- 
'Usage: prog [options]

Options: --all  All.'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--all": false}
      res <- docopt(doc, '')
      expect_equivalent(res, list("--all" = FALSE))
    })

    test_that('parsing "--all" works',{
		#$ prog --all
		#{"--all": true}
      res <- docopt(doc, '--all')
      expect_equivalent(res, list("--all" = TRUE))
    })

    test_that('parsing "--xxx" works',{
		#$ prog --xxx
		#"user-error"

      expect_error(docopt(doc, '--xxx'))
    })

#####################

context('doc04')
doc <- 
'Usage: prog [options]

Options: -v, --verbose  Verbose.'

  
    test_that('parsing "--verbose" works',{
		#$ prog --verbose
		#{"--verbose": true}
      res <- docopt(doc, '--verbose')
      expect_equivalent(res, list("--verbose" = TRUE))
    })

    test_that('parsing "--ver" works',{
		#$ prog --ver
		#{"--verbose": true}
      res <- docopt(doc, '--ver')
      expect_equivalent(res, list("--verbose" = TRUE))
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"--verbose": true}
      res <- docopt(doc, '-v')
      expect_equivalent(res, list("--verbose" = TRUE))
    })

#####################

context('doc05')
doc <- 
'Usage: prog [options]

Options: -p PATH'

  
    test_that('parsing "-p home/" works',{
		#$ prog -p home/
		#{"-p": "home/"}
      res <- docopt(doc, '-p home/')
      expect_equivalent(res, list("-p" = "home/"))
    })

    test_that('parsing "-phome/" works',{
		#$ prog -phome/
		#{"-p": "home/"}
      res <- docopt(doc, '-phome/')
      expect_equivalent(res, list("-p" = "home/"))
    })

    test_that('parsing "-p" works',{
		#$ prog -p
		#"user-error"

      expect_error(docopt(doc, '-p'))
    })

#####################

context('doc06')
doc <- 
'Usage: prog [options]

Options: --path <path>'

  
    test_that('parsing "--path home/" works',{
		#$ prog --path home/
		#{"--path": "home/"}
      res <- docopt(doc, '--path home/')
      expect_equivalent(res, list("--path" = "home/"))
    })

    test_that('parsing "--path=home/" works',{
		#$ prog --path=home/
		#{"--path": "home/"}
      res <- docopt(doc, '--path=home/')
      expect_equivalent(res, list("--path" = "home/"))
    })

    test_that('parsing "--pa home/" works',{
		#$ prog --pa home/
		#{"--path": "home/"}
      res <- docopt(doc, '--pa home/')
      expect_equivalent(res, list("--path" = "home/"))
    })

    test_that('parsing "--pa=home/" works',{
		#$ prog --pa=home/
		#{"--path": "home/"}
      res <- docopt(doc, '--pa=home/')
      expect_equivalent(res, list("--path" = "home/"))
    })

    test_that('parsing "--path" works',{
		#$ prog --path
		#"user-error"

      expect_error(docopt(doc, '--path'))
    })

#####################

context('doc07')
doc <- 
'Usage: prog [options]

Options: -p PATH, --path=<path>  Path to files.'

  
    test_that('parsing "-proot" works',{
		#$ prog -proot
		#{"--path": "root"}
      res <- docopt(doc, '-proot')
      expect_equivalent(res, list("--path" = "root"))
    })

#####################

context('doc08')
doc <- 
'Usage: prog [options]

Options:    -p --path PATH  Path to files.'

  
    test_that('parsing "-p root" works',{
		#$ prog -p root
		#{"--path": "root"}
      res <- docopt(doc, '-p root')
      expect_equivalent(res, list("--path" = "root"))
    })

    test_that('parsing "--path root" works',{
		#$ prog --path root
		#{"--path": "root"}
      res <- docopt(doc, '--path root')
      expect_equivalent(res, list("--path" = "root"))
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
      res <- docopt(doc, '')
      expect_equivalent(res, list("-p" = "./"))
    })

    test_that('parsing "-phome" works',{
		#$ prog -phome
		#{"-p": "home"}
      res <- docopt(doc, '-phome')
      expect_equivalent(res, list("-p" = "home"))
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
      res <- docopt(doc, '')
      expect_equivalent(res, list("--path" = "/root"))
    })

    test_that('parsing "--path=home" works',{
		#$ prog --path=home
		#{"--path": "home"}
      res <- docopt(doc, '--path=home')
      expect_equivalent(res, list("--path" = "home"))
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
      res <- docopt(doc, '-a -r -m Hello')
      expect_equivalent(res, list("-a" = TRUE, "-r" = TRUE, "-m" = "Hello"))
    })

    test_that('parsing "-armyourass" works',{
		#$ prog -armyourass
		#{"-a": true, "-r": true, "-m": "yourass"}
      res <- docopt(doc, '-armyourass')
      expect_equivalent(res, list("-a" = TRUE, "-r" = TRUE, "-m" = "yourass"))
    })

    test_that('parsing "-a -r" works',{
		#$ prog -a -r
		#{"-a": true, "-r": true, "-m": null}
      res <- docopt(doc, '-a -r')
      expect_equivalent(res, list("-a" = TRUE, "-r" = TRUE, "-m" = NULL))
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
      res <- docopt(doc, '--version')
      expect_equivalent(res, list("--version" = TRUE, "--verbose" = FALSE))
    })

    test_that('parsing "--verbose" works',{
		#$ prog --verbose
		#{"--version": false, "--verbose": true}
      res <- docopt(doc, '--verbose')
      expect_equivalent(res, list("--version" = FALSE, "--verbose" = TRUE))
    })

    test_that('parsing "--ver" works',{
		#$ prog --ver
		#"user-error"

      expect_error(docopt(doc, '--ver'))
    })

    test_that('parsing "--verb" works',{
		#$ prog --verb
		#{"--version": false, "--verbose": true}
      res <- docopt(doc, '--verb')
      expect_equivalent(res, list("--version" = FALSE, "--verbose" = TRUE))
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
      res <- docopt(doc, '-armyourass')
      expect_equivalent(res, list("-a" = TRUE, "-r" = TRUE, "-m" = "yourass"))
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
      res <- docopt(doc, '-a -r -m Hello')
      expect_equivalent(res, list("-a" = TRUE, "-r" = TRUE, "-m" = "Hello"))
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
      res <- docopt(doc, '-a -b')
      expect_equivalent(res, list("-a" = TRUE, "-b" = TRUE))
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}
      res <- docopt(doc, '-b -a')
      expect_equivalent(res, list("-a" = TRUE, "-b" = TRUE))
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"

      expect_error(docopt(doc, '-a'))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      expect_error(docopt(doc, ''))
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
      res <- docopt(doc, '-a -b')
      expect_equivalent(res, list("-a" = TRUE, "-b" = TRUE))
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}
      res <- docopt(doc, '-b -a')
      expect_equivalent(res, list("-a" = TRUE, "-b" = TRUE))
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"

      expect_error(docopt(doc, '-a'))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      expect_error(docopt(doc, ''))
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
      res <- docopt(doc, '-a -b')
      expect_equivalent(res, list("-a" = TRUE, "-b" = TRUE))
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}
      res <- docopt(doc, '-b -a')
      expect_equivalent(res, list("-a" = TRUE, "-b" = TRUE))
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"

      expect_error(docopt(doc, '-a'))
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#{"-a": false, "-b": true}
      res <- docopt(doc, '-b')
      expect_equivalent(res, list("-a" = FALSE, "-b" = TRUE))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      expect_error(docopt(doc, ''))
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
      res <- docopt(doc, '-a -b')
      expect_equivalent(res, list("-a" = TRUE, "-b" = TRUE))
    })

    test_that('parsing "-b -a" works',{
		#$ prog -b -a
		#{"-a": true, "-b": true}
      res <- docopt(doc, '-b -a')
      expect_equivalent(res, list("-a" = TRUE, "-b" = TRUE))
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#"user-error"

      expect_error(docopt(doc, '-a'))
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#"user-error"

      expect_error(docopt(doc, '-b'))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-a": false, "-b": false}
      res <- docopt(doc, '')
      expect_equivalent(res, list("-a" = FALSE, "-b" = FALSE))
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

      expect_error(docopt(doc, '-a -b'))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      expect_error(docopt(doc, ''))
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true, "-b": false}
      res <- docopt(doc, '-a')
      expect_equivalent(res, list("-a" = TRUE, "-b" = FALSE))
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#{"-a": false, "-b": true}
      res <- docopt(doc, '-b')
      expect_equivalent(res, list("-a" = FALSE, "-b" = TRUE))
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

      expect_error(docopt(doc, '-a -b'))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-a": false, "-b": false}
      res <- docopt(doc, '')
      expect_equivalent(res, list("-a" = FALSE, "-b" = FALSE))
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true, "-b": false}
      res <- docopt(doc, '-a')
      expect_equivalent(res, list("-a" = TRUE, "-b" = FALSE))
    })

    test_that('parsing "-b" works',{
		#$ prog -b
		#{"-a": false, "-b": true}
      res <- docopt(doc, '-b')
      expect_equivalent(res, list("-a" = FALSE, "-b" = TRUE))
    })

#####################

context('doc21')
doc <- 
'usage: prog <arg>'

  
    test_that('parsing "10" works',{
		#$ prog 10
		#{"<arg>": "10"}
      res <- docopt(doc, '10')
      expect_equivalent(res, list("<arg>" = "10"))
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#"user-error"

      expect_error(docopt(doc, '10 20'))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      expect_error(docopt(doc, ''))
    })

#####################

context('doc22')
doc <- 
'usage: prog [<arg>]'

  
    test_that('parsing "10" works',{
		#$ prog 10
		#{"<arg>": "10"}
      res <- docopt(doc, '10')
      expect_equivalent(res, list("<arg>" = "10"))
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#"user-error"

      expect_error(docopt(doc, '10 20'))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<arg>": null}
      res <- docopt(doc, '')
      expect_equivalent(res, list("<arg>" = NULL))
    })

#####################

context('doc23')
doc <- 
'usage: prog <kind> <name> <type>'

  
    test_that('parsing "10 20 40" works',{
		#$ prog 10 20 40
		#{"<kind>": "10", "<name>": "20", "<type>": "40"}
      res <- docopt(doc, '10 20 40')
      expect_equivalent(res, list("<kind>" = "10", "<name>" = "20", "<type>" = "40"))
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#"user-error"

      expect_error(docopt(doc, '10 20'))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      expect_error(docopt(doc, ''))
    })

#####################

context('doc24')
doc <- 
'usage: prog <kind> [<name> <type>]'

  
    test_that('parsing "10 20 40" works',{
		#$ prog 10 20 40
		#{"<kind>": "10", "<name>": "20", "<type>": "40"}
      res <- docopt(doc, '10 20 40')
      expect_equivalent(res, list("<kind>" = "10", "<name>" = "20", "<type>" = "40"))
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"<kind>": "10", "<name>": "20", "<type>": null}
      res <- docopt(doc, '10 20')
      expect_equivalent(res, list("<kind>" = "10", "<name>" = "20", "<type>" = NULL))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      expect_error(docopt(doc, ''))
    })

#####################

context('doc25')
doc <- 
'usage: prog [<kind> | <name> <type>]'

  
    test_that('parsing "10 20 40" works',{
		#$ prog 10 20 40
		#"user-error"

      expect_error(docopt(doc, '10 20 40'))
    })

    test_that('parsing "20 40" works',{
		#$ prog 20 40
		#{"<kind>": null, "<name>": "20", "<type>": "40"}
      res <- docopt(doc, '20 40')
      expect_equivalent(res, list("<kind>" = NULL, "<name>" = "20", "<type>" = "40"))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<kind>": null, "<name>": null, "<type>": null}
      res <- docopt(doc, '')
      expect_equivalent(res, list("<kind>" = NULL, "<name>" = NULL, "<type>" = NULL))
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
      res <- docopt(doc, '10 --all')
      expect_equivalent(res, list("<kind>" = "10", "--all" = TRUE, "<name>" = NULL))
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"<kind>": null, "--all": false, "<name>": "10"}
      res <- docopt(doc, '10')
      expect_equivalent(res, list("<kind>" = NULL, "--all" = FALSE, "<name>" = "10"))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      expect_error(docopt(doc, ''))
    })

#####################

context('doc27')
doc <- 
'usage: prog [<name> <name>]'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"<name>": ["10", "20"]}
      res <- docopt(doc, '10 20')
      expect_equivalent(res, list("<name>" = c("10", "20")))
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"<name>": ["10"]}
      res <- docopt(doc, '10')
      expect_equivalent(res, list("<name>" = "10"))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<name>": []}
      res <- docopt(doc, '')
      expect_equivalent(res, list("<name>" = list()))
    })

#####################

context('doc28')
doc <- 
'usage: prog [(<name> <name>)]'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"<name>": ["10", "20"]}
      res <- docopt(doc, '10 20')
      expect_equivalent(res, list("<name>" = c("10", "20")))
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#"user-error"

      expect_error(docopt(doc, '10'))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<name>": []}
      res <- docopt(doc, '')
      expect_equivalent(res, list("<name>" = list()))
    })

#####################

context('doc29')
doc <- 
'usage: prog NAME...'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}
      res <- docopt(doc, '10 20')
      expect_equivalent(res, list(NAME = c("10", "20")))
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}
      res <- docopt(doc, '10')
      expect_equivalent(res, list(NAME = "10"))
    })

    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      expect_error(docopt(doc, ''))
    })

#####################

context('doc30')
doc <- 
'usage: prog [NAME]...'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}
      res <- docopt(doc, '10 20')
      expect_equivalent(res, list(NAME = c("10", "20")))
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}
      res <- docopt(doc, '10')
      expect_equivalent(res, list(NAME = "10"))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}
      res <- docopt(doc, '')
      expect_equivalent(res, list(NAME = list()))
    })

#####################

context('doc31')
doc <- 
'usage: prog [NAME...]'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}
      res <- docopt(doc, '10 20')
      expect_equivalent(res, list(NAME = c("10", "20")))
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}
      res <- docopt(doc, '10')
      expect_equivalent(res, list(NAME = "10"))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}
      res <- docopt(doc, '')
      expect_equivalent(res, list(NAME = list()))
    })

#####################

context('doc32')
doc <- 
'usage: prog [NAME [NAME ...]]'

  
    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"]}
      res <- docopt(doc, '10 20')
      expect_equivalent(res, list(NAME = c("10", "20")))
    })

    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": ["10"]}
      res <- docopt(doc, '10')
      expect_equivalent(res, list(NAME = "10"))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}
      res <- docopt(doc, '')
      expect_equivalent(res, list(NAME = list()))
    })

#####################

context('doc33')
doc <- 
'usage: prog (NAME | --foo NAME)

options: --foo'

  
    test_that('parsing "10" works',{
		#$ prog 10
		#{"NAME": "10", "--foo": false}
      res <- docopt(doc, '10')
      expect_equivalent(res, list(NAME = "10", "--foo" = FALSE))
    })

    test_that('parsing "--foo 10" works',{
		#$ prog --foo 10
		#{"NAME": "10", "--foo": true}
      res <- docopt(doc, '--foo 10')
      expect_equivalent(res, list(NAME = "10", "--foo" = TRUE))
    })

    test_that('parsing "--foo=10" works',{
		#$ prog --foo=10
		#"user-error"

      expect_error(docopt(doc, '--foo=10'))
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
      res <- docopt(doc, '10')
      expect_equivalent(res, list(NAME = "10", "--foo" = FALSE, "--bar" = FALSE))
    })

    test_that('parsing "10 20" works',{
		#$ prog 10 20
		#{"NAME": ["10", "20"], "--foo": false, "--bar": false}
      res <- docopt(doc, '10 20')
      expect_equivalent(res, list(NAME = c("10", "20"), "--foo" = FALSE, "--bar" = FALSE))
    })

    test_that('parsing "--foo --bar" works',{
		#$ prog --foo --bar
		#{"NAME": [], "--foo": true, "--bar": true}
      res <- docopt(doc, '--foo --bar')
      expect_equivalent(res, list(NAME = list(), "--foo" = TRUE, "--bar" = TRUE))
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
      res <- docopt(doc, 'ship Guardian move 150 300 --speed=20')
      expect_equivalent(res, list("--drifting" = FALSE, "--help" = FALSE, "--moored" = FALSE, ,    "--speed" = "20", "--version" = FALSE, "<name>" = "Guardian", ,    "<x>" = "150", "<y>" = "300", mine = FALSE, move = TRUE, ,    new = FALSE, remove = FALSE, set = FALSE, ship = TRUE, shoot = FALSE))
    })

#####################

context('doc36')
doc <- 
'usage: prog --hello'

  
    test_that('parsing "--hello" works',{
		#$ prog --hello
		#{"--hello": true}
      res <- docopt(doc, '--hello')
      expect_equivalent(res, list("--hello" = TRUE))
    })

#####################

context('doc37')
doc <- 
'usage: prog [--hello=<world>]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--hello": null}
      res <- docopt(doc, '')
      expect_equivalent(res, list("--hello" = NULL))
    })

    test_that('parsing "--hello wrld" works',{
		#$ prog --hello wrld
		#{"--hello": "wrld"}
      res <- docopt(doc, '--hello wrld')
      expect_equivalent(res, list("--hello" = "wrld"))
    })

#####################

context('doc38')
doc <- 
'usage: prog [-o]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"-o": false}
      res <- docopt(doc, '')
      expect_equivalent(res, list("-o" = FALSE))
    })

    test_that('parsing "-o" works',{
		#$ prog -o
		#{"-o": true}
      res <- docopt(doc, '-o')
      expect_equivalent(res, list("-o" = TRUE))
    })

#####################

context('doc39')
doc <- 
'usage: prog [-opr]'

  
    test_that('parsing "-op" works',{
		#$ prog -op
		#{"-o": true, "-p": true, "-r": false}
      res <- docopt(doc, '-op')
      expect_equivalent(res, list("-o" = TRUE, "-p" = TRUE, "-r" = FALSE))
    })

#####################

context('doc40')
doc <- 
'usage: prog --aabb | --aa'

  
    test_that('parsing "--aa" works',{
		#$ prog --aa
		#{"--aabb": false, "--aa": true}
      res <- docopt(doc, '--aa')
      expect_equivalent(res, list("--aabb" = FALSE, "--aa" = TRUE))
    })

#####################

context('doc41')
doc <- 
'Usage: prog -v'

  
    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": true}
      res <- docopt(doc, '-v')
      expect_equivalent(res, list("-v" = TRUE))
    })

#####################

context('doc42')
doc <- 
'Usage: prog [-v -v]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"-v": 0}
      res <- docopt(doc, '')
      expect_equivalent(res, list("-v" = 0))
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": 1}
      res <- docopt(doc, '-v')
      expect_equivalent(res, list("-v" = 1))
    })

    test_that('parsing "-vv" works',{
		#$ prog -vv
		#{"-v": 2}
      res <- docopt(doc, '-vv')
      expect_equivalent(res, list("-v" = 2))
    })

#####################

context('doc43')
doc <- 
'Usage: prog -v ...'

  
    test_that('parsing "" works',{
		#$ prog
		#"user-error"

      expect_error(docopt(doc, ''))
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": 1}
      res <- docopt(doc, '-v')
      expect_equivalent(res, list("-v" = 1))
    })

    test_that('parsing "-vv" works',{
		#$ prog -vv
		#{"-v": 2}
      res <- docopt(doc, '-vv')
      expect_equivalent(res, list("-v" = 2))
    })

    test_that('parsing "-vvvvvv" works',{
		#$ prog -vvvvvv
		#{"-v": 6}
      res <- docopt(doc, '-vvvvvv')
      expect_equivalent(res, list("-v" = 6))
    })

#####################

context('doc44')
doc <- 
'Usage: prog [-v | -vv | -vvv]

This one is probably most readable user-friednly variant.'

  
    test_that('parsing "" works',{
		#$ prog
		#{"-v": 0}
      res <- docopt(doc, '')
      expect_equivalent(res, list("-v" = 0))
    })

    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": 1}
      res <- docopt(doc, '-v')
      expect_equivalent(res, list("-v" = 1))
    })

    test_that('parsing "-vv" works',{
		#$ prog -vv
		#{"-v": 2}
      res <- docopt(doc, '-vv')
      expect_equivalent(res, list("-v" = 2))
    })

    test_that('parsing "-vvvv" works',{
		#$ prog -vvvv
		#"user-error"

      expect_error(docopt(doc, '-vvvv'))
    })

#####################

context('doc45')
doc <- 
'usage: prog [--ver --ver]'

  
    test_that('parsing "--ver --ver" works',{
		#$ prog --ver --ver
		#{"--ver": 2}
      res <- docopt(doc, '--ver --ver')
      expect_equivalent(res, list("--ver" = 2))
    })

#####################

context('doc46')
doc <- 
'usage: prog [go]'

  
    test_that('parsing "go" works',{
		#$ prog go
		#{"go": true}
      res <- docopt(doc, 'go')
      expect_equivalent(res, list(go = TRUE))
    })

#####################

context('doc47')
doc <- 
'usage: prog [go go]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"go": 0}
      res <- docopt(doc, '')
      expect_equivalent(res, list(go = 0))
    })

    test_that('parsing "go" works',{
		#$ prog go
		#{"go": 1}
      res <- docopt(doc, 'go')
      expect_equivalent(res, list(go = 1))
    })

    test_that('parsing "go go" works',{
		#$ prog go go
		#{"go": 2}
      res <- docopt(doc, 'go go')
      expect_equivalent(res, list(go = 2))
    })

    test_that('parsing "go go go" works',{
		#$ prog go go go
		#"user-error"

      expect_error(docopt(doc, 'go go go'))
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
      res <- docopt(doc, 'go go go go go')
      expect_equivalent(res, list(go = 5))
    })

    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true, "-b": false}
      res <- docopt(doc, '-a')
      expect_equivalent(res, list("-a" = TRUE, "-b" = FALSE))
    })

    test_that('parsing "-aa" works',{
		#$ prog -aa
		#"user-error"

      expect_error(docopt(doc, '-aa'))
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
      res <- docopt(doc, 'arg')
      expect_equivalent(res, list(A = "arg", "-v" = FALSE, "-q" = FALSE))
    })

    test_that('parsing "-v arg" works',{
		#$ prog -v arg
		#{"A": "arg", "-v": true, "-q": false}
      res <- docopt(doc, '-v arg')
      expect_equivalent(res, list(A = "arg", "-v" = TRUE, "-q" = FALSE))
    })

    test_that('parsing "-q arg" works',{
		#$ prog -q arg
		#{"A": "arg", "-v": false, "-q": true}
      res <- docopt(doc, '-q arg')
      expect_equivalent(res, list(A = "arg", "-v" = FALSE, "-q" = TRUE))
    })

#####################

context('doc50')
doc <- 
'NA'

  
    test_that('parsing "-" works',{
		#$ prog -
		#{"-": true}
      res <- docopt(doc, '-')
      expect_equivalent(res, list("-" = TRUE))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-": false}
      res <- docopt(doc, '')
      expect_equivalent(res, list("-" = FALSE))
    })

#####################

context('doc51')
doc <- 
'NA'

  
    test_that('parsing "a b" works',{
		#$ prog a b
		#{"NAME": ["a", "b"]}
      res <- docopt(doc, 'a b')
      expect_equivalent(res, list(NAME = c("a", "b")))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"NAME": []}
      res <- docopt(doc, '')
      expect_equivalent(res, list(NAME = list()))
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
      res <- docopt(doc, '-a')
      expect_equivalent(res, list("-m" = NULL, "-a" = TRUE))
    })

#####################

context('doc53')
doc <- 
'usage: prog --hello'

  
    test_that('parsing "--hello" works',{
		#$ prog --hello
		#{"--hello": true}
      res <- docopt(doc, '--hello')
      expect_equivalent(res, list("--hello" = TRUE))
    })

#####################

context('doc54')
doc <- 
'usage: prog [--hello=<world>]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--hello": null}
      res <- docopt(doc, '')
      expect_equivalent(res, list("--hello" = NULL))
    })

    test_that('parsing "--hello wrld" works',{
		#$ prog --hello wrld
		#{"--hello": "wrld"}
      res <- docopt(doc, '--hello wrld')
      expect_equivalent(res, list("--hello" = "wrld"))
    })

#####################

context('doc55')
doc <- 
'usage: prog [-o]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"-o": false}
      res <- docopt(doc, '')
      expect_equivalent(res, list("-o" = FALSE))
    })

    test_that('parsing "-o" works',{
		#$ prog -o
		#{"-o": true}
      res <- docopt(doc, '-o')
      expect_equivalent(res, list("-o" = TRUE))
    })

#####################

context('doc56')
doc <- 
'usage: prog [-opr]'

  
    test_that('parsing "-op" works',{
		#$ prog -op
		#{"-o": true, "-p": true, "-r": false}
      res <- docopt(doc, '-op')
      expect_equivalent(res, list("-o" = TRUE, "-p" = TRUE, "-r" = FALSE))
    })

#####################

context('doc57')
doc <- 
'usage: git [-v | --verbose]'

  
    test_that('parsing "-v" works',{
		#$ prog -v
		#{"-v": true, "--verbose": false}
      res <- docopt(doc, '-v')
      expect_equivalent(res, list("-v" = TRUE, "--verbose" = FALSE))
    })

#####################

context('doc58')
doc <- 
'usage: git remote [-v | --verbose]'

  
    test_that('parsing "remote -v" works',{
		#$ prog remote -v
		#{"remote": true, "-v": true, "--verbose": false}
      res <- docopt(doc, 'remote -v')
      expect_equivalent(res, list(remote = TRUE, "-v" = TRUE, "--verbose" = FALSE))
    })

#####################

context('doc59')
doc <- 
'usage: prog'

  
    test_that('parsing "" works',{
		#$ prog
		#{}
      res <- docopt(doc, '')
      expect_equivalent(res, list())
    })

#####################

context('doc60')
doc <- 
'usage: prog
           prog <a> <b>'

  
    test_that('parsing "1 2" works',{
		#$ prog 1 2
		#{"<a>": "1", "<b>": "2"}
      res <- docopt(doc, '1 2')
      expect_equivalent(res, list("<a>" = "1", "<b>" = "2"))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"<a>": null, "<b>": null}
      res <- docopt(doc, '')
      expect_equivalent(res, list("<a>" = NULL, "<b>" = NULL))
    })

#####################

context('doc61')
doc <- 
'usage: prog <a> <b>
           prog'

  
    test_that('parsing "" works',{
		#$ prog
		#{"<a>": null, "<b>": null}
      res <- docopt(doc, '')
      expect_equivalent(res, list("<a>" = NULL, "<b>" = NULL))
    })

#####################

context('doc62')
doc <- 
'usage: prog [--file=<f>]'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--file": null}
      res <- docopt(doc, '')
      expect_equivalent(res, list("--file" = NULL))
    })

#####################

context('doc63')
doc <- 
'usage: prog [--file=<f>]

options: --file <a>'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--file": null}
      res <- docopt(doc, '')
      expect_equivalent(res, list("--file" = NULL))
    })

#####################

context('doc64')
doc <- 
'Usage: prog [-a <host:port>]

Options: -a, --address <host:port>  TCP address [default: localhost:6283].'

  
    test_that('parsing "" works',{
		#$ prog
		#{"--address": "localhost:6283"}
      res <- docopt(doc, '')
      expect_equivalent(res, list("--address" = "localhost:6283"))
    })

#####################

context('doc65')
doc <- 
'NA'

  
    test_that('parsing "--long one" works',{
		#$ prog --long one
		#{"--long": ["one"]}
      res <- docopt(doc, '--long one')
      expect_equivalent(res, list("--long" = "one"))
    })

    test_that('parsing "--long one --long two" works',{
		#$ prog --long one --long two
		#{"--long": ["one", "two"]}
      res <- docopt(doc, '--long one --long two')
      expect_equivalent(res, list("--long" = c("one", "two")))
    })

#####################

context('doc66')
doc <- 
'usage: prog (go <direction> --speed=<km/h>)...'

  
    test_that('parsing "go left --speed=5  go right --speed=9" works',{
		#$ prog  go left --speed=5  go right --speed=9
		#{"go": 2, "<direction>": ["left", "right"], "--speed": ["5", "9"]}
      res <- docopt(doc, 'go left --speed=5  go right --speed=9')
      expect_equivalent(res, list(go = 2, "<direction>" = c("left", "right"), "--speed" = c("5", ,"9")))
    })

#####################

context('doc67')
doc <- 
'usage: prog [options] -a

options: -a'

  
    test_that('parsing "-a" works',{
		#$ prog -a
		#{"-a": true}
      res <- docopt(doc, '-a')
      expect_equivalent(res, list("-a" = TRUE))
    })

#####################

context('doc68')
doc <- 
'usage: prog [-o <o>]...

options: -o <o>  [default: x]'

  
    test_that('parsing "-o this -o that" works',{
		#$ prog -o this -o that
		#{"-o": ["this", "that"]}
      res <- docopt(doc, '-o this -o that')
      expect_equivalent(res, list("-o" = c("this", "that")))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-o": ["x"]}
      res <- docopt(doc, '')
      expect_equivalent(res, list("-o" = "x"))
    })

#####################

context('doc69')
doc <- 
'usage: prog [-o <o>]...

options: -o <o>  [default: x y]'

  
    test_that('parsing "-o this" works',{
		#$ prog -o this
		#{"-o": ["this"]}
      res <- docopt(doc, '-o this')
      expect_equivalent(res, list("-o" = "this"))
    })

    test_that('parsing "" works',{
		#$ prog
		#{"-o": ["x", "y"]}
      res <- docopt(doc, '')
      expect_equivalent(res, list("-o" = c("x", "y")))
    })

#####################

context('doc70')
doc <- 
'usage: prog -pPATH

options: -p PATH'

  
    test_that('parsing "-pHOME" works',{
		#$ prog -pHOME
		#{"-p": "HOME"}
      res <- docopt(doc, '-pHOME')
      expect_equivalent(res, list("-p" = "HOME"))
    })

#####################

context('doc71')
doc <- 
'Usage: foo (--xx=x|--yy=y)...'

  
    test_that('parsing "--xx=1 --yy=2" works',{
		#$ prog --xx=1 --yy=2
		#{"--xx": ["1"], "--yy": ["2"]}
      res <- docopt(doc, '--xx=1 --yy=2')
      expect_equivalent(res, list("--xx" = "1", "--yy" = "2"))
    })

#####################

context('doc72')
doc <- 
'usage: prog [<input file>]'

  
    test_that('parsing "f.txt" works',{
		#$ prog f.txt
		#{"<input file>": "f.txt"}
      res <- docopt(doc, 'f.txt')
      expect_equivalent(res, list("<input file>" = "f.txt"))
    })

#####################

context('doc73')
doc <- 
'usage: prog [--input=<file name>]...'

  
    test_that('parsing "--input a.txt --input=b.txt" works',{
		#$ prog --input a.txt --input=b.txt
		#{"--input": ["a.txt", "b.txt"]}
      res <- docopt(doc, '--input a.txt --input=b.txt')
      expect_equivalent(res, list("--input" = c("a.txt", "b.txt")))
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
      res <- docopt(doc, 'fail --loglevel 5')
      expect_equivalent(res, list("--loglevel" = "5", fail = TRUE, good = FALSE))
    })

#####################

context('doc75')
doc <- 
'usage:prog --foo'

  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true}
      res <- docopt(doc, '--foo')
      expect_equivalent(res, list("--foo" = TRUE))
    })

#####################

context('doc76')
doc <- 
'PROGRAM USAGE: prog --foo'

  
    test_that('parsing "--foo" works',{
		#$ prog --foo
		#{"--foo": true}
      res <- docopt(doc, '--foo')
      expect_equivalent(res, list("--foo" = TRUE))
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
      res <- docopt(doc, '--foo')
      expect_equivalent(res, list("--foo" = TRUE, "--bar" = FALSE))
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
      res <- docopt(doc, '--foo')
      expect_equivalent(res, list("--foo" = TRUE, "--bar" = FALSE))
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
      res <- docopt(doc, '--foo')
      expect_equivalent(res, list("--foo" = TRUE, "--bar" = FALSE))
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
      res <- docopt(doc, '--baz --egg')
      expect_equivalent(res, list("--foo" = FALSE, "--baz" = TRUE, "--bar" = FALSE, "--egg" = TRUE, ,    "--spam" = FALSE))
    })


