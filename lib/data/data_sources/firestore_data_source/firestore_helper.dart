import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirebaseFirestore _firestore;

  FirestoreHelper._privateConstructor(){
    _firestore ??= FirebaseFirestore.instance;
  }

  static final FirestoreHelper _instance = FirestoreHelper._privateConstructor();
  static FirestoreHelper get instance => _instance;

  CollectionReference getCollection(String collectionName) => _firestore.collection(collectionName);

  Future<DocumentSnapshot> getDocumentById(String collectionName, String id) => getCollection(collectionName).doc(id).get();

  Future<void> insertDocument(String collectionName, Map<String, dynamic> object) => getCollection(collectionName).add(object);

  deleteDocument(String collectionName, String id) => getCollection(collectionName).doc(id).delete();
}