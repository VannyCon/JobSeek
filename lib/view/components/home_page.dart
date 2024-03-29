import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_app/controller/firebase.dart';

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
          SizedBox(
            width: 8,
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  'DASHBOARD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Color(0xFF808081),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 30, // Adjust the size as needed
                    height: 30, // Adjust the size as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // Change the color as needed
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.notifications,
                        color: Color(
                            0xFF856BEE), // Change the icon color as needed
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 30, // Adjust the size as needed
                    height: 30, // Adjust the size as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // Change the color as needed
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.sunny,
                        color: Color(
                            0xFF856BEE), // Change the icon color as needed
                      ),
                    ),
                  ),
                ],
              )
            ],
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
          Column(
            children: [
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
                  Expanded(
                    flex: 2,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Search',
                        hintText: 'Enter Location or Job',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
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
                return CircularProgressIndicator();
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        backgroundColor:
                                            const Color(0xFF6BDEEE),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'MESSAGE',
                                            style: TextStyle(
                                              color: Color(0xFFDDF8F9),
                                              fontSize: 9,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    height: 35,
                                    width: 100,
                                    decoration: const BoxDecoration(),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFDDF8F9),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'MORE',
                                            style: TextStyle(
                                              color: Color(0xFF6BDEEE),
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
        value: dropvalue,
        onChanged: onChanged,
        icon: Icon(Icons.sort), // Sort icon
        elevation: 0, // Remove elevation
        style: TextStyle(
          color: Colors.black, // Text color
          fontSize: 16, // Text size
        ),
        underline: Container(), // Remove the underline
        items: <String>['Date', 'Location', 'Salary'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              textAlign: TextAlign.center, // Center text alignment
              style: TextStyle(
                color: Colors.black, // Text color
                fontSize: 16, // Text size
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
