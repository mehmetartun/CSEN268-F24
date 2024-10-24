## Santa Clara University - CSEN268 Fall 2024

### Lecture 9 - Part 2 - Google Maps implementation

In this part we add the following packages to the project
    google_maps_flutter
    geolocator
by issuing `flutter pub add <packagename1> <packagename2> ...`

### Getting a Google Maps API Key

Once you have a project and billing account setup in [Google Cloud](https://cloud.google.com/) you can create an **API Key** to connect to the Google Maps API. In either case for your **iOS**, **Android**, and **Web** apps it may be a good idea to get a separate API Key.

- For **Android** go to [Google Maps SDK for Android](https://developers.google.com/maps/documentation/android-sdk/get-api-key)
- For **iOS** go to [Google Maps SDK for iOS](https://developers.google.com/maps/documentation/ios-sdk/get-api-key)
- For **Web** go to [Google Maps API for Javascript](https://developers.google.com/maps/documentation/javascript/get-api-key)

In each case you should get an API Key for the corresponding platform. Select the corresponding API from the dropdown as shown below:

![API Key Selection](assets/images/MapsApiKeys.png)

### Placing the API Key in the App

#### Android

In the file `android/app/src/main/Androidmanifest.xml` place the following inside `<manifest>` and above `<application>`:
```xml
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
```
In the file `android/app/src/main/Androidmanifest.xml` place the following inside `<application>` , above  `<activity>`

```xml
        <meta-data android:name="com.google.android.geo.API_KEY"
                android:value="<Your Android Google Maps API Key>"/>
```

#### iOS

In the file `ios/Runner/AppDelegate.swift` add the following lines
```swift
import GoogleMaps
...
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("<Your iOS Google Maps API Key>")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
```

Also you need to include these permissions in your `ios/Runner/Info.plist` file
```xml
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>Access to the location is needed for the app when open.</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>Access to the location is needed when in the background.</string>
```

#### Web

In the file `web/index.html` you need to include your API Key in the `<head>` section.
```html
  <script src="https://maps.googleapis.com/maps/api/js?key=<Your Javascript Google Maps API Key>"></script>
```

### Placing the Google Maps Widget

```dart
GoogleMap(
        onMapCreated: (GoogleMapController controller){ }, // Callback issued when Map
        // is created. The controller of the Map is given. We need to
        // create a reference to this controller to be able to manipulate the map
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onCameraMove: (CameraPosition cameraPosition) {
        }, // Callback when camera is moving
        onCameraIdle: () async {
        }, // Callback when camera becomes idle
        initialCameraPosition: const CameraPosition(
            target: LatLng(51.3, 0),
            zoom: 18,
        ),
        markers: Set<Marker> markers, // a Set containing Markers to place on the Map
    );
```

To get a handle on the `MapController`, define a variable `mapController` and set it to the 
controller returned by the callback. In the same callback one could also set up listeners to position changes
so that the map is updated automatically. A sample callback on position updates would be:
```dart
late MapController mapController;
StreamSubscription<Position>? positionStreamSubscription;
...
  void onMapCreated(GoogleMapController controller) {
    await checkPermission();
    if (!hasPermission) {
      await requestPermission();
      if (!hasPermission) {
        return;
      }
    }
    mapController = controller;
    positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    )).listen((Position position) {
      mapController.animateCamera(CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude)));
    });
  }
```

Where we also created the following functions
```dart
  late LocationPermission permission;

  Future<void> checkPermission() async {
    permission = await Geolocator.checkPermission();
  }

  Future<void> requestPermission() async {
    permission = await Geolocator.requestPermission();
  }

  bool get hasPermission {
    return ![
      LocationPermission.denied,
      LocationPermission.deniedForever,
      LocationPermission.unableToDetermine
    ].contains(permission);
  }
```
Which checks for location permission and if it's not available or indeterminable, then it doesn't do the subscription. Otherwise it tries to get the permission and if it succeeds, it does do the subscription to 
location update whicn in turn moves the focus of the map.

### Setting up your environment before the lecture

Each lecture is stored under a separate tag. In your computer do the following

    git clone <Repository Name>
    git pull
    git tag -l

This will list you all the tags in the repository such as

    Lecture4
    Lecture5
    Lecture6
    ...

In order to pull a particular tag to your computer

    git checkout tags/Lecture5_start -b Lecture5_study



