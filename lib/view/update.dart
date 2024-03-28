import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:second_app/controller/firebase.dart';

class UpdateForm extends StatelessWidget {
  final String docID;
  final FirestoreService firestoreService = FirestoreService();

  UpdateForm({required this.docID});

  @override
  Widget build(BuildContext context) {
    print('DocID: $docID'); // Print docID for tracking

    return Scaffold(
      appBar: AppBar(
        title: const Text('UPDATE'),
      ),
      body: FutureBuilder(
        future: firestoreService.getNoteById(docID), // Fetch data by docID
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}'); // Print error for tracking
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.data() == null) {
            return const Center(child: Text('No data found.'));
          } else {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            return MyFormWidget(
              docID: docID,
              companyEmail: data['companyEmail'] ?? '',
              companyName: data['companyName'] ?? '',
              jobOffer: data['jobOffer'] ?? '',
              location: data['location'] ?? '',
              salary: data['salary'] ?? '',
            );
          }
        },
      ),
    );
  }
}

class MyFormWidget extends StatefulWidget {
  final String docID;
  final String companyEmail;
  final String companyName;
  final String jobOffer;
  final String location;
  final String salary;

  MyFormWidget({
    required this.docID,
    required this.companyEmail,
    required this.companyName,
    required this.jobOffer,
    required this.location,
    required this.salary,
  });

  @override
  _MyFormWidgetState createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyEmailController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _jobOfferController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _companyEmailController.text = widget.companyEmail;
    _companyNameController.text = widget.companyName;
    _jobOfferController.text = widget.jobOffer;
    _locationController.text = widget.location;
    _salaryController.text = widget.salary;
  }

  @override
  void dispose() {
    _companyEmailController.dispose();
    _companyNameController.dispose();
    _jobOfferController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _companyEmailController,
              decoration: InputDecoration(labelText: 'Company Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter company email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _companyNameController,
              decoration: InputDecoration(labelText: 'Company Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter company name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _jobOfferController,
              decoration: InputDecoration(labelText: 'Job Offer'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter job offer';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter location';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _salaryController,
              decoration: InputDecoration(labelText: 'Salary'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter salary';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  String companyEmail = _companyEmailController.text;
                  String companyName = _companyNameController.text;
                  String jobOffer = _jobOfferController.text;
                  String location = _locationController.text;
                  String salary = _salaryController.text;

                  firestoreService.updateNotes(widget.docID, companyEmail,
                      companyName, jobOffer, location, salary);
                  Navigator.pop(context); //go back to home
                  // Process form data
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
