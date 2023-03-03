library(tidyverse)
library(ggplot2)
library(lubridate)
library(readr)
library(dplyr)
mentalhealth_music_survey <- read_csv("C:/Users/Lenovo- Tej/Documents/DA Portfolio/Data sets/music_mentalhealth_survey_cleaned2.csv")
str(mentalhealth_music_survey)
summary(mentalhealth_music_survey)
head(mentalhealth_music_survey)

# EDA
# 0. The Survey
dim(mentalhealth_music_survey)
str(mentalhealth_music_survey)
# The survey had 736 responses
summary(mentalhealth_music_survey$Date)
head((arrange(count(mentalhealth_music_survey,Date),desc(n))), n=10)
ggplot(mentalhealth_music_survey, aes(x=Date)) + geom_bar(fill='red') +
  labs(title='Distribution of Survey Responses')
# The survey was open between 27th August and 9th November 2022 with majority of responses coming within the first two weeks ,i.e before 15th September. 

# 1. The Participants
summary (mentalhealth_music_survey$Age)
ggplot (data=mentalhealth_music_survey, mapping= aes (x=Age))+ 
  geom_histogram (fill='lightblue') + 
  scale_x_continuous(breaks = seq(0,100, 20)) + 
  labs(title='Age Distribustion of Survey Participants')

# Majority of the survey respondents are under 40years,with the youngest participant being 10 years and the oldest being 89 years. There is a good
# spread of the age.

head(arrange(mentalhealth_music_survey %>% group_by(Age) %>% 
               summarise(no_of_respondents =n()),desc(no_of_respondents)), n=10)
# The highest respondents fall between 17 and 26 years of age.

ggplot(data = head(arrange( (mentalhealth_music_survey %>% group_by(Age) %>% 
                               summarise (no_of_entries= n())),
                            desc(no_of_entries)), n=10),
       mapping= aes(x=Age,y=no_of_entries))+
  geom_bar(stat="identity", fill='black') + labs(title="Participant ages by Count")
#The ages of top ten participants were all under 26 years, with 18 year olds being the ones who participated the most.

# 2. Music Streaming Platform
# What are the streaming services respondents use?
unique(mentalhealth_music_survey$`Primary streaming service`)

# Changed the values under Primary Streaming Service for better representation

mentalhealth_music_survey$`Primary streaming service` <- 
  replace(mentalhealth_music_survey$`Primary streaming service`,
          mentalhealth_music_survey$`Primary streaming service`== 
            'I do not use a streaming service.','None')
mentalhealth_music_survey<- mentalhealth_music_survey %>% 
  mutate(`Primary streaming service` = 
           recode(`Primary streaming service`,
                  'Other streaming service' = 'Other','YouTube Music'='YouTube'))

#Top Music Streaming Service of Participants
arrange((count(mentalhealth_music_survey, `Primary streaming service`)),
        desc(n))
ggplot(data = arrange((count(mentalhealth_music_survey,
                             `Primary streaming service`)), desc(n)),
       aes(x=reorder(`Primary streaming service`,-n),y=n))+
  geom_bar(stat="identity", fill='blue') + 
  labs(x='Sreaming Service',y='number of users',title="Streaming Services Used by Participants")
# Spotify was the preferred choice of participants and Pandora is the least used.

# Streaming services by Age of Users
ggplot(mentalhealth_music_survey, aes(x=`Primary streaming service`,
                                      y=Age,fill=`Primary streaming service`)) +
  geom_boxplot()+  scale_fill_brewer(palette="Dark2")+ 
  labs(title="Participant Age Profile of Music Streaming Services ")
# The older demography of the participants used Pandora while Apple Music, 
# Spotify and YouTube Music had participants all under 30 years old.

