import 'package:flutter/material.dart';
import 'package:second_app/controller/firebase.dart';
import 'insert.dart';
import 'update.dart';

class PostContent extends StatefulWidget {
  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  final FirestoreService firestoreService = FirestoreService();
  String insertName = 'INSERT';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(248, 227, 240, 221),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              onPressed: () {
                print(insertName);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InsertForm(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.add,
                    color: Color.fromARGB(248, 66, 187, 110),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    insertName,
                    style: const TextStyle(
                      color: const Color.fromARGB(248, 66, 187, 110),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 397,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                shape: BoxShape.rectangle,
              ),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: const Color.fromARGB(255, 255, 255, 255),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Added mainAxisAlignment
                  children: [
                    Expanded(
                      // Wrapped the left container with Expanded
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: double.infinity, // Changed to double.infinity
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 3, 5, 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Microsoft',
                                  textAlign: TextAlign.start,
                                ),
                                const Text(
                                  'UI/UX Designer',
                                  style: TextStyle(
                                    fontSize: 29,
                                    color: Color.fromARGB(255, 131, 97, 210),
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        'https://picsum.photos/seed/822/600',
                                        width: 21,
                                        height: 14,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Text(
                                      'example@gmail.com',
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        'https://picsum.photos/seed/822/600',
                                        width: 21,
                                        height: 14,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Text(
                                      'Ph, Negros Occidental',
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        'https://picsum.photos/seed/822/600',
                                        width: 21,
                                        height: 14,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Text(
                                      '10,000 - 20,000',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Added SizedBox for spacing
                    Container(
                      width: 120,
                      height: 128,
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 7, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '10/10/2024',
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
                                      const Color.fromARGB(248, 240, 233, 221),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5), // Set the border radius here
                                  ),
                                  // Use primary to set the background color
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UploadForm()), // Calling the MyForm widget
                                  );
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Add space between icon and text
                                    Text(
                                      'UPDATE',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(248, 187, 143, 66),
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
                                  _showDeleteDialog(context);
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showDeleteDialog(BuildContext context) {
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
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                // Process form data here
                // You can retrieve text controller values or use onChanged callbacks
                Navigator.of(context).pop();
              },
              child: const Text('SAVE'),
            ),
          ],
        ),
      );
    },
  );
}
