import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference<Map<String, dynamic>> busesCollection =
    firestore.collection('buses');
CollectionReference<Map<String, dynamic>> driversCollection =
    firestore.collection('drivers');
CollectionReference<Map<String, dynamic>> saccoCollection =
    firestore.collection('saccos');
CollectionReference<Map<String, dynamic>> busRoutesCollection =
    firestore.collection('routes');
CollectionReference<Map<String, dynamic>> busStationCollection =
    firestore.collection('bus_stations');