#3. Hours per Day spent Listening to Music
summary(mentalhealth_music_survey$`Hours per day`)
ggplot (data=mentalhealth_music_survey, mapping= aes (x= `Hours per day`))+ 
  geom_histogram (fill="#69b3a2", color="#e9ecef", alpha=0.9) + 
  scale_x_continuous(breaks = seq(0,24, 5))+ 
  labs(title="Music listening time of participants in hours/day ")
head(arrange(count(mentalhealth_music_survey,`Hours per day`), desc(n)), n=10)
# Majority of participants have a music listening time of 30 minutes and 10 hours 
# daily. Most of the respondents listen to music between 1 and 3 hours daily. 

#4. Participants Musical Background
ggplot(data = count(mentalhealth_music_survey,`Instrumentalist`),
       mapping= aes(x=`Instrumentalist`,y=n, fill=`Instrumentalist`))+ 
  geom_bar(stat="identity") + labs(y='Number of persons',title="Participants Who are Instrumentalists")

ggplot(data = count(mentalhealth_music_survey,`Composer`),
       mapping= aes(x=`Composer`,y=n, fill=`Composer`))+ 
  geom_bar(stat="identity")+ labs(y='Number of persons',title="Participants Who are Composers")
#Majority of the participants are neither composers or instrumentalists. However, 
# More of the survey respondents are instrumentalists compared with the number

#5. Correlation Analysis
#5.1 Musical Background, Age, Hours Listened to Music, Listened to Music while
# at work,Exploratory personality and Listening to Foreign Language
MHM_corr <- mentalhealth_music_survey %>%
  select(Age,`Hours per day`,`While working`,
         Instrumentalist,Composer,Exploratory,`Foreign languages`)
MHM_corr <- MHM_corr %>% mutate(`While working`= recode(`While working`,'Yes'=1,'No'=0),
                                Instrumentalist= recode(Instrumentalist,'Yes'=1,'No'=0),
                                Composer=recode(Composer,'Yes'=1,'No'=0),
                                Exploratory=recode(Exploratory,'Yes'=1,'No'=0),
                                `Foreign languages`= recode(`Foreign languages`,
                                                            'Yes'=1,'No'=0))
MHM_corr_table <- round(
  (cor(MHM_corr,use = "complete.obs", method = c("pearson"))), 2)
install.packages("corrplot")
library(corrplot)
corrplot(MHM_corr_table,method = "circle",type = "upper",order="hclust",
         tl.col = "black", tl.srt = 45, bg="black")
# There is slight correlation between Composers and Instrumentalists,
# Hours per day listening to music and working, exploring music while working 
#and listening to foreign music while exploring. On the other hand, the 
# following have weak correlation; Age and exploration, Age and foreign language
#music

#5.2 Musical background vs mental health
MHM_corr2 <- mentalhealth_music_survey %>%
  select(Age,Instrumentalist,Composer,Anxiety,Depression,Insomnia,OCD)
MHM_corr2 <- MHM_corr2 %>% 
  mutate(Instrumentalist= recode(Instrumentalist,'Yes'=1,'No'=0),
         Composer=recode(Composer,'Yes'=1,'No'=0))
MHM_corr_table2 <- round(
  (cor(MHM_corr2,use = "complete.obs", method = c("pearson"))), 2)
print(MHM_corr_table2)
corrplot(MHM_corr_table2,method = "circle",type = "upper",order="hclust", tl.col = "black", tl.srt = 45, bg="black")
# There is no correlation between Age and Mental Health. However,there is a
# slight correlation between mental health and musical background of respondents


#6. Mental Health Status of Participants based on Musical Background
# For this analysis, i dropped all records that were empty.
mentalhealth_music_survey2 <- mentalhealth_music_survey %>% drop_na()

Instrumentalist <- mentalhealth_music_survey2 %>% filter(Instrumentalist == 1)
Non_Instrusmentalist <- mentalhealth_music_survey2 %>% filter(Instrumentalist == 0)
Composer <- mentalhealth_music_survey2 %>% filter(Composer == 1)
Non_Composer <- mentalhealth_music_survey2 %>% filter(Composer == 0)

