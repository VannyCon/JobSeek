import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:second_app/firebase_options.dart';
import 'view/components/home_page.dart';
import 'view/components/update_page.dart';
// import 'view/post.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print(DefaultFirebaseOptions.currentPlatform);
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
  Color containerColor = Color(0xFFEFF0FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: containerColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: wheremyIndex == 0
                  ? HomeContent()
                  : wheremyIndex == 1
                      ? PostContent()
                      : wheremyIndex == 2
                          ? settings(context)
                          : Container(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNav(),
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
          label: 'Post',
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
}
