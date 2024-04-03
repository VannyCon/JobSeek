import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controller/firebase.dart';
import '../components/update.dart';
import '../components/insert.dart';

class PostContent extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            width: 8,
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: const Text(
                  'POST',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 30, // Adjust the size as needed
                    height: 30, // Adjust the size as needed
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF52487A), // Change the color as needed
                    ),
                    child: const Center(
                      child: Icon(Icons.notifications,
                          color: Color(
                            0xFFEFF0FA,
                          ),
                          size: 16 // Change the icon color as needed
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 30, // Adjust the size as needed
                    height: 30, // Adjust the size as needed
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF52487A), // Change the color as needed
                    ),
                    child: const Center(
                      child: Icon(Icons.sunny,
                          color: Color(0xFFEFF0FA),
                          size: 16 // Change the icon color as needed
                          ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 7, right: 7, top: 16, bottom: 0),
            child: Container(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCBC1F1),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Create Post',
                      style: TextStyle(
                        color: Color(0xFF413867),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: Color(0xFF413867),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: firestoreService.getNotesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 24.0, // Adjust height as needed
                  width: 24.0, // Adjust width as needed
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                print("No data found");
                return const Text('No data found');
              }
              List notesList = snapshot.data!.docs;
              print("Length of notesList: ${notesList.length}");
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
                    color: const Color(0xFF856BEE),
                    margin: const EdgeInsets.only(
                        left: 7, right: 7, bottom: 17, top: 0),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    companyName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFEFF0FA),
                                    ),
                                  ),
                                  Text(jobOffer,
                                      style: const TextStyle(
                                        color: Color(0xFFEFF0FA),
                                        fontSize: 23,
                                        fontWeight: FontWeight.w900,
                                      )),
                                  Row(
                                    children: [
                                      Icon(Icons.email,
                                          color: Color(0xFFEFF0FA),
                                          size: 16), // Icon widget
                                      SizedBox(
                                          width:
                                              5), // Add some space between icon and text
                                      Text(
                                        companyEmail,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFEFF0FA),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Color(0xFFEFF0FA),
                                          size: 16), // Icon widget
                                      SizedBox(
                                          width:
                                              5), // Add some space between icon and text
                                      Text(
                                        location,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFEFF0FA),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.attach_money,
                                          color: Color(0xFFEFF0FA),
                                          size: 16), // Icon widget
                                      SizedBox(
                                          width:
                                              5), // Add some space between icon and text
                                      Text(
                                        salary,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFEFF0FA),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                        backgroundColor:
                                            const Color(0xFFC3B5FF),
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
                                              color: Color(0xFF413867),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
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
                                        backgroundColor:
                                            const Color(0xFF413867),
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
                                              color: Color(0xFFC3B5FF),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
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
        ],
      ),
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
