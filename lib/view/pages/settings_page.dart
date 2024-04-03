import 'package:flutter/material.dart';
import '../../controller/firebase.dart';

class SettingsContent extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                'SETTINGS',
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
        const SizedBox(height: 16),
        Container(
          child: Column(
            // Wrap buttons in a Column
            //// MAINAXIS IS VERTICAL ALIGNMENT IN COLUMN ////
            mainAxisAlignment: MainAxisAlignment.start,
            //// CROSSAXIS IS HORIZONTAL ALIGNMENT IN COLUMN ////
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      180), // Same border radius as the container
                  child: Image.asset(
                    'images/image.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text(
                'Vanny Con',
                style: TextStyle(
                    color: Color(0xFFEFF0FA),
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                'vannycon@gmail.com',
                style: TextStyle(
                  color: Color(0xFF8DE07A),
                  fontSize: 15,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Transparent background
                  elevation: 0, // No elevation
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Color(0xFF856BEE),
                        width: 2), // Violet stroke color
                    borderRadius: BorderRadius.circular(
                        8), // Adjust border radius as needed
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Color(0xFF856BEE), // Icon color
                    ),
                    SizedBox(width: 8), // Adjust spacing between icon and text
                    Text(
                      'EDIT PROFILE',
                      style: TextStyle(
                        color: Color(0xFF856BEE), // Text color
                        fontSize: 16, // Text size
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 9),
        Container(
          height: 57,
          child: ElevatedButton(
            onPressed: () {
              // Add functionality for Share my profile
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFEFF0FA),
              backgroundColor: const Color(0xFF52487A), // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9), // Adjust border radius
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.share,
                  color: Color(0xFFEFF0FA), // Icon color
                ),
                SizedBox(width: 8), // Adjust spacing between icon and text
                Text(
                  'Share my profile',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal), // Text size
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 9), // Adjust spacing between buttons
        Container(
          height: 57,
          child: ElevatedButton(
            onPressed: () {
              // Add functionality for Manage notification
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFEFF0FA),
              backgroundColor: const Color(0xFF52487A), // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9), // Adjust border radius
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.notifications,
                  color: Color(0xFFEFF0FA), // Icon color
                ),
                const SizedBox(
                    width: 5), // Adjust spacing between icon and text
                Text(
                  'Manage notification',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal), // Text size
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 9), // Adjust spacing between buttons
        Container(
          height: 57,
          child: ElevatedButton(
            onPressed: () {
              // Add functionality for Help
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFEFF0FA),
              backgroundColor: const Color(0xFF52457A), // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9), // Adjust border radius
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.help,
                  color: Color(0xFFEFF0FA), // Icon color
                ),
                const SizedBox(
                    width: 5), // Adjust spacing between icon and text
                Text(
                  'Help',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal), // Text size
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 9), // Adjust spacing between buttons
        Container(
          height: 57,
          child: ElevatedButton(
            onPressed: () {
              // Add functionality for About
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFEFF0FA),
              backgroundColor: const Color(0xFF52487A), // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9), // Adjust border radius
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.question_answer,
                  color: Color(0xFFEFF0FA), // Icon color
                ),
                const SizedBox(
                    width: 5), // Adjust spacing between icon and text
                Text(
                  'About',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal), // Text size
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 9),
        Container(
          height: 57,
          child: ElevatedButton(
            onPressed: () {
              // Add functionality for About
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFEFF0FA),
              backgroundColor: const Color(0xFF856BEE), // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9), // Adjust border radius
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: Color(0xFFEFF0FA), // Icon color
                ),
                const SizedBox(
                    width: 5), // Adjust spacing between icon and text
                Text(
                  'LOGOUT',
                  style: TextStyle(fontSize: 16), // Text size
                ),
              ],
            ),
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
