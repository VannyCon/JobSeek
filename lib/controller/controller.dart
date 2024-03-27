// Controller - user_controller.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class UserController {
  Future<User> fetchUser() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
}
