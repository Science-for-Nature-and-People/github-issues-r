#' Github Issues
#' 
#' 
#'
github_issues <- function(Owner, Repo){
  gh("/repo/:owner/:repo/issues", owner = "Owner", repo = "Repo") %>%
    {
      data.frame(number = map_int(., "number"), #Calls the issue number
                 id = map_int(., "id"), #Calls the issue id
                 title = map_chr(., "title"), #Calls the title of the issue
                 state = map_chr(., "state"), #States if the issue is open or closed
                 user = map_chr(., c("user", "login")), #The user who created the issue
                 created_at = map_chr(., "created_at") %>% as.Date() #The date the issue was created
      )
    }
  
}