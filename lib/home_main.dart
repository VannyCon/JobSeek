import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../firebase_options.dart';
import 'view/pages/home_page.dart';
import 'view/pages/update_page.dart';
import 'view/pages/settings_page.dart';
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
      home: Home(), // Changed home to Home
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int wheremyIndex = 0;
  Color containerColor = Color(0xFF413867);

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
                          ? SettingsContent()
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
      backgroundColor: Color(0xFF52487A),
      selectedItemColor: Color(0xFFEFF0FA), // Set selected item color
      unselectedItemColor: Color(0xFFEFF0FA), // Set unselected item color
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
      currentIndex: wheremyIndex,
      onTap: (int index) {
        setState(() {
          wheremyIndex = index;
        });
      },
    );
  }
}
