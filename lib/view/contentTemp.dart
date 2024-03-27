import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                                  'Mircosoft',
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
                                      const Color.fromARGB(255, 120, 196, 234),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5), // Set the border radius here
                                  ),
                                  // Use primary to set the background color
                                ),
                                onPressed: () {},
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Add space between icon and text
                                    Text(
                                      'MESSAGE',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 229, 226, 226),
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
                                      Color.fromARGB(255, 197, 224, 239),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5), // Set the border radius here
                                  ),
                                  // Use primary to set the background color
                                ),
                                onPressed: () {},
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Add space between icon and text
                                    Text(
                                      'MORE',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 82, 137, 164),
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
          ),
        ],
      ),
    );
  }
}