#Anxiety
#Instrumentalists
ggplot(data = count(Instrumentalist,Anxiety), mapping = aes(x = Anxiety,y= n))+
  geom_bar(stat='identity',fill='black')+ labs(x='Anxiety Score',y= 'Participant Count') + 
  labs(title = 'Instrumentalists with Anxiety')
# Non-Instrumentalist
ggplot(data = count(Non_Instrusmentalist,Anxiety),
       mapping = aes(x = Anxiety,y= n))+ geom_bar(stat='identity',fill='red') + 
  labs(x='Anxiety Score',y= 'Participant Count',title = 'Non-Instrumentalists with Anxiety')
#Composers
ggplot(data = count(Composer,Anxiety), mapping = aes(x = Anxiety,y= n))+
  geom_bar(stat='identity',fill='purple') +
  labs(x='Anxiety Score',y= 'Participant Count',title = 'Composers with Anxiety')
#Non-Composers
ggplot(data = count(Non_Composer,Anxiety), mapping = aes(x = Anxiety,y= n))+
  geom_bar(stat='identity',fill='lightblue') + 
  labs(x='Anxiety Score',y= 'Participant Count',title = 'Non-Composers with Anxiety')
# From the above, the most of the respondents have high anxiety scores irrespective 
# of musical background.

#Depression
#Instrumentalists
ggplot(data = count(Instrumentalist,Depression), mapping = 
         aes(x = Depression,y= n))+geom_bar(stat='identity',fill='black')+ 
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Depression Score',y= 'Participant Count',
       title = 'Instrumentalists with Depression')
# Non-Instrumentalist
ggplot(data = count(Non_Instrusmentalist,Depression), 
       mapping = aes(x = Depression,y= n))+ 
  geom_bar(stat='identity',fill='red') +
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Depression Score',y= 'Participant Count',
       title = 'Non-Instrumentalists with Depression')
#Composers
ggplot(data = count(Composer,Depression), mapping = aes(x = Depression,y= n))+
  geom_bar(stat='identity',fill='purple') + 
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Depression Score',y= 'Participant Count',
       title = 'Composers with Depression')
#Non-Composers
ggplot(data = count(Non_Composer,Depression), 
       mapping = aes(x = Depression,y= n))+
  geom_bar(stat='identity',fill='lightblue')+ 
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Depression Score',y= 'Participant Count',
       title = 'Non-Composers with Depression')
#Majority of survey participants registered high depression scores(i.e. above 5).

#Insomnia
#Instrumentalists
ggplot(data = count(Instrumentalist,Insomnia), mapping = 
         aes(x = Insomnia,y= n))+geom_bar(stat='identity',fill='black')+ 
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Insomnia Score',y= 'Participant Count',
       title = 'Instrumentalists with Insomnia')
# Non-Instrumentalist
ggplot(data = count(Non_Instrusmentalist,Insomnia), 
       mapping = aes(x = Insomnia,y= n))+ 
  geom_bar(stat='identity',fill='red') + 
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Insomnia Score',y= 'Participant Count',
       title = 'Non-Instrumentalists with Insomnia')
#Composers
ggplot(data = count(Composer,Insomnia), mapping = aes(x = Insomnia,y= n))+
  geom_bar(stat='identity',fill='purple') + 
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Insomnia Score',y= 'Participant Count',
       title = 'Composers with Insomnia')
#Non-Composers
ggplot(data = count(Non_Composer,Insomnia), 
       mapping = aes(x = Insomnia,y= n))+
  geom_bar(stat='identity',fill='lightblue')+
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Insomnia Score',y= 'Participant Count',
       title = 'Non-Composers with Insomnia')
# An overwhelming majority of survey participants registered very low insomnia 
# scores (under 3) 

