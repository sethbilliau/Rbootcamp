# This is a comment! It doesn't affect your code, but it's very important to annotate your 
# code so that you and your peers will understand it later

### BASICS ###

# Let's begin by trying some basic operations. Use Command + Enter to run code line by line,
# or click the run button above. You can also highlight chunks of code and run code all at once. 
1 + 3; 4 - 1; 5 * 3; 2 / 3; 10 %% 2; 2^2

# Note that unlike a language like OCaml, floats (decimals) can be added/subtracted/etc. to integers
1.5 + 3; 4 - 1.3; 5 * 2.5; 3 / 2.5; 10 %% 2.5; 2.4^2

# Variable assignment in R is done with <- or =. In this class, we usually deal with variables 
# that are vectors or matrices.

# x is a vector of length 3 while z is a 3x3 matrix
x = c(72,34,19); x
z = cbind(c(1,2,3),c(4,5,6),c(7,8,9)); z

# The c() command combines values into a vector, 
# cbind binds vectors together as columns to form a matrix (array of like type ie. all numbers, bools, etc.)

# Try appending x to z to form a 3x4 matrix
cbind(z,x)

### FUNCTIONS ###

# We can define functions in R that take inputs and provide us with outputs.

# This function 
myfn0 <- function(x) {
  return(x+4)
}
myfn0(3)


# This function can also take in vector values and matrix values
myfn0(x)
myfn0(z)

# We can also plot functions 

fun <- function(x) x^2*cos(x)
plot(fun, xlim=c(-pi,pi), ylim=c(-2,2))

# In this class, we will usually be plotting canonical stats distributions you'll learn about 
# later. As a preview, here's a plot of the standard normal distribution. 

norm <- function(x) dnorm(x, mean=0, sd=1) 
plot(norm, xlim=c(-3,3))

# We can also define functions that act as binary operators. This function acts as addition in mod 2
"%+%" <- function(x,y) (x+y)%%2

# 10 + 3 mod 2 = 1 
10 %+% 3 

# Functions can also return a list of many values. A list is exactly what it sounds like:
myfn1 <- function(x) {
  list <- list("plus4" = x + 4, "minus4" = x - 4);
  return(list)
}
myfn1(3)

# DO: Write your own functions and binary operators. Write a function that finds the roots of a 
# quadratic equation. (the built-in fn sqrt() will be helpful). Use ?sqrt to see its specs
# Create a binary operator that does multiplication in mod 7.

quad <- function(a,b,c) {
  mylist = list("root1" = (-b + sqrt(b^2- 4*a*c)) / (2*a),
                "root2" = (-b - sqrt(b^2- 4*a*c)) / (2*a)
  );
  return(mylist)
}

quad(1,-1,-2)


### DATAFRAMES ###

# Another R datatype is called the dataframe. The dataframe is like a matrix, but can have entries of 
# different types 
# For example
p <- c(T,T,F,F);p # booleans/logicals
q <- c(1,2,3,4);q # numericals
r <- c("Seth", "Ryan", "Henry", "John");r # character
mydataframe <-data.frame(p, q, r)

# We can extract columns and entries in the dataframe (or in matrices) using [] or $

# Extract column 3
mydataframe[,3]
mydataframe$r

# Extract the element in the 2nd row and 2nd column
mydataframe[2,2]
mydataframe$q[2]

# We can also delete rows and columns of our dataframe by using the - command
# For example, delete row 1
mydataframe = mydataframe[-1,]; mydataframe

# P.S. to check the type of a variable, use class()
class("Seth")
class(T)

### REAL DATA ###

# We usually see dataframes in the context of data that has been created or compiled for us to use
# in excel spreadsheets or .csv files. We can load .csv files into R using this function 
enrollment <-read.csv("concentration-enrollment.csv"); enrollment

# This .csv file shows the number of people enrolled in each concentration from 2010-11 to 2014-15
# this dataset is courtesy of harvard open data project
concentration <- enrollment$concentration; head(concentration)

# We can look up the index of certain values of concentration by using which() and == (equality)
# Look up the index of the applied math concentration
which(concentration == "Applied Mathematics")

# DO: Extract the number of Math concentrators in 2011-12. 
math<-which(concentration == "Mathematics")
enrollment$X2011.12[32]

# Reading documentation is a very important skill when working with any language 
# To access documentation for a function, simply run a line of code with ? in front of that function 
# Try it here with which
?which

# DO: R can also create really cool graphics. Try using reading the ?hist() documentation and 
# using hist to plot the 2011.12 enrollment data. Adjust your breaks parameter to  
# give your histogram a reasonable number of buckets and color your columns. 
# Then use ?abline to plot colored lines at the median and mean enrollment values
?hist()
?abline()
hist(enrollment$X2011.12, breaks="fd", col = c("red","green"))
abline(v=mean(enrollment$X2011.12), col="blue")
abline(v=median(enrollment$X2011.12), col="blue")

