# Olympics Data Analysis using R

library(dplyr)
library("ggplot2")
library(tidyr)

# Read the csv files
athletes <- read.csv("e:/r/athlete_events.csv")
region <- read.csv("e:/r/noc_regions.csv")

head(athletes)
head(region)

# join the data frames
athletes_df <- merge(x = athletes, y = region, by = 'NOC')

# -----------------------------------------------------------------------
# Natural Join or Inner Join

# A = [1, 2, 3, 4, 5]
# B = [2, 3, 5, 6]
# Then the output of natural join will be (2, 3, 5)
# -----------------------------------------------------------------------

# Renaming colums region to Region, notes to Notes
colnames(athletes_df)[16] <- "Region"
colnames(athletes_df)[17] <- "Notes"

summary(athletes_df)

#identifying the columns with NAs
NA_col <- colnames(athletes_df)[apply(athletes_df, 2, anyNA)]
sum(is.na(athletes_df$Age))
sapply(athletes_df, function(x) sum(is.na(x)))

unique(athletes_df$Age)
max(athletes_df$Age, na.rm = TRUE)

# NAs affect the results
athletes_df$Medal == "Gold"
head(athletes_df[athletes_df$Medal == "Gold",])

# Dropping entire NAs will reduce data size
athletes_temp_df <- athletes_df %>% drop_na()

athletes_df$Medal[is.na(athletes_df$Medal)] <- "NA"
athletes_df$Age[is.na(athletes_df$Age)] <- 0

hist(athletes_df$Age)
hist(athletes_df$Age, xlab = "Age", ylab = "Frequency of Age", xlim = c(0,80), col = "blue", las =1, border = "green", main = "Histogram of Athletes Age")

# Unique items
unique(athletes_df$Games)
unique(athletes_df$Sport)
unique(athletes_df$Event)
unique(athletes_df$Team)

# Athletes from India
athletes_df$Team== "India" # Logical values
head(athletes_df[athletes_df$Team == "India",]) # Print the rows that have TRUE values
athletes_df[athletes_df$Team == "Japan",2]

# Top countries participating
top10 <- athletes_df %>%
  group_by(Team) %>%
  summarise(participants = n()) %>%
  arrange(desc(participants))

top10$Team
head(top10,10)

ggplot(head(top10,10),aes(x = reorder(Team, -participants), y = participants, fill = Team)) +
  geom_bar(stat = "identity") +
  #scale_x_discrete(guide = guide_axis(n.dodge=13)) +
  theme_classic() +
  labs(
    x = "Team",
    y = "Participation",
    title = paste(
      "Group_by Team with summarise()"
    )
  )


# To find unique Summer/Winter sports
unique(athletes_df$Season)
athletes_df$Season == "Summer"
summer_sport <- athletes_df[athletes_df$Season == "Summer",]
unique(summer_sport$Sport)

# To find total number of males and females
gender_count <- athletes_df %>%
  group_by(Sex) %>%
  summarise(male_female = n())

gender_count <- athletes_df %>%
  group_by(Sex) %>%
  summarise(male_female = length(Sex))

tapply(athletes_df$Sex,athletes_df$Sex,length)
#----------------------------------------------------------------
# to calculate the mean of the Sepal Length for each Species
tapply(iris$Sepal.Length, iris$Species, mean)
#------------------------------------------------------------
# Pie Chart
piepercent <- round(100 * gender_count$male_female / sum(gender_count$male_female), 1)
pie(gender_count$male_female, labels = piepercent, main = "Pie Chart M/F", col = rainbow(length(gender_count)))
legend("topright", c("Female", "Male"), 
       cex = 0.5, fill = rainbow(length(gender_count)))

# Total medals
medal <- tapply(athletes_df$Medal, athletes_df$Medal, length)
pie(medal)

# Total number of female athletes in summer olympics each year
participants <- athletes_df %>%
  group_by(Sex, Season, Year) %>%
  summarise(participation = n())

