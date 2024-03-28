import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_app/controller/firebase.dart';

class HomeContent extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getNotesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading... the Data');
        }
        if (!snapshot.hasData) {
          print("No data found");
          return Text('No data found');
        }
        List notesList = snapshot.data!.docs;
        print("Length of notesList: ${notesList.length}");
        return ListView.builder(
          itemCount: notesList.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = notesList[index];
            String docId = document.id;
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            print("Data for document $docId: $data"); // Debug print for data
            String companyName = data['companyName'];
            String companyEmail = data['companyEmail'];
            String jobOffer = data['jobOffer'];
            String location = data['location'];
            String salary = data['salary'];

            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(companyName),
                  Text(companyEmail),
                  Text(jobOffer),
                  Text(location),
                  Text(salary),
                ],
              ),

              // Display other fields as needed
            );
          },
        );
      },
    );
  }
}
