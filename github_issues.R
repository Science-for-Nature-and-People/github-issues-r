#' Github Issues
#' 
#'@param Owner The owner of the repo
#'@param Repo The name of the repo 
#'
#'
#'
#'  Inputs need to b in quotes
#'@example github_issues("brunj7", "nceas-r-packages")

library(gh)
library(purrr)
library(tidyverse)

github_issues = function(owner, repo, token = NULL, url = NULL, state = "all", limit = "all"){
  
  owner <- owner
  repo <- repo
  
  map_chr_hack <- function(.x, .f, ...) {
    map(.x, .f, ...) %>%
      map_if(is.null, ~ NA_character_) %>%
      flatten_chr()
  }
  
  
  results = gh("/repos/:owner/:repo/issues", owner = owner, repo = repo, .token = token, .api_url = url, state = state, .limit = limit) %>%
    {
      data.frame(number = map_int(., "number"), #Calls the issue number
                 id = map_int(., "id"), #Calls the issue id
                 title = map_chr(., "title"), #Calls the title of the issue
                 state = map_chr(., "state"), #States if the issue is open or closed
                 user = map_chr(., c("user", "login")), #The user who created the issue
                 created_at = map_chr(., "created_at") %>% as.Date(), #The date the issue was created
                 closed_at = map_chr_hack(., "closed_at") %>% as.Date(), #The date the issued was closed
                 n_comments = map_int(., "comments") #This is the number of comments in an issue 
      )
    }
  
  return(results)
}