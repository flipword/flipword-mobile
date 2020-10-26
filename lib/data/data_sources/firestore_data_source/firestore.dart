import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {

  Firestore._privateConstructor(){
    firestore ??= FirebaseFirestore.instance;
  }

  FirebaseFirestore firestore;
  static final Firestore _instance = Firestore._privateConstructor();
  static Firestore get instance => _instance;

  CollectionReference getCollection(
      String collectionName
      ) => firestore.collection(collectionName);

  Future<DocumentSnapshot> getDocumentById(
      String collectionName, String id
      ) => getCollection(collectionName).doc(id).get();

  Future<void> insertDocument(
      String collectionName, Map<String, dynamic> object
      ) => getCollection(collectionName).add(object);

  Future<void> deleteDocument(
      String collectionName, String id
      ) => getCollection(collectionName).doc(id).delete();
}