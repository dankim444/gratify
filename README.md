# Gratify

## Contributors
- Dan Kim (Backend)
- Kevin Zhou (Backend)
- Sam Jung (Ideation + UI Design)

## Problem Statement and Introduction
There’s real science that gratitude journals contribute to both our physical wellbeing and mental health. 
Gratify is a mobile application designed to cultivate a habit of gratitude and mindfulness in our daily lives. 
It does so by asking a user to rate how fulfilled they felt each day, how happy they felt each day, and a list of 3 things said user is grateful for thad day. 
The app will then have a month-long calendar graphic that will show the users “happiness” throughout that month, represented by different colors. 
This calendar graphic won’t be a calendar in the traditional sense—think a circular, futuristic graphic that displays the user’s happiness ratings across 
that month, with different colors on that graphic representing the user’s different moods throughout that month. The app will have a monthly report, 
a quarterly report, and a yearly report detailing the user’s happiness, and will integrate a GPT that takes in what users were grateful for throughout the 
entire period, and will summarize highlights/trends in what the user felt during that time. 

A lot of Penn culture focuses on getting things done—and we don’t usually have the time to stop and reflect on why we are doing some things, 
and what we feel from our daily experiences. We want to encourage users to stop, and reflect on their lives, to help them find more fulfillment in their everyday life.

## Project Overview
- **Title:** Gratify
- **Duration:** One week
- **Key Features:**
  - Minimalistic and intuitive UI
  - State-of-the-art user experience
  - Highly configurable user settings and profile management
  - Daily notification and reminders
  - Personalized AI reports of entries
  - Data persistence with Core Data
- **Goal:** Help users on their journeys toward daily gratitude and mindfulness.

## App Architecture
- **Views**
  - HomeView: Root of app
  - RatingView1: Allows user to rate their day
  - RatingView2: Allows user to enter text entries about 3 things they are grateful for
  - EntriesView: Shows a list and grid view of entries
  - MonthlyView: Custom summaries entries since the previous month
  - YearlyView: Custom summaries entries since the previous year
  - TutorialView: Teaches user how to use app
  - SettingsView: Allows user to configure profile settings
- **ViewModel**
  - ViewModel: Manages general data and state of the entire application
- **Models**
  - DailyEntry: Defines struct for each user entry
  - RequestModels: Defines structs for encodable gpt requests
  - ResponseModels: Defines structs to decode gpt responses
  - NotificationManager: Defines structs to handle notifications
  - AppDelegate: Handles app-level events and configurations for notifications

## Screenshots
![Simulator Screenshot - iPhone 15 Pro - 2024-09-08 at 13 54 44](https://github.com/user-attachments/assets/a7b0c93d-221c-4ffb-9bbd-f75905450905)
![Simulator Screenshot - iPhone 15 Pro - 2024-09-08 at 13 55 06](https://github.com/user-attachments/assets/4ab2d86b-8492-4c6a-a33b-231924478789)
![Simulator Screenshot - iPhone 15 Pro - 2024-09-08 at 13 56 37](https://github.com/user-attachments/assets/06608ac9-848a-493b-a83b-4c4997427ebc)
![Simulator Screenshot - iPhone 15 Pro - 2024-09-08 at 13 56 49](https://github.com/user-attachments/assets/2f41b38b-a811-4f8d-b079-e8830b564c79)




