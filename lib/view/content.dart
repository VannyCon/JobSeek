import 'package:flutter/material.dart';
import 'package:second_app/model/user.dart';
import '../controller/controller.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: UserController().fetchUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:
                CircularProgressIndicator(), // Centered the CircularProgressIndicator
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final User? user = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: 397,
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), // Changed 2 to 8
                      shape: BoxShape.rectangle,
                    ),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.white, // Using Colors.white directly
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user!.name, // Removed unnecessary cast
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    user.username,
                                    style: const TextStyle(
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
                                      Text(user.email),
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
                                      Text(user.address.street),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 16), // Added SizedBox for spacing
                          Container(
                            width: 120,
                            height: 128,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '10/10/2024',
                                  ),
                                  SizedBox(height: 5),
                                  // Buttons and other UI elements can be added here
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
