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
