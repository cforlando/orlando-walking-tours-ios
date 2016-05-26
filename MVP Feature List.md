# Orlando Walking Tours
--------
The purpose of the Orlando Walking Tours app is to provide users with the opportunity to put together their own self-guided walking tour of Orlando's many historic buildings and signs.  The following list details the features we would like to have implemented in order to release a minimum viable product (MVP).

##### Dashboard View
----
- The user shall be able to create a new walking tour.
- The dasboard shall display up to 6 images of various locations once a user creates a tour.
- The user shall be able to delete tours from the dashboard.

##### New Tour View
----
- The user shall be able to give their new tour a name.

##### Current Tour View
----
- The user shall be able to add historic locations to their tour.
- The user shall be able to delete historic locations from their tour.
- The user shall be able to manually re-order the historic locations in their tour.
- The user shall be able to view locations in their tour in either a list view or a map view.

##### Map View of Locations *
----
- The user shall be able to view all historic locations on a map view.
- The user shall see a thumbnail image and name for each location in a map call out.

##### List/Table View of Locations *
----
- The user shall be able to view all historic locations in a list view/table view.
- When viewing locations in list view, the list shall be sortable by distance from the user's current location.
- The user shall see a thumbnail image of each location in the list view.
- A loading indicator shall be displayed while the list of locations is loading.
- The user shall be able to add a location in the list view to their tour, when applicable.
- If a user adds a location from the list view to their tour, that location shall be removed from the list view.
- The user shall be able to delete a location in the list view from their tour, when applicable.

##### Location Detail View
----
- The user shall be able to view a detailed description of each historic location.
- This detailed location view shall contain one or more photos of the location, a map view showing where the location is, the name of the location, the address of the location, a description of the location, the date when the locations was added to either the Orlando Historic Landmarks or the National Registry of Historic Places, if applicable, as well as a button to save that location to the user's tour, if applicable.
- The save button on the loation detail view shall only be available if the location has not already been added to the user's tour.
- Tapping on the map view shall bring up a full screen map of the area.

##### Under the Hood
----
- The user's tours shall be saved to a persistent store on the user's device.

* These views shall be used both when the user is selecting locations to put into their tours and also to display the locations in a tour that has already been created.
