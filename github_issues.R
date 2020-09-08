#' Github Issues
#' 
#'@param owner The owner of the repo
#'@param repo The name of the repo
#'@param token The user's personal access token for github. This is needed if accessing a private repo, or a github enterprise repo. If this is set in the user's .Renviron it can be left as NULL 
#'@param url The url to asccess a github enterprise repo
#'@param state Decides what type of issue to pull: "open", "closed", "all"
#'@param limit How many issues are pulled
#'
#'@note Inputs need to be in quotes
#'
#'@references Here is a link on generating a token from github: https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token
#'
#'@example github_issues("brunj7", "nceas-r-packages")

library(gh)
library(purrr)
library(tidyverse)

github_issues = function(owner, repo, token = NULL, url = NULL, state = "all", limit = "all"){
  
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
                 n_comments = map_int(., "comments"), #This is the number of comments in an issue 
                 labels = map_dfr(., ~.$"labels"[1]) #this gets all of the label information for an issue
      )
    }
  
  return(results)
}