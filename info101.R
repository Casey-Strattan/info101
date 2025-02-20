library(ggplot2)
library(marinecs100b)


# Questionable organization choices ---------------------------------------

# P1 Call the function dir() at the console. This lists the files in your
# project's directory. Do you see woa.csv in the list? (If you don't, move it to
# the right place before proceeding.)


# P2 Critique the organization of woa.csv according to the characteristics of
# tidy data.



# Importing data ----------------------------------------------------------

# P3 P3 Call read.csv() on woa.csv. What error message do you get? What do you
# think that means?
csv <- read.csv("woa.csv")
View(csv)

# P4 Re-write the call to read.csv() to avoid the error in P3.
csv <- read.csv("woa.csv", skip = 1)


# Fix the column names ----------------------------------------------------

# P5 Fill in the blanks below to create a vector of the depth values.

depths <- c(
  seq(0, 100, by = 5),
  seq(125, 500, by = 25),
  seq(550, 1950, by = 50),
  seq(2000,5500, by = 100)
)


# P6 Create a vector called woa_colnames with clean names for all 104 columns.
# Make them the column names of your WOA data frame.
woa_colnames <- c(c("latitude", "longitude"), paste0(depths,"m"))
colnames(csv) <- woa_colnames



# Analyzing wide-format data ----------------------------------------------

# P7 What is the mean water temperature globally in the twilight zone (200-1000m
# depth)?
measurement_sums <- sum(csv[ , 27:49], na.rm = TRUE)
num_measurements <- sum(!is.na(csv[ , 27:49]))
mean <- measurement_sums/num_measurements



# Analyzing long-format data ----------------------------------------------

# P8 Using woa_long, find the mean water temperature globally in the twilight zone.
new_woa_long <- woa_long[woa_long$depth == 200:1000, 4]
mean(new_woa_long)

# P9 Compare and contrast your solutions to P8 and P9.
#Both pretty concise but the method in P8 was incredibly simple and easy to follow

# P10 Create a variable called mariana_temps. Filter woa_long to the rows in the
# location nearest to the coordinates listed in the in-class instructions.
mariana_temps <- woa_long[woa_long$latitude == 11.5 & woa_long$longitude == 142.5, 3:4]

# P11 Interpret your temperature-depth profile. What's the temperature at the surface? How about in the deepest parts? Over what depth range does temperature change the most?

# ggplot is a tool for making figures, you'll learn its details in COMM101
ggplot(mariana_temps, aes(temp_c, depth_m)) +
  geom_path() +
  scale_y_reverse()
