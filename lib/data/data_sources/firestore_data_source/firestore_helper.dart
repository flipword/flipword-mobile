import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._privateConstructor(){
    _firestore ??= FirebaseFirestore.instance;
  }

  FirebaseFirestore? _firestore;

  static final FirestoreHelper _instance = FirestoreHelper._privateConstructor();
  static FirestoreHelper get instance => _instance;

  CollectionReference getCollection(String collectionName) => _firestore!.collection(collectionName);

  Future<DocumentSnapshot> getDocumentById(String collectionName, String id) => getCollection(collectionName).doc(id).get();

  Future<void> insertDocument(String collectionName, Map<String, dynamic> object) => getCollection(collectionName).add(object);

  Future<void> deleteDocument(String collectionName, String id) => getCollection(collectionName).doc(id).delete();



}