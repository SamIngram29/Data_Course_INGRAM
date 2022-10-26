library(tidyverse)
library(janitor)
#what is a list?

class(1:10)
c(1,2,3,"a")[3]

list("a",2, TRUE,c(1,2,3))

x <- list(sentences=sentences,
          letters=letters,
          numbers=1:10,
          iris=iris,
          whatever=TRUE) #sentences=sentences (names it then = assigns it)
x$numbers


map(x,1) %>% class
map(x,1) %>% map_chr(1)  #map the first thing in the list.

sentences %>% 
  map()

str_split(sentences," ") %>%     #splits up the string to 
  map_chr(1) %>% 
  table() %>% 
  as.data.frame() %>% 
  arrange(desc(Freq))

          #helps to work with lists!!!! Automattically works with tidyverse loaded.
  
files <- list.files("./Data/data-shell/names",   #a lot of files that have names
          recursive=TRUE,
          full.names=TRUE,
          pattern= "adjustment")

read_clean <- function(x){read_csv(x) %>% clean_names()} #automatically reads the CSV and makes it clean all at once!
files

dfs <- map(files,read_clean)     #making all the files into one data frame.

dfs[[1]]
map(dfs,names)
map(dfs,dim)

df <- reduce(dfs,full_join)   #makes all the files into a data frame!!
df %>% head()

read_clean   #without () returns the whole code for that function in the console.


x %>% names
x %>% length
x[[1]][720]
x[[1]][800] #not 800 things.. hahah
x[[4]][1,1]  #looking into the list x at the first vector and the 1st row 1st column.
#[[]]  gives the items the list knows about.

sentences %>% 
  str_split(" ") %>% 
  map(table) %>% 
  map_dbl(max)     #dbl returns as a numeric vector

#making a function to remove commas and periods
clean_up_commas_etc <- function(x){
  x %>% str_remove(",") %>% 
    str_remove("\\.") #to make it a period. can't be just "."
}

#applying the new function
sentences %>% 
  str_split(" ") %>% 
  map(str_to_lower) %>% 
  map(clean_up_commas_etc) %>% 
  unlist() %>% #unlists it.
  table() %>%  #counts how many times something show up.
  as.data.frame() %>% 
  arrange(desc(Freq)) %>% 
  head()
