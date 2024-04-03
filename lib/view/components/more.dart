import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../controller/firebase.dart';

class MoreInfo extends StatelessWidget {
  final String docID;
  final FirestoreService firestoreService = FirestoreService();

  MoreInfo({required this.docID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MORE INFOs'),
      ),
      body: FutureBuilder(
        future: firestoreService.getNoteById(docID), // Fetch data by docID
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}'); // Print error for tracking
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.data() == null) {
            return const Center(child: Text('No data found.'));
          } else {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors
                      .grey[200], // Adjust the color as per your requirement
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the value as per your requirement
                  border: Border.all(
                    color:
                        Color(0xFF856BEE), // Adjust the border color if needed
                    width: 1.0, // Adjust the border width if needed
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                      10.0), // Add padding to give some space between container edge and its content
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['companyName']),
                          Text(data['companyEmail']),
                          Text(data['jobOffer']),
                          Text(data['location']),
                          Text(data['salary']),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