#OCD
#Instrumentalists
ggplot(data = count(Instrumentalist,OCD), mapping = 
         aes(x = OCD,y= n))+geom_bar(stat='identity',fill='black')+ 
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='OCD Score',y= 'Participant Count',title = 'Instrumentalists with OCD')
# Non-Instrumentalist
ggplot(data = count(Non_Instrusmentalist,OCD), 
       mapping = aes(x = OCD,y= n))+ 
  geom_bar(stat='identity',fill='red') +  
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='OCD Score',y= 'Participant Count',
       title = 'Non-Instrumentalists with OCD')
#Composers
ggplot(data = count(Composer,OCD), mapping = aes(x = OCD,y= n))+
  geom_bar(stat='identity',fill='purple') +  
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='OCD Score',y= 'Participant Count',title = 'Composers with OCD')
#Non-Composers
ggplot(data = count(Non_Composer,OCD), 
       mapping = aes(x = OCD,y= n))+
  geom_bar(stat='identity',fill='lightblue')+ 
  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='OCD Score',y= 'Participant Count',title = 'Non-Composers with OCD')
# An overwhelming majority of respondents registered very low OCD scores 
# ( below 3).
# Does this mean that respondents who are Instrumentalists and Composers are more
# liable to be depressed and anxious?

#7. Participant General Mental Health
# Anxiety
arrange(count(mentalhealth_music_survey, Anxiety),desc(n))
round(mean(mentalhealth_music_survey$Anxiety),2)
ggplot(data=mentalhealth_music_survey,aes(x= Anxiety)) + geom_bar()+ 
  scale_x_continuous(breaks = seq(0,10, 2)) + labs(y='participant count', 
                                                   title = 'Participant Anxiety Scores')
## Extreme Anxiety
count(mentalhealth_music_survey, Anxiety) %>% filter(Anxiety >=8)

#Depression
count(mentalhealth_music_survey,Depression)
ggplot(data=mentalhealth_music_survey,aes(x= Depression)) + geom_bar()+ 
  scale_x_continuous(breaks = seq(0,10, 2))+ labs(y='participant count', 
                                                  title = 'Participant Depression Scores')
#Insomnia
count(mentalhealth_music_survey,Insomnia)
ggplot(data=mentalhealth_music_survey,aes(x= Insomnia)) + geom_bar()+ 
   scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(y='participant count', title = 'Insomnia Scores')

#OCD
count(mentalhealth_music_survey, OCD)
ggplot(data=mentalhealth_music_survey,aes(x= OCD)) + geom_bar()+ 
scale_x_continuous(breaks = seq(0,10, 2))+
  labs(y='participant count', title = 'OCD Scores')
# Majority of the participants have low insomnia and OCD scores while a
# considerable amount of participants indicated that they have high anxiety and
# depression scores.
# (there's a way to get all these in one statement,I am not sure yet)

# Extremely High Mental health  scores (i.e > 8) versus Average Music Listening Times
## 1. Anxiety
E_Anxiety <- mentalhealth_music_survey %>% select(`Hours per day`,Anxiety) %>%
  filter(Anxiety > 8) 
print(E_Anxiety)
round(mean(E_Anxiety$`Hours per day`),2)
## 2. Depression
E_Depression <- mentalhealth_music_survey %>% 
  select(`Hours per day`,Depression) %>%  filter(Depression >8)
round(mean(E_Depression$`Hours per day`),2)
## 3. Insomnia
E_Insomnia <- mentalhealth_music_survey %>% 
  select(`Hours per day`,Insomnia) %>%  filter(Insomnia > 8)
print(E_Insomnia)
round(mean(E_Insomnia$`Hours per day`),2)
## 4. OCD
E_OCD <- mentalhealth_music_survey %>% 
  select(`Hours per day`,OCD) %>%  filter(OCD > 8)
print(E_OCD)
round(mean(E_OCD$`Hours per day`),2)

