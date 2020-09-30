# github-issues-r

Summary
This project is intended to get the issue data from a github repository.

The two documents in this project are:

github-issues-r.Rmd:
This is a markdown document that is demonstrates how to use the gh package to get issue data from a github repository. It also does some additional analysis.

github-issues-r.R:
This is an R script can be used to get data from github. The data that is gotten includes, the issue title, date created, issue creator, whether the is is open or closed, number of comments, date closed if applicable, and first label associated with the issue. 

To run the script the user will need to know owner and repo names, and possibly need an authentication key from github.


Problems:
The is still one problem associated with this project. When the data is read into a a dataframe and the labels are included, code error's because not all of the github issues have an associated label which and so R is trying to create a dataframe with different number of rows.


Resources:
Here is a link to the github issues for this project: https://github.nceas.ucsb.edu/SNAPP/snapp-wg-scicomp/issues/106

Here is a helpful source I used when learning about the gh package which is the basis for this work: https://github.com/jennybc/analyze-github-stuff-with-r
