import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // READ
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

  // CREATE
  Future<void> addNotes(String note) {
    return posts.add({
      'companyEmail': 'test@gmail.com',
      'companyName': 'Test Company',
      'id': '1',
      'jobOffer': 'Software Engineer',
      'location': 'Ph',
      'salary': '20,000',
    });
  }
}
