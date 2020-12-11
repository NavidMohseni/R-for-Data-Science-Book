library(tidyverse)
#Wrangle



#Tibbles
as_tibble()
tibble(x = 1:17,
       y = 23,
       z = x -y^2)
tibble('2000' = 1:25,
       ':D' = -1:-25)

#Use Tibble instead of Data frame

#Extraction with $ , [[]]
#With pipe you should use with . (dot)
df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

df %>% .$x
df %>% .[["x"]]


#Exercise 10
#10.1
as_tibble(mtcars)
is_tibble(mtcars)

#10.4
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
annoying
annoying[["1"]]
annoying[[1]]
annoying$"1"

plot(annoying[[1]],annoying[[2]])
ggplot(annoying, aes(x = `1`, y = `2`)) + geom_point()#You HAVE TO USE `` instead of ""
ggplot(annoying, aes(x = "1", y = "2")) + geom_point()

annoying <- annoying %>% mutate(`3` = `2`/`1`)
names(annoying) <- c("one", "two", "three")
annoying <- rename(annoying, one = `1`, two = `2`, three = `3`)
annoying

#10.5
?enframe
#The function tibble::enframe() converts named vectors to a data frame with names and values
enframe(c(a = 5, b = 7))

#10.6
?tibble



#Data Import

#read_csv2 reads semicolon seprated files (Specifically when in persian we use "," for decimal).
#read_delim() reads in files with any delimiter.
#read_tsv for tab seprated files
read_csv(file, skip = n, comment = "#") #skip the n lines and hashtags
read_csv(file, col_names = FALSE) #when data might not have column names
read_csv(file, col_names = c("A", "B", "C") #when you want to write your own column names
read_csv(file, na = "99") #the code of na values



#Exercise 11.2.2
#11.2.1
read_delim(file, delim = "|")
#11.2.2
union(names(formals(read_csv)), names(formals(read_tsv)))
#trim_ws trims whitespace before and after cells before parsing
#locale is important for determining things like the encoding and whether "." or "," is used as a decimal mark.

#11.2.4
X <- "x,y\n1,'a,b'"
read_csv(X, quote = "'") #use quote for strings




#Parsing a vector
#parse_* functions 
parse_integer(c("1","231","."), na = ".")
parse_factor()
parse_logical(c("TRUE", "FALSE", "NA"))

#in persian we can specify decimal mark with locale
parse_double("1,23", locale = locale(decimal_mark = ","))

#parse_number is useful we have marks like $ or % with the numbers
parse_number("20%")
parse_number("$123,456,789")
#grouping_mark used for large numbers
parse_number("123,456,789 toman", locale = locale(grouping_mark = ",")) 

charToRaw("Navid")
parse_datetime("20101010")
parse_time("2:10 am")
parse_date("2010-10-01")
parse_date("01/02/15", "%y/%m/%d")

date_names_lang("fa") #the persian is awful
parse_date("1 janvier 2015", "%d %B %Y", locale = locale("fr"))


#Exercise 11.3.5
#1.
vignette("locales")
locale("fa")

#11.3.5
#read_csv uses a comma but read_csv uses a semi-colon(;)

#11.3.7
d1 <- "January 1, 2010"
parse_date(d1, "%B %d, %Y")
d2 <- "2015-Mar-07"
parse_date(d2, "%Y-%b-%d")
d3 <- "06-Jun-2017"
parse_date(d3, "%d-%b-%Y")
d4 <- c("August 19 (2015)", "July 1 (2015)")
parse_date(d4, "%B %d (%Y)")
d5 <- "12/30/14" # Dec 30, 2014
parse_date(d5, "%m/%d/%y")
t1 <- "1705"
parse_time(t1, "%H%M")
t2 <- "11:15:10.12 PM"
parse_time(t2, "%H:%M:%OS %p")

#haven readxl DBI packages


#Tidy data
#"Happy families are all alike; every unhappy family is unhappy in its own way." -- Leo Tolstoy
#"Tidy datasets are all alike, but every messy dataset is messy in its own way." -- Hadley Wickham

#12.2.1 Excersises
#12.2.2
table2_cases <- table2 %>% filter(type == "cases") %>%
  rename(cases = "count") %>% 
  arrange(country, year)
table2_pop <- table2 %>% filter(type == "population") %>% 
  rename(population = "count") %>% 
  arrange(country, year)
t2 <- tibble(
  year = table2_cases$year,
  country = table2_cases$country,
  cases = table2_cases$cases,
  population = table2_pop$population
  ) %>% mutate(rate = (cases/population) * 10000) 
t2


#12.2.3
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))
table2 %>% 
  filter(type == "cases") %>%  
  ggplot(aes(year, count)) + 
  geom_line(aes(group = country), colour = "grey") +
  geom_point(aes(color = country)) + 
  scale_x_continuous(breaks = table2$year)


#One variable might be spread across multiple columns.
#One observation might be scattered across multiple rows.

#gather()
#A common problem is a dataset where some of the column names are not names of variables, but values of a variable.
table4a %>% 
  gather('1999',`2000`, key = "year", value = "cases")

#To remember: Gaaaaaaaatheeeer (long format)


#spread()
#when an observation is scattered across multiple rows we should use spread
table2 %>% 
  spread(key = type, value = count)
#no selecting, no quotes


#Excercise 12.3.1
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  spread(year, return) %>% 
  gather("year", "return", `2015`:`2016`)
#it makes their types change when we use gather and spread
#When convert = TRUE, the gather() function will attempt to convert vectors to the appropriate type. 
stocks %>%
  spread(key = "year", value = "return") %>%
  gather(`2015`:`2016`, key = "year", value = "return", convert = TRUE)

#12.3.3
people <- tribble(
  ~name, ~key, ~value,
  #-----------------|--------|------
  "Phillip Woods", "age", 45,
  "Phillip Woods", "height", 186,
  "Phillip Woods", "age", 50,
  "Jessica Cordero", "age", 37,
  "Jessica Cordero", "height", 156
)
people
spread(people, key, value)
#the problem is there are two rows with values for the age of "Phillip Woods".
#We could solve the problem by adding a row with a distinct observation count for each combination of name and key.
people2 <- people %>%
  group_by(name, key) %>%
  mutate(obs = row_number())
people2
spread(people2, key, value) 

#another way
people %>%
  distinct(name, key, .keep_all = TRUE) %>%
  spread(key, value)

#Exercise 12.3.4
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes", NA, 10,
  "no", 20, 12
)
preg
preg %>% gather(male:female, key = "Gender", value = "count", na.rm = TRUE)





#separate() pulls apart one column into multiple columns, by splitting wherever a separator character appears.
table3 %>% 
  separate(rate, into = c("cases", "population"),convert = TRUE, sep = "/")
#sep with integers means number from left-left