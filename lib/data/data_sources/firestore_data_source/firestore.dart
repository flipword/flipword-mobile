import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  FirebaseFirestore firestore;

  Firestore._privateConstructor(){
    firestore ??= FirebaseFirestore.instance;
  }

  static final Firestore _instance = Firestore._privateConstructor();
  static Firestore get instance => _instance;

  CollectionReference getCollection(String collectionName) => firestore.collection(collectionName);

  Future<DocumentSnapshot> getDocumentById(String collectionName, String id) => getCollection(collectionName).doc(id).get();

  Future<void> insertDocument(String collectionName, Map<String, dynamic> object) => getCollection(collectionName).add(object);

  deleteDocument(String collectionName, String id) => getCollection(collectionName).doc(id).delete();
}