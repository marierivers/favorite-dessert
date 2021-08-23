library(tidyverse)
library(rvest)

# read the webpage code
webpage <- read_html("https://www.eatthis.com/iconic-desserts-united-states/")

# Extract the desserts listing
dessert_elements<- html_elements(webpage, "h2")
dessert_listing <- dessert_elements %>% 
  html_text2() %>% # extracting the text associated with this type of elements of the webpage
  as_tibble() %>% # make it a data frame
  rename(dessert = value) %>% # better name for the column
  head(.,-3) %>% # 3 last ones were not desserts 
  rowid_to_column("rank") %>% # adding a column using the row number as proxy for the rank
  write_csv("data/iconic_desserts.csv") # save it as csv