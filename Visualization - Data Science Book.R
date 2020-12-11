# Data Visualisation

library("tidyverse")
mpg
?mpg
str(mpg)
glimpse(mpg)

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

# The main function
#ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

ggplot(data = mpg)
ggplot(data = mpg) + geom_point(mapping = aes(x = hwy, y = cyl))
ggplot(data = mpg) + geom_point(mapping = aes(x = class, y = drv))


#“The greatest value of a picture is when it forces us to notice what we never expected to see.” — John Tukey


ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy , color = class))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy , size = class))
#mapping an unordered variable (class) to an ordered aesthetic (size) is not a good idea


ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class))
#ggplot2 will only use six shapes at a time. By default, additional groups will go unplotted when you use the shape aesthetic


ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "blue", shape = 6)
#color should be out of aes
#list of shape's number in Figure 3.1


ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy , color = cty))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy , shape = cty))
#A continuous variable can not be mapped to shape


?geom_point
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy , stroke = cyl))
# +  it has to come at the end of the line, not the start


#particularly useful for categorical variables, is to split your plot into facets
#The variable that you pass to facet_wrap() should be discrete.
#Points now are distingushable
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class )) + facet_wrap(~class, nrow = 2)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ cyl)  
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(. ~ cyl)
#If you prefer to not facet in the rows or columns dimension


ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class )) + facet_wrap(~cty, nrow = 2)
#Continue Variable in facet


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
#By Comparison we find out that each dot in plot 2 shows one facet in plot 1

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
#facet_grid arguments order: Rows ~ Columns
#When using facet_grid() you should usually put the variable with more unique levels in the columns because rows going down deep is not good!





ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
#Here geom_smooth() separates the cars into three lines based on their drv value

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
#group aesthetic to a categorical variable to draw multiple objects


ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, color = drv), show.legend = F)


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
#multiple geoms

#set of mappings to ggplot(). ggplot2 will treat these mappings as global mappings that apply to each geom in the graph
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
#Both are all the same


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(aes(color = class)) + geom_smooth()
#If you place mappings in a geom function, ggplot2 will treat them as local mappings for the layer


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(aes(color = class)) + geom_smooth(data = filter(mpg, class == "suv"))
#filtering the specific data


ggplot(data = mpg) + geom_line(mapping = aes(x = displ, y = hwy, color = class))
ggplot(data = mpg) + geom_boxplot(mapping = aes(x = displ, y = hwy, color = class))
ggplot(data = mpg) + geom_area(mapping = aes(x = displ, y = hwy, color = class))
ggplot(data = mpg) + geom_histogram(mapping = aes(x = displ))
#in Histograms we just should mention the x scale


ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = F)
#se is the grey shadow which is confidence interval



ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#Both are the same


#Exercises
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy, stroke = displ)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy, group = drv), se = F)

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy, stroke = displ, color = drv)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy, group = drv, color = drv), se = F)

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy, stroke = displ, color = drv)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy, group = drv, linetype = drv), se = F)





ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))
#bar charts, histograms, and frequency polygons bin your data and then plot bin counts, the number of points that fall in each bin.
#smoothers fit a model to your data and then plot predictions from the model
#The algorithm used to calculate new values for a graph is called a stat, short for statistical transformation
#You can learn which stat a geom uses by inspecting the default value for the stat argument. For example, ?geom_bar shows that the default value for stat is “count”, which means that geom_bar() uses stat_count()
#stat_count() is documented on the same page as geom_bar()
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))
#You can generally use geoms and stats interchangeably
#There are three reasons you might need to use a stat explicitly
#You might want to override the default stat
#You might want to override the default mapping from transformed variables to aesthetics
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
#You might want to draw greater attention to the statistical transformation in your code
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

#Exercises
ggplot(data = diamonds) + geom_col(mapping = aes(x = cut, y = depth))
# geom_col should specify the y but in geom_bar it shouldn't

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..,group =1))
#You should specify group argument




ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, color = cut))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))
# fill is better than color|colour
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))
# if we add another factor in fill


#If you don’t want a stacked bar chart, you can use one of three other options: "identity", "dodge" or "fill"
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")
#position = "fill" works like stacking, but makes each set of stacked bars the same height. This makes it easier to compare proportions across groups.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill" )
#position = "dodge" places overlapping objects directly beside one another. This makes it easier to compare individual values.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
#position = "jitter" adds a small amount of random noise to each point. This spreads the points out because no two points are likely to receive the same amount of random noise.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")



#Exercises
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")
# So with jitter it is improved and better now and no more overplotting
ggplot(mpg, aes(cty, hwy)) + geom_jitter(width = 0.5, height = 0.5)

#just like geom_point but with size of n
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count()

#geom_boxplot default for position is dodge2
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = displ, y = hwy, group = 1), position = "identity")





#coord_flip() switches the x and y axes
#This is useful (for example), if you want horizontal boxplots. It’s also useful for long labels
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
#coord_quickmap() sets the aspect ratio correctly for maps. This is very important if you’re plotting spatial data with ggplot2
install.packages("maps")
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()
#coord_polar() uses polar coordinates (pie chart) 
#Polar coordinates reveal an interesting connection between a bar chart and a Coxcomb chart
ggplot(data = diamonds) + geom_bar(mapping =aes(x = cut, fill = cut)) + theme(aspect.ratio = 1) + labs(x = NULL, y = NULL) + coord_flip()
ggplot(data = diamonds) + geom_bar(mapping =aes(x = cut, fill = cut)) + theme(aspect.ratio = 1) + labs(x = NULL, y = NULL) + coord_polar()
#labs is x and y labels(count and cut)


#Exercises
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity") + coord_polar()

#for coord_map you should install below
install.packages("mapproj")
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_map()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()
#coord_fixed makes its ratio change (better image) because specified ratio between the physical representation of data units on the axes
#geom_abline plot the line




#ggplot(data = <DATA>) + 
#<GEOM_FUNCTION>(
 # mapping = aes(<MAPPINGS>),
  #stat = <STAT>, 
  #position = <POSITION>
#) +
  #<COORDINATE_FUNCTION> +
  #<FACET_FUNCTION>