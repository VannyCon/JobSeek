import 'package:flutter/material.dart';

class InsertForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INSERT'),
      ),
      body: MyFormWidget(),
    );
  }
}

class MyFormWidget extends StatefulWidget {
  @override
  _MyFormWidgetState createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextField(
                decoration: InputDecoration(labelText: 'Username'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextField(
                decoration: InputDecoration(labelText: 'Birthday'),
                keyboardType: TextInputType.datetime,
              ),
            ),
            // Add TextFormField for other inputs (job, email, location, salary) similarly
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
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
