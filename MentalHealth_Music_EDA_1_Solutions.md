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

## Survey Respondents General Mental Health
### Anxiety
````r
ggplot(data=mentalhealth_music_survey,aes(x= Anxiety)) + geom_bar(fill='black')+ 
  scale_x_continuous(breaks = seq(0,10, 2)) + 
  labs(y='participant count', title = 'Participant Anxiety Scores')
  ````
![image](https://user-images.githubusercontent.com/88348888/224380283-5b953a83-eb8a-4ec6-a867-34a366a3ac44.png)

````r
round(mean(mentalhealth_music_survey$Anxiety),2)
  ````
'5.82'
````r
arrange(count(mentalhealth_music_survey, Anxiety),desc(n))
  ````
|Anxiety | n   |
| ------ | --- |
| 7      | 122 |
| 8      | 115 |
| 6      | 83  |
| 3      | 69  |
| 10     | 67  |
| 5      | 59  |
| 4      | 56  |
| 9      | 56  |
| 2      | 44  |
| 0      | 35  |
| 1      | 29  |
| 7.5    | 1   |
##### Most respondents indicated that they experience high levels of Anxiety, i.e. Anxiety score greater than 5.

### Depression
````r
ggplot(data=mentalhealth_music_survey,aes(x= Depression)) + geom_bar(fill='black')+ 
  scale_x_continuous(breaks = seq(0,10, 2))+
  labs(y='participant count',title = 'Participant Depression Scores')
  ````
![image](https://user-images.githubusercontent.com/88348888/224395170-1975cc80-b48f-45d0-b5a3-1d0af63a443a.png)
````r
arrange(count(mentalhealth_music_survey,Depression),desc(n))
  ````
|Depression | n   |
| --------- | --- |
| 7         | 96  |
| 2         | 93  |
| 6         | 88  |
| 0         | 84  |
| 8         | 77  |
| 3         | 59  |
| 4         | 58  |
| 5         | 56  |
| 10        | 45  |
| 1         | 40  |
| 9         | 38  |
| 3.5       | 2   |
#### There is a spread of survey respondents across the Depression scores.

### Insomnia
````r
ggplot(data=mentalhealth_music_survey,aes(x= Insomnia)) + geom_bar(fill='black')+ 
   scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(y='participant count', title = 'Insomnia Scores')
  ````
![image](https://user-images.githubusercontent.com/88348888/224398491-e1aa3ada-c0bd-46ab-b9f3-ced7e84a05a8.png)

````r
arrange(count(mentalhealth_music_survey,Insomnia),desc(n))
  ````
|Insomnia   | n   |
| --------- | --- |
| 0         | 149 |
| 2         | 88  |
| 1         | 82  |
| 3         | 68  |
| 6         | 62  |
| 4         | 59  |
| 7         | 59  |
| 5         | 58  |
| 8         | 49  |
| 10        | 34  |
| 9         | 27  |
| 3.5       | 1   |
#### Majority of the survey respondents have low Insomnia levels, i.e. an Insomnia score less than 5.

### OCD
````r
ggplot(data=mentalhealth_music_survey,aes(x= OCD)) + geom_bar(fill='black')+ 
scale_x_continuous(breaks = seq(0,10, 2))+
  labs(y='participant count', title = 'OCD Scores')
  ````
![image](https://user-images.githubusercontent.com/88348888/224402513-c27a97a0-99b6-4ec1-a7ec-0e789c6c219e.png)

````r
arrange(count(mentalhealth_music_survey,OCD),desc(n))
  ````
|OCD        | n   |
| --------- | --- |
| 0         | 249 |
| 2         | 96  |
| 1         | 95  |
| 3         | 64  |
| 5         | 54  |
| 4         | 48  |
| 7         | 34  |
| 6         | 33  |
| 8         | 28  |
| 10        | 20  |
| 9         | 14  |
| 5.5       | 1   |
| 8.5       | 1   |
#### Similar with Insomnia levels, majority of survey respondents registered low OCD levels.
#### In summary, majority of the participants have low insomnia and OCD scores while a considerable amount of participants indicated that they have high anxiety and depression scores.

## Survey Respondent Mental Health Based on Their Musical Background- Extended Analysis
### Anxiety
### Anxiety levels of instrumentalists and non-instrumentalists
````r
ggplot(data = count(Instrumentalist,Anxiety), mapping = aes(x = Anxiety,y= n))+
  geom_bar(stat='identity',fill='black')+ labs(x='Anxiety Score',y= 'Participant Count') + 
  labs(title = 'Instrumentalists with Anxiety')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/223984967-6b01755b-adc5-4159-a3aa-57d33e84ccc7.png)

````r
ggplot(data = count(Non_Instrusmentalist,Anxiety),
       mapping = aes(x = Anxiety,y= n))+ geom_bar(stat='identity',fill='red') + 
  labs(x='Anxiety Score',y= 'Participant Count',title = 'Non-Instrumentalists with Anxiety')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/223986614-5459700c-ad92-4d7b-a4dd-6eeedc119535.png)
##### Although high anxiety levels are prevalent in the entire dataset, most respondents who are instrumentalists experience high anxiety levels (over the midpoint of 5). 

### Anxiety levels of composers and non-composers
````r
ggplot(data = count(Composer,Anxiety), mapping = aes(x = Anxiety,y= n))+
  geom_bar(stat='identity',fill='purple') +
  labs(x='Anxiety Score',y= 'Participant Count',title = 'Composers with Anxiety')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/223988870-5a73c205-abcd-4e8e-a5ec-ee12f225a57c.png)
````r
ggplot(data = count(Non_Composer,Anxiety), mapping = aes(x = Anxiety,y= n))+
  geom_bar(stat='identity',fill='lightblue') + 
  labs(x='Anxiety Score',y= 'Participant Count',title = 'Non-Composers with Anxiety')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/223989263-d75d97c6-da00-478e-8ade-369dca325e96.png)
