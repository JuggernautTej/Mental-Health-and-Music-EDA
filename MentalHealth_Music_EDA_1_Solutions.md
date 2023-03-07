# Solutions
## The Survey
````r
dim(mentalhealth_music_survey)
str(mentalhealth_music_survey)
  ````
 #### There were 736 responses to the survey. The survey contained 32 columns exclusive of the Time and Date. 
 
 ````r
head((arrange(count(mentalhealth_music_survey,Date),desc(n))), n=10)
ggplot(mentalhealth_music_survey, aes(x=Date)) + geom_bar(fill='red') +
  labs(title='Distribution of Survey Responses')
  ````
![image](https://user-images.githubusercontent.com/88348888/222712524-63753c78-75e5-41cf-9ad5-982685e8ba18.png)
#### The survey was open between 27th August and 9th November 2022 with majority of responses coming within the first two weeks ,i.e before 15th September. 

## The Survey Respondents
 ````r
summary (mentalhealth_music_survey$Age)
ggplot (data=mentalhealth_music_survey, mapping= aes (x=Age))+ 
  geom_histogram (fill='lightblue') + 
  scale_x_continuous(breaks = seq(0,100, 20)) + 
  labs(title='Age Distribustion of Survey Participants')
  ````

| Min    | 1st Quartile | Median | Mean  | 3rd Quartile | Maximum | NA's |
| -------| ------------ | ------ | ----- | ------------ | ------- | ---- |
| 10.00  | 18.00        | 21.00  | 25.21 | 28.00        | 89      | 1    |

![image](https://user-images.githubusercontent.com/88348888/222715661-21a98557-5957-4703-b206-b340449284ba.png)
#### Majority of the survey respondents are under 40years,with the youngest participant being 10 years and the oldest being 89 years. There is a good spread of the age.

 ````r
head(arrange(mentalhealth_music_survey %>% group_by(Age) %>% 
               summarise(no_of_respondents =n()),desc(no_of_respondents)), n=10)
  ````
| Age | no_of_respondents |
| --- | ----------------- |
| 18  | 85                |
| 19  | 61                |
| 17  | 59                |
| 21  | 52                |
| 16  | 44                |
| 20  | 40                |
| 22  | 39                |
| 23  | 37                |
| 25  | 22                |
| 26  | 22                |
#### The highest number of responses came from people between the ages of 17 and 26.

## Survey Respondents Music Streaming Platforms
### What Music streaming platforms did respondents use?
````r
unique(mentalhealth_music_survey$`Primary streaming service`)
  ````
"Spotify" "Pandora" "YouTube Music" "I do not use a streaming service" "Apple Music" "Other streaming service" NA 
###### Note; I changed "YouTube Music", "I do not use a streaming service", and "Other streaming service" to "YouTube", "None" and "Other" respectively for easy representation.

### Top Music Streaming Service of Respondents
````r
arrange((count(mentalhealth_music_survey, `Primary streaming service`)),
        desc(n))
  ````
|Primary streaming service | n   |
| ------------------------ | --- |
| Spotify                  | 458 |
| YouTube                  | 94  |
| None                     | 71  |
| Apple Music              | 51  |
| Other                    | 50  |
| Pandora                  | 11  |
| NA                       | 1   |

````r
ggplot(data = arrange((count(mentalhealth_music_survey,
                             `Primary streaming service`)), desc(n)),
       aes(x=reorder(`Primary streaming service`,-n),y=n))+
  geom_bar(stat="identity", fill='blue') + 
  labs(x='Sreaming Service',y='number of users',title="Streaming Services Used by Participants")
  ````

![image](https://user-images.githubusercontent.com/88348888/223396125-39356460-7a76-45eb-aad7-8f6017a14475.png)
#### Spotify was the preferred choice of participants and Pandora is the least used.

### Streaming services by Age of Users
````r
ggplot(mentalhealth_music_survey, aes(x=`Primary streaming service`, y=Age,fill=`Primary streaming service`)) +
  geom_boxplot()+  scale_fill_brewer(palette="Dark2")+ labs(title="Participant Age Profile of Music Streaming Services ")
  ````
 ![image](https://user-images.githubusercontent.com/88348888/223398004-f4d018bb-7a4c-4594-bc63-91feb2f129e8.png)
##### The older demography of the participants used Pandora while Apple Music, Spotify and YouTube Music had participants all under 30 years old.

## Survey Respondents' Listening Time per Day
````r
summary(mentalhealth_music_survey$`Hours per day`)
  ````
| Min    | 1st Quartile | Median | Mean  | 3rd Quartile | Maximum |
| -------| ------------ | ------ | ----- | ------------ | ------- |
| 0.00   |  2.00        |  3.00  |  3.57 |  5.00        | 24.00   |
#### The average listening time from the survey is 3.57 hours. However, there were respondents who claimed that they listened to music 24 hours and didn't listen to music at all;these are outliers.
````r
ggplot (data=mentalhealth_music_survey, mapping= aes (x= `Hours per day`))+ geom_histogram (fill="#69b3a2", color="#e9ecef", alpha=0.9) + 
  scale_x_continuous(breaks = seq(0,24, 5)) + labs(title="Music listening time of participants in hours/day ")
  ````
  ![image](https://user-images.githubusercontent.com/88348888/223401344-cf22be91-98d4-4386-83df-04325f3bc35b.png)

````r
head(arrange(count(mentalhealth_music_survey,`Hours per day`), desc(n)), n=10)
  ````
|Hours per day | n   |
| ------------ | --- |
| 2            | 173 |
| 3            | 120 |
| 1            | 117 |
| 4            | 83  |
| 5            | 54  |
| 6            | 47  |
| 8            | 29  |
| 0.5          | 20  |
| 10           | 20  |
| 1.5          | 17  |
#### Over half of the respondents listen to music between 1 and 3 hours daily. 

## Survey Respondent's Musical Background
````r
ggplot(data = count(mentalhealth_music_survey,`Instrumentalist`),mapping= aes(x=`Instrumentalist`,y=n, fill=`Instrumentalist`)) + 
  geom_bar(stat="identity") + labs(y='Number of persons',title="Participants Who are Instrumentalists")
  ````
  ![image](https://user-images.githubusercontent.com/88348888/223412082-dd9cea2d-1ded-425a-aeb1-2cd40f53f2b6.png)

````r
ggplot(data = count(mentalhealth_music_survey,`Composer`), mapping= aes(x=`Composer`,y=n, fill=`Composer`))+ 
  geom_bar(stat="identity")+ labs(y='Number of persons',title="Participants Who are Composers")
  ````
  ![image](https://user-images.githubusercontent.com/88348888/223412694-91389980-f661-4fd9-9c42-ab9c04f6a3d4.png)
#### From the graphs, majority of the participants are neither composers or instrumentalists. However, more of the survey respondents are instrumentalists compared to those who are composers.

## Correlation Analysis
### Musical Background, Age, Hours Listened to Music, Listened to Music while at work,Exploratory personality and Listening to Foreign Language
````r
MHM_corr <- mentalhealth_music_survey %>%
  select(Age,`Hours per day`,`While working`, Instrumentalist,Composer,Exploratory,`Foreign languages`)
MHM_corr <- MHM_corr %>% mutate(`While working`= recode(`While working`,'Yes'=1,'No'=0), Instrumentalist= recode(Instrumentalist,'Yes'=1,'No'=0),
                                Composer=recode(Composer,'Yes'=1,'No'=0),Exploratory=recode(Exploratory,'Yes'=1,'No'=0), 
                                `Foreign languages`= recode(`Foreign languages`, 'Yes'=1,'No'=0))
MHM_corr_table <- round((cor(MHM_corr,use = "complete.obs", method = c("pearson"))), 2)
corrplot(MHM_corr_table,method = "circle",type = "upper",order="hclust", tl.col = "black", tl.srt = 45, bg="black")
  ````
![image](https://user-images.githubusercontent.com/88348888/223414691-30e3d7df-9584-493b-91c3-1001d039727b.png)
#### There is slight correlation between Composers and Instrumentalists, hours per day listening to music and working, exploring music while working and listening to foreign music while exploring. This means the following:
#### - Those who are composers also play instruments
#### - Respondents listen to music mostly while they work.
#### - Respondents explore different genres of music while they work and, in their exploration, they listen to music from foreign languages.
#### On the other hand, the following have weak correlation; Age and Exploration, Age and Foreign language music. That is, listening to foreign language based music is irrespective of age and exploring music genres is irrespective of age.

### Survey Respondent Mental Health Based on Their Musical Background
````r
MHM_corr2 <- mentalhealth_music_survey %>%
  select(Instrumentalist,Composer,Anxiety,Depression,Insomnia,OCD)
MHM_corr2 <- MHM_corr2 %>% 
  mutate(Instrumentalist= recode(Instrumentalist,'Yes'=1,'No'=0),
         Composer=recode(Composer,'Yes'=1,'No'=0))
MHM_corr_table2 <- round(
  (cor(MHM_corr2,use = "complete.obs", method = c("pearson"))), 2)
corrplot(MHM_corr_table2,method = "circle",type = "upper",order="hclust", tl.col = "black", tl.srt = 45, bg="black")
  ````
  ![image](https://user-images.githubusercontent.com/88348888/223516403-378f5ce0-36ff-4bf9-a8a5-417c550e1568.png)
##### There is a slight correlation between mental health and musical background of respondents. In particular, between composers and their depression and insomnia levels; and between instrumentalists and their anxiety and depression levels. These need to be investigated further.
##### The correlation between the mental health parameters are stronger with Anxiety and Depression having the strongest correlation followed by Depression and Insomnia then Anxiety and OCD. This implies that respondents with anxiety are likely to have depression. This goes for depression and imsonia, and anxiety and OCD.

