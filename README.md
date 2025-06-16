# ServiceStand

### Description

ServiceStand is a simple iOS app that helps riders keep track of their maintenance as they rack up the miles on their gear. It uses Strava integration to keep track of the miles for each bike you ride.

### Future Improvements

* Additional ride services like Garmin, Trailforks, etc
* Appropriate calculation of service intervals, service history, as well as manual addition of service items performed
* Persistence. Both strava user as well as service items performed on gear.
* Online shopping integration for parts / service


### Getting Started
#### Requirements
* Xcode 16.4+
* iOS 18.5+
* Strava iOS app installed or logged into Strava in a web broswer

#### Usage
Open up the project in Xcode and select a compatible run device to run the app.


### Architecture

This initial iteration is using a Model-View style architecutre with SwiftUI for simplicity and ease.  Ideally, as the the codebase gets more complex, I would use something more robust like Clean, as I already ran into some archicture curfuffles.

### Tests

None at this moment.

### Dependencies
None

### Strava Integration
[Strava OAuth2.0](https://developers.strava.com/docs/authentication)

[Strava API reference](https://developers.strava.com/docs/reference)