##### The trend in very similar to those of the instrumentalists and non-instrumentalists.

### Depression
### Depression levels of instrumentalists and non-instrumentalists
````r
ggplot(data = count(Instrumentalist,Depression), mapping = aes(x = Depression,y= n))+
  geom_bar(stat='identity',fill='black')+ scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Depression Score',y= 'Participant Count', title = 'Instrumentalists with Depression')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/223993083-70558358-68d2-486b-b072-3c1da7f18067.png)
  ````r
ggplot(data = count(Non_Instrusmentalist,Depression),mapping = aes(x = Depression,y= n))+ 
  geom_bar(stat='identity',fill='red') + scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Depression Score',y= 'Participant Count', title = 'Non-Instrumentalists with Depression')
  ````
![image](https://user-images.githubusercontent.com/88348888/223994051-ec8c759d-bfff-4b91-a624-6bfcda8de8d9.png)
#### There is no standout trend in the depression levels amongst intrusmentalists and non-instrumentalists. The spread of those who experience high and low depression levels in this category is fairly similar.

### Depression levels of composers and non-composers
````r
ggplot(data = count(Composer,Depression), mapping = aes(x = Depression,y= n))+
  geom_bar(stat='identity',fill='purple') + scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Depression Score',y= 'Participant Count', title = 'Composers with Depression')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/223996849-b249018e-f40c-4e3f-83f0-b6f8885d0530.png)
  ````r
ggplot(data = count(Non_Composer,Depression),mapping = aes(x = Depression,y= n))+
  geom_bar(stat='identity',fill='lightblue')+ scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Depression Score',y= 'Participant Count',title = 'Non-Composers with Depression')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/223998217-e76e6237-9ceb-47a8-a063-c3d35efce03b.png)
#### There is an obvious trend showing that most composers experience high levels of depression. Amongsts non-composers, there is an even spread between high and low depression levels.

### Insomnia
### Insomnia levels of instrumentalists and non-instrumentalists
  ````r
ggplot(data = count(Instrumentalist,Insomnia), mapping = aes(x = Insomnia,y= n))+
geom_bar(stat='identity',fill='black')+ scale_x_continuous(breaks = seq(0,10, 2))+ 
labs(x='Insomnia Score',y= 'Participant Count',title = 'Instrumentalists with Insomnia')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/224000066-d477ab9b-66d7-4453-8717-ff6b80e50742.png)
 ````r