# We can also add columns to our dataframe and write new .csv files ourselves. 
# DO: Create a "rate" column that represents concentration growth from 2010.11 to 2014.15. Then 
# use the dataframe function to add your new column to the enrollment dataframe.
# Your newly created file should be in your Rbootcamp folder.
rate = enrollment$X2014.15 / enrollment$X2010.11; head(rate)
newdataframe = data.frame(enrollment, rate); head(newdataframe)
write.csv(newdataframe, file = "rate.csv")

# DO: As a final exercise, you will be using the dataset I used for my final R project on Kiva 
# microfinance loans. You should load the file using read.csv. Clean the data by deleting 
# the erroneous X and "lamount" columns. Then, visualize the data by plotting a histogram  
# of loan values with breaks="fd" and xlim = c(0,10000). Title your graph using main= and label the 
# x and y axes. Calculate the % of grants  above the mean grant amount using the which() and length()
# functions. Explain why mean is not a good measure of center for these data. 
Kiva = read.csv("kiva_logical.csv"); head(Kiva)
Kiva = Kiva[,-1]; Kiva = Kiva[,-5]; head(Kiva)

hist(Kiva$famount, breaks="fd")

max_f <- max(Kiva$famount); max_f
mu_f <- mean(Kiva$famount); mu_f
med_f <- median(Kiva$famount); med_f

length(which(kiva_logical$famount > mu_f)) / length(Kiva$famount)


# DO **BONUS**: One of the goals of my project was to see if female-identifying people asking for grants
# received less money than male-identifying people. Assuming that there is no difference between 
# genders and grant amounts, we can use a chisquare test. (If you don't understand this now, it'll
# be explained in class a bit later in the course). Read the documentation on the chisq.test(). 
# See if you can convert the amount column into a logical variable that will be True if an amount is 
# above the median, False else. Then, using chisq.test(), compare this column with the gender column.
# This can be done in one line of code.
?chisq.test
chisq.test((Kiva$famount > med_f), kiva_logical$gender)


### Linear Regression ###

# As a preview of my bootcamp on data journalism and statistics, 
# you can also do Linear regression using R. We are going to be using the USArrests dataset that's
# already hardcoded into R. 
str(USArrests)

# Suppose that we want to predict how many assaults there are going to be in the US using the number 
# of murders as our covariate/independent variable. We can first plot the relationship between these 
# two vectors as follows 
plot(Assault ~ Murder, data = USArrests)

# This looks like a good candidate for linear regression. We can use the lm command to create a linear
# model and plot it.
mod = lm(Assault ~ Murder, data = USArrests)
s = summary(mod)
abline(mod, col = "red")

# We can now predict the number of assaults based on 20 and 22 murders. 
predict(mod, data.frame(Murder = c(20,22)))

# DO: try to use rape to predict the number of murders using rape = 2 and 4
mod <- lm(Murder ~ Rape, data = USArrests)
predict(mod, data.frame(Rape = c(2,4)))



### GGPlot2 and Plotly ###
# Load in the HODP style guide (this is an ongoing project I've been working on).
source("styleguide.R")
source("ggplot_example.R")

# GGPlot2 is a very powerful and highly-customizable graphics package. You can also use it in python, 
# but it's most commonly used in R. Unfortunately there's really no easy way to learn ggplot aside from 
# just using it a bunch and googling documentation as you need it. 
library(ggplot2)
a

# Cool right! This is the code I used to make it. I have all of my data stored in a dataframe called mi. 
# It looks like this: 
head(mi)

# I want to plot years on the x axis and candidatevotes on the y axis. I want to plot the points and connect
# them with lines. I want to make groups by the factor variable party. 
# can do that with this command. 

p <- ggplot(data=mi, aes(x=year, y=candidatevotes)) + 
  geom_line(aes(colour = factor(party))) +
  geom_point(aes(colour = factor(party))) 
p

# Now that we have a baseline graph, we can spice up our graph with some aesthetic commands

p <- p + scale_color_manual(values = c("#78C4D4", "#EE3838","#4B5973", 'cornflowerblue'),name="Party") +
  labs(title="MI3 Elections") +
  xlab("Year") +
  ylab("Votes") +
  theme(legend.position="bottom") +
  theme_hodp()
p

# To add the HODP logo, run this line of code. It takes around 15s to run and kind of 
# screws up the plots window, so only run it when you're really sure your static graphic is ready.
# grid::grid.raster(logo, x = 0.01, y = 0.01, just = c('left', 'bottom'), width = unit(2, 'cm'))


# This graph looks dope... I hope you'll agree. But we can make it cooler! ggplot2 objects can be 
# easily turned into plotly objects. Just load in the plotly library and use the command ggplotly
library(plotly)
plotly_p <- ggplotly(p)
plotly_p


# DO: Now it's your turn! Recreate your lm graphic using murder to predict using ggplot. Give your 
# graphic a title and add the HODP theme.
# Just use this line command to plot the linear model: 
# stat_smooth(method = "lm", col = "red")
p <- ggplot(data = USArrests, aes(x= Murder, y= Assault)) + 
  geom_point() + 
  labs(title="Assaults vs. Murder") +
  stat_smooth(method = "lm", col = "red") + 
  theme_hodp()
p

ggplotly(p)


