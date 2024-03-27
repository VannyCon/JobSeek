import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'content.dart';
import 'post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(), // Changed home to MyHomePage
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String insertName = 'INSERT';
  String updateName = 'UPDATE';
  String deleteName = 'DELETE';
  TextStyle textStyle = const TextStyle(
      color: Color.fromARGB(255, 225, 222, 222)); // Set default TextStyle
  int wheremyIndex = 0;
  Color containerColor = const Color.fromARGB(255, 235, 229, 220);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World'),
        backgroundColor: const Color.fromARGB(232, 214, 120, 33),
      ),
      body: Column(
        children: [
          Center(
            child: wheremyIndex == 0
                ? home()
                : wheremyIndex == 1
                    ? about()
                    : wheremyIndex == 2
                        ? settings(context)
                        : Container(),
          ),
        ],
      ),
      bottomNavigationBar: bottomNav(),
      floatingActionButton: floatingButton(context),
    );
  }

  FloatingActionButton floatingButton(BuildContext context) {
    return FloatingActionButton(
      // Added FloatingActionButton
      onPressed: () {
        _showDialog(context); // Call showDialog when button pressed
      },
      child: const Icon(Icons.add),
    );
  }

  BottomNavigationBar bottomNav() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'About',
          icon: Icon(Icons.question_answer_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Settings',
          icon: Icon(Icons.settings),
        ),
      ],

      ///This is the part where you are index bottom now
      currentIndex: wheremyIndex,
      onTap: (int index) {
        setState(() {
          wheremyIndex = index;
        });
      },
    );
  }

  Widget home() {
    return HomeContent(); // Return Content widget from content.dart
  }

  Widget about() {
    return PostContent(); // Return Content widget from content.dart
  }

  Container settings(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: containerColor,
      child: Container(
        child: Column(
          // Wrap buttons in a Column
          //// MAINAXIS IS VERTICAL ALIGNMENT IN COLUMN ////
          mainAxisAlignment: MainAxisAlignment.center,
          //// CROSSAXIS IS HORIZONTAL ALIGNMENT IN COLUMN ////
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    10), // Same border radius as the container
                child: Image.asset(
                  'images/image.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ////FIRST ROW////
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 29, 177, 93),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(7), // Set the border radius here
                ),
                // Use primary to set the background color
              ),
              onPressed: () {
                print(insertName);
                //if the button is click then this will trigger which change the design or do some stuff.
                setState(() {
                  insertName = 'Inserted';
                  textStyle = const TextStyle(
                      color: Color.fromARGB(255, 232, 229, 229));
                });
              },
              child: Row(
                //// MAINAXIS IS HORIZONTAL ALIGNMENT IN ROW ////
                mainAxisAlignment: MainAxisAlignment.center,
                //// CROSSAXOS IS VERTICAL ALIGNMENT IN ROW ////
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 229, 226, 226),
                  ), // Icon on the left
                  const SizedBox(width: 8), // Add space between icon and text
                  Text(insertName, style: textStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          // Use showDialog with CupertinoAlertDialog
          title: const Text('Accept?'),
          content: const Text("Do you accept?"),
          actions: [
            CupertinoDialogAction(
              child: const Text("No"), // Wrap text with Text widget
              onPressed: () {
                Navigator.of(context).pop(false); // Pop with a value if needed
              },
            ),
            CupertinoDialogAction(
              child: const Text("Yes"), // Wrap text with Text widget
              onPressed: () {
                Navigator.of(context).pop(true); // Pop with a value if needed
              },
            ),
          ],
        );
      },
    );
  }
}
