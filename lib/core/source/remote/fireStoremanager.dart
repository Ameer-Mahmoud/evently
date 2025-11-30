import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../models/event.dart';
import '../../models/user.dart';

class FireStoreManager {
  static getUserCollection(){
    var collection =
    FirebaseFirestore.instance.collection("user").withConverter(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        var user = User.fromFireStore(data);
        return user;
      },
      toFirestore: (user, options) {
        return user.toFireStore();
      },
    );
    return collection;

  }

  static Future <void> addUser ( User user) {
    var collection = getUserCollection();

    var doc = collection.doc(user.id);
    return doc.set(user);

  }

   static Future<User?> getUser ( String userId) async{
    var collection = getUserCollection();
    var doc =  collection.doc(userId);
    var snapshot =  await doc.get();
    return snapshot.data();
   }
  static CollectionReference<Event> getEventCollection() {
    var collection = FirebaseFirestore.instance.collection("Event").withConverter<Event>(
      fromFirestore: (snapshot, _) {
        var data = snapshot.data();
        return Event.fromFirestore(data!);
      },
      toFirestore: (event, _) => event.toFirestore(),
    );
    return collection;
  }
   static Future  <void> creatEvent(Event event){
    var collection = getEventCollection();
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
  static Future<List<Event>> getAllEvents() async {
    var collection = getEventCollection();
    var querySnapshot = await collection.get();
    var docList = querySnapshot.docs;
    var eventList = docList.map((document) => document.data()).toList();
    return eventList;
  }


  static Stream <List<Event>> getAllEventsStream() {
    var collection = getEventCollection();
    var querySnapshotStream =  collection.snapshots();
     var docsStream = querySnapshotStream.map((quarySnapshot) => quarySnapshot.docs,);
     var eventsStream = docsStream.map((docs) =>docs.map((doc) => doc.data()).toList());
    return eventsStream;

  }
  static Future<List<Event>> getTypeEvents(String type) async {
    var collection = getEventCollection().where("type",isEqualTo: type);
    var querySnapshot = await collection.get();
    var docList = querySnapshot.docs;
    var eventList = docList.map((document) => document.data()).toList();
    return eventList;
  }
  static CollectionReference<Event> getWishListCollection() {
    var userDoc =
    getUserCollection().doc(auth.FirebaseAuth.instance.currentUser!.uid);

    return userDoc.collection("wishlist").withConverter<Event>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data();
        return Event.fromFirestore(data!);
      },
      toFirestore: (Event event, _) {
        return event.toFirestore();
      },
    );
  }



  static Future<void> addEventWishList(Event event) {
    var collection = getWishListCollection();
    var doc = collection.doc(event.id);
    return doc.set(event);
  }

  static Future<void> deleteEventWishList(Event event) {
    var collection = getWishListCollection();
    var doc = collection.doc(event.id);
    return doc.delete();
  }

  static Future<List<Event>> getUserWishList() async {
    var collection = getWishListCollection();
    var querySnapshot = await collection.get();
    var docList = querySnapshot.docs;
    var eventList = docList.map((document) => document.data()).toList();
    return eventList;
  }


  static Future<void> updateUserWishlist(List<String> fav) async {
    var collection =  getUserCollection();
    var doc = collection.doc(auth.FirebaseAuth.instance.currentUser!.uid);
    return doc.update({"wishlist":fav});
  }
  static Future<void> deleteEvent(String eventId) async {
    await getEventCollection().doc(eventId).delete();
  }

  static Future<void> updateEvent(Event event) async {
    await getEventCollection().doc(event.id).update(event.toFirestore());
  }
  static Future<void> updateUserImage(String base64) async {
    var collection = getUserCollection();
    var doc = collection.doc(auth.FirebaseAuth.instance.currentUser!.uid);
    return doc.update({"image": base64});
  }



}