import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controller/firebase.dart';
import '../components/more.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final FirestoreService firestoreService = FirestoreService();
  String _sortBy = 'Date';
  String _searchText = '';
  late String dropvalue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                  'DASHBOARD',
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
          const SizedBox(
            width: 8,
            height: 20,
          ),
          TextField(
            style: TextStyle(color: Color(0xFFEFF0FA)),
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    10.0), // Adjust border radius as needed
                borderSide: BorderSide.none, // Remove border color
              ),
              filled: true, // Fill the background with color
              fillColor: const Color(0xFF52487A), // Set background color
              labelText: 'Search',
              labelStyle:
                  TextStyle(color: Color(0xFFEFF0FA)), // Set label text color
              hintText: 'Enter Location or Job',
              hintStyle:
                  TextStyle(color: Color(0xFFEFF0FA)), // Set hint text color
              prefixIcon: const Icon(Icons.search,
                  color: Color(0xFFEFF0FA)), // Set prefix icon color
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0, horizontal: 12.0), // Adjust padding as needed
            ),
          ),
          const SizedBox(
            width: 8,
            height: 25,
          ),
          Container(
            height: 300,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'images/sapiens.png',
                  ),
                ),
                Container(
                  height: 380,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: MySortDropdownButton(
                  dropvalue: _sortBy,
                  onChanged: (String? newValue) {
                    setState(() {
                      _sortBy = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: firestoreService.getNotesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (!snapshot.hasData) {
                print("No data found");
                return const Text('No data found');
              }
              List notesList = snapshot.data!.docs;
              print("Length of notesList: ${notesList.length}");

              // Filter and sort notesList based on selected criteria
              notesList = notesList.where((note) {
                String companyNamelower = note['companyName'].toLowerCase();
                String companyNameupper = note['companyName'].toUpperCase();
                String locationlower = note['location'].toLowerCase();
                String locationupper = note['location'].toUpperCase();
                String jobOfferlower = note['jobOffer'].toLowerCase();
                String jobOfferupper = note['jobOffer'].toUpperCase();
                return companyNamelower.contains(_searchText.toLowerCase()) ||
                    companyNameupper.contains(_searchText.toUpperCase()) ||
                    locationlower.contains(_searchText.toLowerCase()) ||
                    locationupper.contains(_searchText.toUpperCase()) ||
                    jobOfferlower.contains(_searchText.toLowerCase()) ||
                    jobOfferupper.contains(_searchText.toUpperCase());
              }).toList();

              // Sort notesList based on selected criteria
              notesList.sort((a, b) {
                if (_sortBy == 'Date') {
                  // Sort by date logic
                  DateTime dateA = a['timestamp'].toDate();
                  DateTime dateB = b['timestamp'].toDate();
                  return dateB.compareTo(dateA);
                } else if (_sortBy == 'Location') {
                  // Sort by location logic
                  return a['location'].compareTo(b['location']);
                } else if (_sortBy == 'Salary') {
                  int removeSpecialCharactersAndParseToInt(String value) {
                    // Remove special characters using regex
                    String cleanedString =
                        value.replaceAll(RegExp(r'[^\w\s]+'), '');
                    // Parse the cleaned string to integer
                    int intValue = int.tryParse(cleanedString) ??
                        0; // Return 0 if parsing fails
                    return intValue;
                  }

                  // Sort by salary logic
                  int salaryA =
                      removeSpecialCharactersAndParseToInt(a['salary']);
                  int salaryB =
                      removeSpecialCharactersAndParseToInt(b['salary']);
                  return salaryB.compareTo(salaryA);
                }
                return 0;
              });

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                    margin: const EdgeInsets.only(
                        left: 8, right: 8, bottom: 17, top: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Adjust the border radius as needed
                    ),
                    color: const Color(0xFF856BEE),
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
                                            const Color(0xFFEFF0FA),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onPressed: () {
                                        print(companyEmail);
                                        _launchURL(context, companyEmail);
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'MESSAGE',
                                            style: TextStyle(
                                              color: Color(0xFF856BEE),
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
                                        backgroundColor: Colors
                                            .transparent, // Set the button color to transparent
                                        elevation: 0, // Remove button elevation
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MoreInfo(
                                              docID: docId,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'MORE',
                                            style: TextStyle(
                                              color: Color(0xFFEFF0FA),
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

class MySortDropdownButton extends StatelessWidget {
  final String dropvalue;
  final ValueChanged<String?> onChanged;

  MySortDropdownButton({
    required this.dropvalue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButton<String>(
        dropdownColor: Color(0xFF52487A),
        value: dropvalue,
        onChanged: onChanged, // Sort icon
        elevation: 0, // Remove elevation
        style: const TextStyle(
          color: Color(0xFFEFF0FA), // Text color
          fontSize: 16, // Text size
        ),
        underline: Container(), // Remove the underline
        items: <String>['Date', 'Location', 'Salary'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                const Icon(
                  Icons.sort_outlined,
                  color: Color(0xFFEFF0FA),
                ),
                const SizedBox(
                    width: 8), // Adjust spacing between icon and text
                Text(
                  value,
                  textAlign: TextAlign.center, // Center text alignment
                  style: const TextStyle(
                    color: Color(0xFFEFF0FA), // Text color
                    fontSize: 16, // Text size
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

void _launchURL(BuildContext context, String? emails) async {
  if (emails != null && emails.isNotEmpty) {
    String email = emails;
    var url = 'mailto:$email?subject=Subject&body=Body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    // Display a message indicating that the email address is not available
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Email Not Available'),
          content: const Text('The email address is not available.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
