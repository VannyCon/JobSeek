import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<String> getImageUrl(String imageName) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('Images').child(imageName);
    final url = await storageRef.getDownloadURL();
    return url;
  }
}

// AUTHSERVICE CLASS
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
