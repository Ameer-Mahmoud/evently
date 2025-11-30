import 'package:evently_c16/core/models/event.dart';
import 'package:evently_c16/core/source/remote/fireStoremanager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTapProvider extends ChangeNotifier{
  MapTapProvider(){
    getUserLocation();
    getEvents();
  }
  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );
  Set <Marker> markers = {};
  List<Event> events = [];

String getEventImage (Event event){
  if(event.type == 'book'){
    return "assets/images/Book Club.png";
  }else if(event.type == 'sport' ){
    return "assets/images/sport.png";
  } else{
    return "assets/images/birthday.png";
  }
}
void navigateToEventLocationOnMap (LatLng location, Event event){
  cameraPosition =CameraPosition(
      target: location,
    zoom: 17,
  );
  markers.add(Marker(markerId: MarkerId(UniqueKey().toString()),
      position: location,
      infoWindow: InfoWindow(title:
      event.title,
      snippet: event.desc)
  ),
  );
  mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  notifyListeners();
}

  Future <void> getEvents ()async{
    events = await FireStoreManager.getAllEvents();
    notifyListeners();
  }

  final Location location = Location();
  String locationMessage = "";

  Future <bool> _getLocationPermission() async {

    PermissionStatus permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;

  }
  Future <bool> _checkLocationService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled){
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }
  void changeToMyLocation (LocationData locationData){
    cameraPosition = CameraPosition(target: LatLng(
        locationData.latitude?? 0,
        locationData.longitude?? 0),
        zoom: 17
    );
    markers.add(Marker(markerId: MarkerId("1"),
        position: LatLng(
            locationData.latitude?? 0,
            locationData.longitude?? 0),
        infoWindow: const InfoWindow(title:
        "My Location")
    ),
    );


    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }

  Future<void> getUserLocation ()async{
    bool isPermissionGranted = await _getLocationPermission ();
    if (!isPermissionGranted){
      return;
    }
    bool isGpsServiceEnabled = await _checkLocationService();
    if(!isGpsServiceEnabled){
      return;
    }

    LocationData locationData = await location.getLocation();

    changeToMyLocation(locationData);

    notifyListeners();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}