EMH_avgMusicTime <- data.frame( 
  Mental_Health = c('Anxiety','Depression','Insomnia','OCD'), 
  Avg_Music_Time = c((round(mean(E_Anxiety$`Hours per day`),2)),
                     (round(mean(E_Depression$`Hours per day`),2)),
                     (round(mean(E_Insomnia$`Hours per day`),2)),
                     (round(mean(E_OCD$`Hours per day`),2))),
  stringsAsFactors = FALSE)
print(EMH_avgMusicTime)

ggplot(data = EMH_avgMusicTime, aes(x=Avg_Music_Time,y=Mental_Health, 
                                    fill=Mental_Health))+ 
  geom_bar(stat = 'identity') +  labs(x='Average Time Listened to Music',
                                      y= 'Mental Health',
                                      title = 'Average Time Listened to Music of Participants with Extremely High Mental Health Issues')
# So, survey respondents with extreme insomnia spend a lot more time listening 
# to music (over 5 hours daily) than respondents with other extreme mental health issues.

# Extremely Low Mental Health vs Average Time Listened to Music
## 1. Anxiety
EL_Anxiety <- mentalhealth_music_survey %>% select(`Hours per day`,Anxiety) %>%
  filter(Anxiety < 3) 
mean(EL_Anxiety$`Hours per day`)
## 2. Depression
EL_Depression <- mentalhealth_music_survey %>% 
  select(`Hours per day`,Depression) %>%  filter(Depression <3)
mean(EL_Depression$`Hours per day`)
## 3. Insomnia
EL_Insomnia <- mentalhealth_music_survey %>% 
  select(`Hours per day`,Insomnia) %>%  filter(Insomnia <3)
mean(EL_Insomnia$`Hours per day`)
## 4. OCD
EL_OCD <- mentalhealth_music_survey %>% 
  select(`Hours per day`,OCD) %>%  filter(OCD <3)
mean(EL_OCD$`Hours per day`)

ELMH_avgMusicTime <- data.frame( 
  Mental_Health = c('Anxiety','Depression','Insomnia','OCD'), 
  Avg_Music_Time = c((round(mean(EL_Anxiety$`Hours per day`),2)),
                     (round(mean(EL_Depression$`Hours per day`),2)),
                     (round(mean(EL_Insomnia$`Hours per day`),2)),
                     (round(mean(EL_OCD$`Hours per day`),2))),
  stringsAsFactors = FALSE)
print(ELMH_avgMusicTime)
ggplot(data = ELMH_avgMusicTime, aes(x=Avg_Music_Time,y=Mental_Health, 
                                    fill=Mental_Health))+ 
  geom_bar(stat = 'identity') +  labs(x='Average Time Listened to Music',
                                      y= 'Mental Health',
                                      title = 'Average Time Listened to Music of Participants with Extremely Low Mental Health Issues')
# Extremely low values are scores lower than 3. 
#Those with low Insomnia values spend the lest time listening to music in 
# comparison with their counterparts. This makes sense as they spend more time 
#sleeping. 

# Correlation between Mental health Category Scores
MH_cat<- mentalhealth_music_survey %>% select(Anxiety,Depression,Insomnia,OCD)
MH_corr_table <- round(
  (cor(MH_cat,use = "complete.obs", method = c("pearson"))), 2)
print(MH_corr_table)
corrplot(MH_corr_table,method = "circle",type = "lower",order="hclust",
         tl.col = "black", tl.srt = 45, bg="black")
#There is slight correlation amongst all the mental health categories. However, 
# Depression and Anxiety have the strongest correlation followed by Depression 
# and Insomnia, and OCD and Anxiety.

# Effect of Music on Mental Health
music_effects<- count(mentalhealth_music_survey,`Music effects`)
print(music_effects)
ggplot(music_effects, aes(x="", y=n, fill=`Music effects`)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) + theme_void() + labs(title = 'Effect of Music on Participant Mental Health')
# An overwhelming majority of participants indicated that music had a positive 
# effect on their mental health with only 17 indicating that music had negative
# impact.

