A personal health tracker application

**Technologies used:**
Flutter
Firebase(Firestore, Firebase analytics)

**Description:**


Welcome screen:

![welcome_screen](https://user-images.githubusercontent.com/66864613/166236203-75239cb3-17d1-4d82-92ef-75a8a872efee.png)


Tracker listing screen:
 - Displays a list of health trackers, Weight(in Kgs), Sleep(in hours), Daily Exercise(in minutes)

![tracker_listing_screen](https://user-images.githubusercontent.com/66864613/166234248-6f7f378c-f6ed-4257-a723-faed4b2783b2.png)

Tracker detail screen:
 - Shows all tracking entries for the above tracker sorted by recent date
 - Data fetched from Firestore
 - Graph plotted to represent fetched data
 
 ![tracker_detail_Screen](https://user-images.githubusercontent.com/66864613/166234622-e6a9cfd8-194c-4638-be2a-f4d99cb6f3ad.png)

Add entry form:
 - Ability to add a new entry to the selected tracker with date being the mandatory field
 
 ![add_entry_form_screen](https://user-images.githubusercontent.com/66864613/166234743-61c1603a-c1ce-4ba2-96ca-9bdf66d070a1.png)

Edit entry form:
  - Ability to edit an existing entry

![edit_entry_form_screen](https://user-images.githubusercontent.com/66864613/166234809-c7077351-d47d-4723-970d-c24a2ff2e4d3.png)

Analytics:
 - Button clicks, navigation between pages, time spent on a page are being tracked using Firebase analytics

**Technical details:**
  - State management – State communication between different components is being managed using Provider
  - A modular, reusable code has been developed that allows easier maintenance of code and is based on sound software design principles and patterns.
  - Reusibility of code was focused upon while development
  - Use of object-oriented concepts such as polymorphism, inheritance, composition have been used where necessary

