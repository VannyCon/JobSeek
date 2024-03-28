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
      'timestamp': Timestamp.now(),
    });
  }

// READ
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        posts.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  //Return Content of a specific Note (by id)
  Future<DocumentSnapshot> getNoteById(String docID) async {
    final noteDocument = await posts.doc(docID).get();
    return noteDocument;
  }

// Update the Conent
  Future<void> updateNotes(String docID, String companyEmail,
      String companyName, String jobOffer, String location, String salary) {
    return posts.doc(docID).update({
      'companyEmail': companyEmail,
      'companyName': companyName,
      'id': 'emailAsId$companyEmail',
      'jobOffer': jobOffer,
      'location': location,
      'salary': salary,
    });
  }

  Future<void> deleteNote(String docID) async {
    return posts.doc(docID).delete();
  }
}