# Preferred Music Genre of Participants
fav_genre<- count(mentalhealth_music_survey,`Fav genre`)
ggplot(fav_genre,aes(x=n, y= reorder(`Fav genre`,n),fill=n))+ geom_bar(stat = 'identity') +
 theme(legend.position="none") +
  labs(x='Count',y='Genre',title = 'Participant Preferred Genres')
# The most preferred genres were rock,pop and metal while the least preferred 
# were latin, gospel and lofi.

# Age Distribution by Genre
ggplot(mentalhealth_music_survey,aes(x=Age, y=`Fav genre`)) + 
  geom_point(size=4, shape=18) + labs(title = 'Age Distribution by Genre')

# Effect of music on mental health based on genre
ggplot(mentalhealth_music_survey, aes(x=`Fav genre`, fill=`Music effects`))+
  geom_bar(position = "dodge") + labs(x='Genre',y='Distribution', title = 'Effect of Music based on Genre')
# Across all genres, music improved mental health state. For Gospel and Latin, 
# this is 100% the case amongst participants. Survey participants who listened
# to Video game music,rock, pop, classical and rap were the only ones who stated 
# that these music worsened their mental health.

#BPM; How does the tempo of music affect mental health
summary(mentalhealth_music_survey2$BPM)
# an entry has the BPM of music listened to as 99999999! This is unreliable data.
# Next is to filter the BPM to the reasonable levels.
summary(mentalhealth_music_survey2 %>% 
          filter(between(BPM,21,500)) %>% select(BPM) )
MHM_survey_BPM_cleaned <- mentalhealth_music_survey2 %>% 
  filter(between(BPM,21,500))
max(MHM_survey_BPM_cleaned$BPM)
ggplot(MHM_survey_BPM_cleaned, aes(x=`Fav genre`, y=BPM,fill=`Fav genre`)) +
  geom_boxplot(alpha=0.3) + labs(x='Genre', title= 'BPM by Genre')
#BPM vs Mental Health 
MHM_BPM_cleaned<- MHM_survey_BPM_cleaned %>% 
  select(Anxiety,Depression,Insomnia,OCD,BPM)
MHM_BPM_cleaned_corr<- round(
  cor(MHM_BPM_cleaned,use = "complete.obs",method = c("pearson")),2)
print(MHM_BPM_cleaned_corr)
corrplot(MHM_BPM_cleaned_corr,method="circle",type="lower",order="hclust",
         tl.col="black", tl.srt=45, bg="black",title = "BPM-Mental Health Score Correlation") 
# From the correlation graph and table, there is a very slight correlation 
# between the BPM and mental health scores, with anxiety, depression and 
# insomnia. There is no correlation between BPM and OCD.

mentalhealth_music_survey <- mentalhealth_music_survey %>% 
  rename("Classical"="Frequency [Classical]")
mentalhealth_music_survey <- mentalhealth_music_survey %>% 
  rename("Country"="Frequency [Country]", "EDM"="Frequency [EDM]", 
         "Folk"="Frequency [Folk]","Gospel"="Frequency [Gospel]",
         "Hip hop"="Frequency [Hip hop]","Jazz"="Frequency [Jazz]",
         "K pop"="Frequency [K pop]","Latin"="Frequency [Latin]",
         "Lofi"="Frequency [Lofi]", "Metal"="Frequency [Metal]", 
         "Pop"="Frequency [Pop]","R&B"="Frequency [R&B]", 
         "Rap"="Frequency [Rap]","Rock"="Frequency [Rock]", 
         "Video Game Music"="Frequency [Video game music]")

# Genre frequency effect on mental health
ggplot(mentalhealth_music_survey, aes(x=Classical,fill=Classical))+ geom_bar()
ggplot(count(mentalhealth_music_survey,Classical), aes(x=Classical,y=n)) + geom_bar(stat = "identity")
