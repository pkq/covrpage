[![Travis-CI Build Status](https://travis-ci.org/yonicd/covrpage.svg?branch=master)](https://travis-ci.org/yonicd/covrpage)
[![Coverage Status](https://img.shields.io/codecov/c/github/yonicd/covrpage/master.svg)](https://codecov.io/github/yonicd/covrpage?branch=master)

# covrpage

Healthy R packages use [testthat](https://github.com/r-lib/testthat) and [covr](https://github.com/r-lib/covr) to develop stable packages. 

This package extends the information that is communicated with the potential user with a cover page for the tests in the form of summary tables of results from covr and testthat. 

The output is created in the [tests](tests) subdirectory as a [README.md](tests/README.md) file so it will show up in Github browser page. 

## Package Installation

```r
# install.packages('remotes')

remotes::install_github('yonicd/covrpage')
```

## Usage

```r
# assuming you are in your package directory

covrpage::covrpage('.')

# create the covrpage and send diretly to remote repository

covrpage::covrpage('.', auto_push = TRUE)

# assuming you are not in your package directory

covrpage::covrpage('another_directory')

# peek at a R package on a Github Repository

covrpage::covrpage_snapshot(repo = 'user/repo')
```

## Using covrpage with Travis

covrpage can be used with Travis continuous integration

### use travis and coverage

Initialize the files needed to connect to `Travis` and `covr`.

```r
devtools::use_travis()
devtools::use_coverage()
```

### use_covrpage

Adds a subdirectory `.travis` to the package root directory with two files

  - push.sh : contains bash commands to run after successful package test.
  - travis_run.R : contains Rscript to run in push.sh.

The function defaults to the master branch and infers the user name from the repo value. For example the two calls are the same.

```r
covrpage::use_covrpage(repo = 'yonicd/covrpage')
covrpage::use_covrpage(repo = 'yonicd/covrpage',user='yonicd',branch='master')
```
Finally you will need encrypt a [Github Public Access Token](https://github.com/settings/tokens) (PAT) to allow Travis to push back to the remote repository. This is done using the Travis command line [function](https://docs.travis-ci.com/user/encryption-keys/).

The default of the function assumes you have defined a system environment variable `GITHUB_PAT` and will use it to define a [Travis environment variable](https://docs.travis-ci.com/user/environment-variables/) with the same name.

To define the Github PAT as a R environment variable

```r
Sys.setenv(GITHUB_PAT='PAT FROM GITHUB')
```

You can also use this function to define any other Travis environment variables and encrypt values to them. Run the function form the root package directory (where `.travis.yml` is located) and it will add the relevant lines to the yml for you.

The following calls are the same.

```r
covrpage::travis_encrypt()
covrpage::travis_encrypt(name='GITHUB_PAT',value=Sys.getenv('GITHUB_PAT'))
```

That's it!

Any questions/comments are always welcome in the [issues](https://github.com/yonicd/covrpage/issues) section.