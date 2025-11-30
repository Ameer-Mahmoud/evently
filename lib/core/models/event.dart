import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? id;
  String? userId;
  String? type;
  String? title;
  String? desc;
  Timestamp? dateTime;
  double? latitude;
  double? longitude;
  String? country;
  String? city;

  Event({
     this.id,
     this.userId,
     this.type,
     this.title,
     this.desc,
     this.dateTime,
     this.latitude,
     this.longitude,
    this.country,
    this.city,
  });

  factory Event.fromFirestore(Map<String, dynamic> data) {
    return Event(
      id: data['id'],
      userId: data['userId'],
      type: data['type'],
      title: data['title'],
      desc: data['desc'],
      dateTime: data['dateTime'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      city: data['city']?? "UnKnown",
      country: data['country']??"UnKnown" ,
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'title': title,
      'desc': desc,
      'dateTime': dateTime,
      'latitude': latitude,
      'longitude': longitude,
      "city": city,
      "country": country
    };
  }
}
