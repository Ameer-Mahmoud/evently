import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/models/event.dart';
import '../../../core/resources/AppConstants.dart';
import '../../../core/resources/dialogutils.dart';
import '../../../core/source/remote/fireStoremanager.dart';

class CreateEventProvider extends ChangeNotifier {

  CreateEventProvider() {
    log('Created');
    getUserLocation();
  }

  bool isInitialized = false; // ✅ عشان ما نعملش initEvent أكتر من مرة

  int selectedTap = 0;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );

  Set<Marker> markers = {};

  final Location location = Location();

  void changeSelectedTap(int tabIndex) {
    selectedTap = tabIndex;
    notifyListeners();
  }

  DateTime? selectedDate;

  Future<void> chooseDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (newDate != null) {
      selectedDate = newDate;
      notifyListeners();
    }
  }

  TimeOfDay? selectedTime;
  Future<void> chooseTime(BuildContext context) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (newTime != null) {
      selectedTime = newTime;
      notifyListeners();
    }
  }

  Future<bool> _getLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkLocationService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  void changeCameraPositionOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 17,
    );

    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
        infoWindow: const InfoWindow(
          title: 'My Location',
        ),
      ),
    );

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  Future<void> getUserLocation() async {
    bool isPermissionGranted = await _getLocationPermission();
    if (!isPermissionGranted) return;

    bool isGpsServiceEnabled = await _checkLocationService();
    if (!isGpsServiceEnabled) return;

    LocationData locationData = await location.getLocation();

    changeCameraPositionOnMap(locationData);
    notifyListeners();
  }

  LatLng? eventLocation;
  void changeEventLocation(LatLng location) {
    eventLocation = location;
    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: location,
        infoWindow: const InfoWindow(title: 'Event Location'),
      ),
    );
  }

  String? city;
  String? country;
  Future<void> convertLatLngForEvent() async {
    List<geocoding.Placemark> placeMarks = await geocoding
        .placemarkFromCoordinates(
      eventLocation?.latitude ?? 0,
      eventLocation?.longitude ?? 0,
    );
    if (placeMarks.isNotEmpty) {
      city = placeMarks.first.locality ?? 'UnKnown';
      country = placeMarks.first.country ?? 'UnKnown';
    }
    notifyListeners();
  }

  Future<void> createNewEvent(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (selectedDate != null &&
          selectedTime != null &&
          eventLocation != null) {
        Event event = Event(
          type: eventTypes[selectedTap],
          title: titleController.text,
          desc: descController.text,
          dateTime: Timestamp.fromDate(
            DateTime(
              selectedDate!.year,
              selectedDate!.month,
              selectedDate!.day,
              selectedTime!.hour,
              selectedTime!.minute,
            ),
          ),
          userId: FirebaseAuth.instance.currentUser!.uid,
          latitude: eventLocation?.latitude ?? 0,
          longitude: eventLocation?.longitude ?? 0,
          city: city,
          country: country,
        );
        DialogUtils.showLoadingDialog(context);
        await FireStoreManager.creatEvent(event);
        if (context.mounted) {
          Navigator.pop(context);
        }
        DialogUtils.showToast(context, "Event created successfully");
        if (context.mounted) {
          Navigator.pop(context);
        }
      } else {
        DialogUtils.showToast(
            context, "Please choose date and time or location");
      }
    }
  }

  Event? eventModel;
  void initEvent(Event? event) {
    if (event != null) {
      eventModel = event;
      titleController.text = event.title ?? '';
      descController.text = event.desc ?? '';
      eventLocation = LatLng(event.latitude ?? 0, event.longitude ?? 0);
      city = event.city;
      country = event.country;
      selectedDate = event.dateTime?.toDate();
      if (event.dateTime != null) {
        selectedTime = TimeOfDay.fromDateTime(event.dateTime!.toDate());
      }
      if (event.type != null) {
        selectedTap = eventTypes.indexOf(event.type!);
        if (selectedTap < 0) selectedTap = 0;
      }
      notifyListeners();
    }
  }

  Future<void> updateEvent(BuildContext context) async {
    if (formKey.currentState?.validate() == null) return;
    if (eventLocation == null && selectedDate == null && selectedTime == null) {
      return;
    }

    eventModel?.title = titleController.text;
    eventModel?.desc = descController.text;
    eventModel?.latitude = eventLocation?.latitude;
    eventModel?.longitude = eventLocation?.longitude;
    eventModel?.city = city;
    eventModel?.country = country;
    eventModel?.type = eventTypes[selectedTap];
    eventModel?.userId = FirebaseAuth.instance.currentUser!.uid;
    eventModel?.dateTime = Timestamp.fromDate(
      DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      ),
    );

    DialogUtils.showLoadingDialog(context);
    await FireStoreManager.updateEvent(eventModel!);

    if (context.mounted) Navigator.pop(context); // close loading
    DialogUtils.showToast(context, "Event updated successfully");

    if (context.mounted) Navigator.pop(context); // back screen
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }
}
