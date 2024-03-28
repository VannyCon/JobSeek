import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_app/controller/firebase.dart';
import 'package:second_app/view/update.dart';

class PostContent extends StatelessWidget {
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(companyName),
                          Text(companyEmail),
                          Text(jobOffer),
                          Text(location),
                          Text(salary),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 35,
                            width: 100,
                            decoration: const BoxDecoration(
                                // Add decoration as needed
                                ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(248, 240, 233, 221),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Set the border radius here
                                ),
                                // Use primary to set the background color
                              ),
                              onPressed: () {
                                print('docId: $docId');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateForm(docID: docId),
                                  ), // Calling the MyForm widget
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Add space between icon and text
                                  Text(
                                    'UPDATE',
                                    style: TextStyle(
                                      color: Color.fromARGB(248, 187, 143, 66),
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 5), // Added SizedBox for spacing
                          Container(
                            height: 35,
                            width: 100,
                            decoration: const BoxDecoration(
                                // Add decoration as needed
                                ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 239, 197, 197),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Set the border radius here
                                ),
                                // Use primary to set the background color
                              ),
                              onPressed: () {
                                _showDeleteDialog(context, docId);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Add space between icon and text
                                  Text(
                                    'DELETE',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 164, 82, 82),
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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

void _showDeleteDialog(BuildContext context, String docId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(5), // Adjust padding size here
        child: AlertDialog(
          title: const Text(
            'Delete Data',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Are you Sure you want to Delete this?',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                FirestoreService().deleteNote(docId);
                Navigator.of(context).pop();
              },
              child: Text('YES'),
            ),
          ],
        ),
      );
    },
  );
}
