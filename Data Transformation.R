install.packages("tidyverse")

#RStudio's keyboard shortcut: Alt + - (the minus sign).
#press TAB
#Press TAB once more when you've selected the function you want
#This common action can be shortened by surrounding the assignment with parentheses, which causes assignment and "print to screen" to happen.
(y <- seq(1, 10, length.out = 5))
#Press Alt + Shift + K gives all shortcuts menu



#Data Transformation
install.packages("nycflights13")
library(tidyverse)
library(nycflights13)

y
cumsum(y)
cummean(y)
flights
#summarise() is pair with group by()
delays <- flights %>% 
  group_by(dest) %>%
  summarise(count = n(), 
            dist = mean(distance, na.rm = T),
            delay = mean(arr_delay, na.rm = T)) %>%
  filter(count > 20, dest != "HNL")

delays

ggplot(data = delays, mapping = aes(dist, delay)) + 
  geom_point(aes(size = count), alpha = 0.3) + 
  geom_smooth(se = F)


# Another way is to filter those data which are not NAs
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))


#Whenever you do any aggregation, it's always a good idea to include either a count (n()), or a count of non-missing values (sum(!is.na(x)))
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )
ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

install.packages("Lahman")
batting <- as_tibble(Lahman::Batting)

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) # the average positive delay
  )
# Measures of locations: mean, median
# Measures of spread: sd, IQR, mad
# Measures of rank: min, max, quantile(x, 0.25)
# Measures of position: first, last, nth(x, 2)


View(not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r)))

#count the number of non-missing values, use sum(!is.na(x)) and distinct values by n_distinct()



daily <- group_by(flights, year, month, day)
daily
(per_day <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year <- summarise(per_month, flights = sum(flights)))
daily %>% 
  ungroup() %>%             # no longer grouped by date
  summarise(flights = n()) 
#to remove groups by ungroup()

not_cancelled %>% 
  count(dest)

#OR

not_cancelled %>% group_by(dest) %>% summarise(n = n())
# Or instead of n = n(), n = length(dest)




not_cancelled %>%
  count(tailnum, wt = distance)

#OR

not_cancelled %>% group_by(tailnum) %>% summarise(n = sum(distance))




#Ctrl + Shift + S runs the whole script
