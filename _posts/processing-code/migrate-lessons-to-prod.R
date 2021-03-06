
########## MOVE FILES TO DEV AND THEN PRODUCTION SERVER ############ 

# This code is tailored to moving posts from the data-lessons repos to the 
# dev or prod server. it does the following

# 1. it moves all RMD files to _posts/ whatever the sub dir is in the repo
# 2. it moves all code files to the code dir
# 3. it moves all md files from the data-lessons posts dir to the same location in the prod repo
# NOTE -- i should edit this to be more precise in what directories it copies over!!
# lists of paths may be important.

# Created by: Leah A. Wasser
# Last Modified - 10 Mar 2016  - 
# Last additions -- cleanup of all directories before copying new ones over.
# cleanup is specific to EACH REPOSITORY.

###################################################################### 

# Which repo do you want to move
# 1 = vector, 2 = dc raster, 3 = dc time series

# adjust the variable below to define what repo you want to move
repo.name = 1

# DEFINE PATH to Move Files To
prodPath <-"~/Documents/GitHub/NEON-Data-Skills-Development/"
#prodPath <-"~/Documents/GitHub/NEON-Data-Skills/"

####################### Edit Below If Paths Change ############################

##### Define Repo paths
repo.path <- c("~/Documents/GitHub/NEON-R-Spatial-Vector/",
           "~/Documents/GitHub/NEON-R-Spatial-Raster/",
           "~/Documents/GitHub/NEON-R-Tabular-Time-Series/")

##### Define repo subdir names
# note, we could do a "contains" statmtne to find a dir with "vector" but i think
# that is too risky. i'd rather be precise and hard code paths in this instance.
repo.subdir <- c("/dc-spatial-vector",
                "/dc-spatial-raster",
                "/dc-tabular-time-series")

# Define Base Path
basePath <- repo.path[repo.name]
repoSubDir <- repo.subdir[repo.name]



############################## Begin Move Files #########################

# get subdir in _posts
# NOTE: this assumes there is only one set of posts in the post directory that is 
# relevant
# postSubDir <- list.dirs(paste0(basePath,"_posts"), recursive=TRUE, full.names = FALSE)

# grab the full path of the subdir in the repo - this is not operational code but
# it works as a hack for now
#length(postSubDir)
#subDirPath <- postSubDir[length(postSubDir)]

########### PROCEED WITH CAUTION ##########
########### Clean out directories (to avoid duplication of content) ###########
if (dir.exists(paste0(prodPath,"_posts/R", repoSubDir))){
  # copy image directory over
  print("It Exists!")
}

# clean out production posts - DOESN"T WORK
unlink(paste0(prodPath,"_posts/R", repoSubDir), recursive = TRUE)

# clean out production rfigs 
unlink(paste0(prodPath,"images/rfigs", repoSubDir), recursive = TRUE)
# clean up images dir 
unlink(paste0(prodPath,"images", repoSubDir), recursive = TRUE)
# clean up code dir
unlink(paste0(prodPath,"code/R", repoSubDir), recursive = TRUE)


########################## COPY Code files, md and images to prod #############
# i probably could create some sort of function to make this code simpler 

# copy _posts file to the rmd directory on git
file.copy(paste0(basePath,"_posts/R", repoSubDir), 
          (paste0(prodPath,"_posts/R")),
           recursive=TRUE)

# copy knitr produced images dir same dir location on prod
file.copy(paste0(basePath,"images/rfigs", repoSubDir), 
          (paste0(prodPath,"images/rfigs")), 
           recursive=TRUE)
          
# copy other images produced for repo over - Works
file.copy(paste0(basePath,"images", repoSubDir), 
          (paste0(prodPath,"images")), 
          recursive=TRUE)

# copy R code over to prod
file.copy(paste0(basePath,"code/R", repoSubDir), 
          paste0(prodPath,"code/R"), 
          recursive=TRUE)


# grab all rmd files and copy to posts/R/ directory  
rmd.files <- list.files(basePath, pattern="*.Rmd", full.names = TRUE )
file.copy(rmd.files, paste0(prodPath, "_posts/R", repoSubDir))