ggplot(data = count(Non_Instrusmentalist,Insomnia),mapping = aes(x = Insomnia,y= n))+ 
  geom_bar(stat='identity',fill='red') + scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Insomnia Score',y= 'Participant Count',title = 'Non-Instrumentalists with Insomnia')
  ````
 ![image](https://user-images.githubusercontent.com/88348888/224000452-6dfa5ea1-efba-4098-9c9b-8bee09b12361.png)
#### The dataset shows that most of the instrumentalists and non-instrumentalists exhibit extremely low levels of insomnia (less than 3).

### Insomnia levels of composers and non-composers
 ````r
ggplot(data = count(Composer,Insomnia), mapping = aes(x = Insomnia,y= n))+
  geom_bar(stat='identity',fill='purple') + scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Insomnia Score',y= 'Participant Count', title = 'Composers with Insomnia')
  ````
![image](https://user-images.githubusercontent.com/88348888/224002095-84e4fef0-01eb-4e82-8cda-21f7f98da7b3.png)
 ````r
ggplot(data = count(Non_Composer,Insomnia),mapping = aes(x = Insomnia,y= n))+
  geom_bar(stat='identity',fill='lightblue')+ scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='Insomnia Score',y= 'Participant Count',title = 'Non-Composers with Insomnia')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/224002497-338534af-92e9-4117-be4b-2c9bfa0aee19.png)
#### Although most of the composers indicated low levels of insomnia, a significant amount also showed high levels of insomnia.

### OCD
### OCD levels of instrumentalists and non-instrumentalists
 ````r
ggplot(data = count(Instrumentalist,OCD), mapping =aes(x = OCD,y= n))+
geom_bar(stat='identity',fill='black')+ scale_x_continuous(breaks = seq(0,10, 2))+  
labs(x='OCD Score',y= 'Participant Count',title = 'Instrumentalists with OCD')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/224004860-13833264-2ad8-4f08-afc6-501a182debfc.png)
 ````r
ggplot(data = count(Non_Instrusmentalist,OCD),mapping = aes(x = OCD,y= n))+ 
  geom_bar(stat='identity',fill='red') +  scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='OCD Score',y= 'Participant Count',title = 'Non-Instrumentalists with OCD')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/224005142-38b7e2b3-789a-4b67-bc44-c0c00a8730ce.png)
#### Majority of instrumentalists and non-instrumentalists show extremely low levels of OCD.

### OCD levels of composers and non-composers
 ````r
ggplot(data = count(Composer,OCD), mapping = aes(x = OCD,y= n))+
  geom_bar(stat='identity',fill='purple') + scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='OCD Score',y= 'Participant Count',title = 'Composers with OCD')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/224005875-8ebd1d91-e767-4ae8-ab01-14ce20b7d413.png)
   ````r
ggplot(data = count(Non_Composer,OCD), mapping = aes(x = OCD,y= n))+
  geom_bar(stat='identity',fill='lightblue')+ scale_x_continuous(breaks = seq(0,10, 2))+ 
  labs(x='OCD Score',y= 'Participant Count',title = 'Non-Composers with OCD')
  ````