participants[participants$Sex=='F',]
participants[participants$Sex=='F' & participants$Season == "Winter",]
female_summer <- participants[participants$Sex=='F' & participants$Season == "Summer",]

tail(participants,10)
tail(participants[participants$Sex=='F' & participants$Season == "Winter",])

plot(female_summer$Year, female_summer$participation)

# Gold medal athletes with age more than 60
Gold_medal <- athletes_df[athletes_df$Medal == "Gold" & athletes_df$Age > 60,]

count(Gold_medal)
athletes_df[athletes_df$Medal == "Gold" & athletes_df$Age > 60,1]
athletes_df[athletes_df$Medal == "Gold" & athletes_df$Age > 60,c(1,2)]

# To find specific columns from the result
athletes_df[athletes_df$Medal == "Gold" & athletes_df$Age > 60,c(1:2,13)]

All_gender_medal <- athletes_df %>%
  group_by(Sex, Medal) %>%
  summarise(count_medal = n())

All_gender_medal[All_gender_medal$Sex == 'F',]

All_Gender_medal_60 <- athletes_df %>%
  group_by(Sex, Medal, Age > 60) %>%
  summarise(count_medal = n())

All_Gender_medal_60[All_Gender_medal_60$`Age > 60`,]

# Visualize
Gold_medal
tbl <- with(Gold_medal, table(Medal,Sport))
barplot(tbl)

tbl <- with(Gold_medal, table(Medal,Region))
barplot(tbl)

# Gold medals from each country
Country_gold <- athletes_df %>%
  group_by(Region, Medal) %>%
  summarise(cg_count <- n())

Country_gold[Country_gold$Medal == "Gold",]

top10gold <- athletes_df %>%
  group_by(Region, Medal) %>%
  summarise(participants = n()) %>%
  arrange(desc(participants))

top10gold <- head(top10gold[top10gold$Medal == "Gold",],10)

# Visualize
top10gold
tbl <- with(top10gold, table(Region,participants)) # error
plot(top10gold$Region, top10gold$participants) # error

ggplot(top10gold,aes(x = Region, y = participants, fill = Region)) +
  geom_bar(stat = "identity") +
  #scale_x_discrete(guide = guide_axis(n.dodge=13)) +
  theme_classic() +
  labs(
    x = "Team",
    y = "Participation",
    title = paste(
      "Group_by Team with summarise()"
    )
  )


# Rio olympics
max(unique(athletes_df$Year))
team_names <- athletes_df[athletes_df$Year == 2016 & athletes_df$Medal == "Gold", 8]
tail(sort(table(team_names)),10)
barplot(tail(sort(table(team_names)),10))
par(mai=c(1,2,1,1)) # adjusting the graphical margins
barplot(tail(sort(table(team_names)),10), main = "Gold Medal Rio Olympics",
        xlab = "No. of Gold Medals",
        #ylab = "Country",
        col = c(rainbow(10)),
        horiz = TRUE, las = 1)
sort(team_names)

# Height and weight scatter plot of medal winners
winners_ht_wt <- athletes_df %>%
  group_by(Medal != "NA")

winners <- athletes_df[athletes_df$Medal != "NA",]
plot(winners[,6], winners[,7])
plot(winners[winners$Sex == 'M',6], winners[winners$Sex == 'M',7], xlim = c(120,220), ylim = c(30,180), col = "red", xlab = "Height", ylab = "Weight")
#par(new=TRUE)
#plot(winners[winners$Sex == 'F',6], winners[winners$Sex == 'F',7], xlim = c(120,220), ylim = c(30,180), col = "blue")

points(winners[winners$Sex == 'F',6], winners[winners$Sex == 'F',7], xlim = c(120,220), ylim = c(30,180), col = "blue")
legend(120, 190, legend = c("Men", "Female"),
       col=c("red", "blue"), cex=0.8, pch = c(19,19))
