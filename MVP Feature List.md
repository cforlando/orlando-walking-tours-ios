# Orlando Walking Tours
## MVP Feature List
--------
The purpose of the Orlando Walking Tours app is to provide users with the opportunity to put together their own self-guided walking tour of Orlando's many historic buildings and signs.  The following list details the features we would like to have implemented in order to release a minimum viable product (MVP).

### Tours
----
- A tour shall consist of, at minimum, a name for the tour and 1 or more locations.
- The user shall be able to create a new tour.
- The user shall be able to save tours.
- The user shall be able to delete tours they have previously created.
- The user *must* provide a name for new tours.
- The user shall be able to add locations to their tour.
- The user *must* add at least one location to their tour.
- The user shall be able to remove locations from their tour.
- The user shall be able to manually rearrange locations in their tour.
- The user shall be able to view the locations in their tour on a map.
- The user shall be able to view the locations in their tour in a list
- Once a tour has been created, the user shall be given the option to start their tour.
  - The user shall be given walking directions from one location to the next in the order that said locations are listed in the tour.

### Locations
----
- A location shall consist of the following properties:
  - a name
  - an address
  - a description
  - latitude/longitude coordinates
  - one or more photos
- Locations may also contain one or both of the following properties:
  - the date on which it was added to Orlando's list of Historic Local Landmarks and Landmark Signs
  - the date on which it was added to the National Registry of Historic Places
- The user shall be able to view all locations on a map.
  - Tapping on the place marker of a location on the map shall display a callout consisting of a thumbnail image and the name of the location.
  - Tapping on this callout shall bring the user to a view showing detailed information about the location.
- The user shall be able to view all locations in a list.
  - Each list item shall consist of a thumbnail image of the location as well as the name of the location.
  - Tapping on a list item for a location shall bring the user to a view showing detailed information about the location.
  - The user shall be given the option to sort locations by distance from the user's current location.