![image](https://user-images.githubusercontent.com/88348888/224006798-fd2fd053-7b88-4fd3-a8bf-c5817aa2529a.png)
#### As is with the instrumentalists, majority composers and non-composers show extremely low levels of OCD.

#### In summary, survey respondents who are instrumentalists and composers experienced high levels of anxiety. In addition, composers also experienced high levels of depression. It is possible that those composers who suffer depression also suffer from insomnia though the number isn't high.

## Extremely High Mental Health (i.e scores greater 8) versus Average Music Listening Times
### Creation of new datasets for extremely high mental health and the averages
  ````r
E_Anxiety <- mentalhealth_music_survey %>% select(`Hours per day`,Anxiety) %>%
  filter(Anxiety > 8) 
E_Depression <- mentalhealth_music_survey %>% 
  select(`Hours per day`,Depression) %>%  filter(Depression >8)
E_Insomnia <- mentalhealth_music_survey %>% 
  select(`Hours per day`,Insomnia) %>%  filter(Insomnia > 8)
E_OCD <- mentalhealth_music_survey %>% 
  select(`Hours per day`,OCD) %>%  filter(OCD > 8)
EMH_avgMusicTime <- data.frame( 
  Mental_Health = c('Anxiety','Depression','Insomnia','OCD'), 
  Avg_Music_Time = c((round(mean(E_Anxiety$`Hours per day`),2)),
                     (round(mean(E_Depression$`Hours per day`),2)),
                     (round(mean(E_Insomnia$`Hours per day`),2)),
                     (round(mean(E_OCD$`Hours per day`),2))),
  stringsAsFactors = FALSE)
  ````
  ### Extremely High Mental Health versus Average Listening Time Analysis
   ````r
   ggplot(data = EMH_avgMusicTime, aes(x=Avg_Music_Time,y=Mental_Health, fill=Mental_Health))+ 
  geom_bar(stat = 'identity') +  
  labs(x='Average Time Listened to Music',y= 'Mental Health',
       title = 'Average Time Listened to Music of Participants with Extremely High Mental Health Issues')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/224410899-f3005b7e-7251-4f06-a12c-a2415de4952e.png)
#### Survey respondents with extreme insomnia spend a lot more time listening to music , over 5 hours daily, than respondents with other extreme mental health issues. Possibly this replaces sleep.

##  Extremely Low Mental Health (i.e. scores less than 3) vs Average Time Listened to Music
### Creation of new datasets for extremely low mental health and the averages
  ````r
EL_Anxiety <- mentalhealth_music_survey %>% select(`Hours per day`,Anxiety) %>%
  filter(Anxiety < 3) 
EL_Depression <- mentalhealth_music_survey %>% 
  select(`Hours per day`,Depression) %>%  filter(Depression <3)
EL_Insomnia <- mentalhealth_music_survey %>% 
  select(`Hours per day`,Insomnia) %>%  filter(Insomnia <3)
EL_OCD <- mentalhealth_music_survey %>% 
  select(`Hours per day`,OCD) %>%  filter(OCD <3)
ELMH_avgMusicTime <- data.frame( 
  Mental_Health = c('Anxiety','Depression','Insomnia','OCD'), 
  Avg_Music_Time = c((round(mean(EL_Anxiety$`Hours per day`),2)),
                     (round(mean(EL_Depression$`Hours per day`),2)),
                     (round(mean(EL_Insomnia$`Hours per day`),2)),
                     (round(mean(EL_OCD$`Hours per day`),2))),
  stringsAsFactors = FALSE)
  ````
### Extremely Low Mental Health versus Average Listening Time Analysis
   ````r
 ggplot(data = ELMH_avgMusicTime, aes(x=Avg_Music_Time,y=Mental_Health, fill=Mental_Health))+ 
  geom_bar(stat = 'identity') +  
  labs(x='Average Time Listened to Music',y= 'Mental Health',
       title = 'Average Time Listened to Music of Participants with Extremely Low Mental Health Issues')
  ````
  ![image](https://user-images.githubusercontent.com/88348888/224412983-ea1b010d-5d33-48fa-bacc-90837172ca08.png)
