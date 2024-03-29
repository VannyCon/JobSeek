import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_app/controller/firebase.dart';
import 'package:second_app/view/update.dart';
import '../insert.dart';

class PostContent extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 14,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(248, 227, 240, 221),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InsertForm(),
                ),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: Color.fromARGB(248, 66, 187, 110),
                ),
                SizedBox(width: 8),
                Text(
                  'INSERT',
                  style: TextStyle(
                    color: Color.fromARGB(248, 66, 187, 110),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: firestoreService.getNotesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading... the Data');
              }
              if (!snapshot.hasData) {
                print("No data found");
                return const Text('No data found');
              }
              List notesList = snapshot.data!.docs;
              print("Length of notesList: ${notesList.length}");
              return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = notesList[index];
                  String docId = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  print(
                      "Data for document $docId: $data"); // Debug print for data
                  String companyName = data['companyName'];
                  String companyEmail = data['companyEmail'];
                  String jobOffer = data['jobOffer'];
                  String location = data['location'];
                  String salary = data['salary'];

                  return Card(
                    elevation: 3,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: ListTile(
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
                                    decoration: const BoxDecoration(),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            248, 240, 233, 221),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onPressed: () {
                                        print('docId: $docId');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateForm(docID: docId),
                                          ),
                                        );
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'UPDATE',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  248, 187, 143, 66),
                                              fontSize: 9,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    height: 35,
                                    width: 100,
                                    decoration: const BoxDecoration(),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 239, 197, 197),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onPressed: () {
                                        _showDeleteDialog(context, docId);
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'DELETE',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 164, 82, 82),
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
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

void _showDeleteDialog(BuildContext context, String docId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(5),
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
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                FirestoreService().deleteNote(docId);
                Navigator.of(context).pop();
              },
              child: const Text('YES'),
            ),
          ],
        ),
      );
    },
  );
}
