make_sh <- function(repo,user=dirname(repo),branch='master'){

  sprintf('#!/bin/bash
  
  set -x
  if [ $TRAVIS_BRANCH == "%s" ] ; then
  
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
  
  git checkout -b test
  
  Rscript .travis/travis_run.R
  
  git add .
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER [skip ci]"
  
  git remote add deploy https://%s:${GITHUB_PAT}@github.com/%s.git
  git push -f deploy test -v
  
  else
  echo "Not deploying, since this branch is not %s."
  fi',branch,user,repo,branch)
  
}

#' @export
use_covrpage <- function(path='.travis',repo,...){
  
  if(dir.exists(path)){
    dir.create(path,showWarnings = FALSE,recursive = TRUE)
    message('.travis subdirectory created')
  }
    
  cat(make_sh(repo, ...),file = file.path(path,'push.sh'))
  
  file.copy(system.file('.travis/travis_run.R',package = 'covrpage'),path)
  
  message('push.sh and travis_run.R copied to .travis subdirectory')
  
  message("copy 'bash .travis/push.sh' to .travis.yml in 'after_success' block")
  
}