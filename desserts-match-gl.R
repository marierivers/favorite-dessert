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

dessert_listing <- dessert_listing %>% 
  mutate(dessert = tolower(dessert))


favorite_desserts <- read_csv("favorite_desserts.csv") %>% 
  rename(dessert = Favorite_dessert) %>% 
  mutate(dessert = tolower(dessert))


<<<<<<< HEAD
is_iconic <- left_join(favorite_desserts, dessert_listing, by = "dessert") # marie changed semi-join to left join
=======
is_iconic <- right_join(favorite_desserts, dessert_listing, by = "dessert") #changed semi_join to right_join -- Grace 
>>>>>>> 08cc0ed294e31a03cfdf6582cfcb375b996613f2

# Returns the data frame with the names and desserts that match the iconic desserts.
is_iconic
