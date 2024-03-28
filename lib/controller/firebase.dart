import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // READ
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

  // CREATE
  Future<void> addNotes(String companyEmail, String companyName,
      String jobOffer, String location, String salary) {
    return posts.add({
      'companyEmail': companyEmail,
      'companyName': companyName,
      'id': 'emailAsId$companyEmail',
      'jobOffer': jobOffer,
      'location': location,
      'salary': salary,
    });
  }

  Stream<QuerySnapshot> getNotesStream() {
    final notesStream = posts.orderBy('id', descending: true).snapshots();
    return notesStream;
  }
}
