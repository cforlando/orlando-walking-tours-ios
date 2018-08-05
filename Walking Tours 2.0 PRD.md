# Walking Tours 2.0 - Mobile/Web (User Facing)

## **Objective**

### **Who is this product/feature for?**
The target audience for this application is anyone travelling, or even living in a city who wish to learn more about their location. An example of this is a traveller coming to Orlando for a vacation and while here would like to learn about the history of the town by walking around the streets and being given information about their current location. This experience could be similar to how a person walks through a museaum on a guided audio tour.

### **Which problem are you trying to solve?**
Currently the way to find information is by scouring the internet looking for content. It easily accessible and is scattered over multiple websites. 

### **What is the goal of this feature?**
The goal and main feature of this application is to give a user easy and contextual information about their current location.

### **What will this feature do, and what will it not do?**
| Will do | Won't do|
| ------- | ------- |
| Track users location | Crowd source information |
| Display multiple points of interest| Track and store user's location on a remote server |
| Transfer user to a mapping application for directions | Allow user's to upload their own content|
| POI can be selected to show information||
| Search for POI ||

## **Core Components**
* Map
* Location tracking
* Locate user on the map
* Dynamic list of POIs
* Search for POI
* Show POI Information
    * Title
    * Description
    * Installation date - optional
    * Location
        * Human readable address
        * GPS co-ordinates
    * Images
    * Videos?
* Hand off directions to POI to a mapping application

## **User flow**
* Main View
    * Load map
    * User can see their location
    * POIs can be seen on the map
    * User can tap POI for a callout and more information
    * User can tap a search button
* Search View
    * Should show a list of all POIs currently loaded/store in local DB
    * User can search by name only
    * List updates with every new/deleted character and returns probably matches
    * User can tap a POI 
* POI Infomation
    * Presents basic information about the POI
        * Title
        * Description
        * Installation date - optional
        * Location
            * Human readable address
            * GPS co-ordinates
        * An image of the POI if applicable
