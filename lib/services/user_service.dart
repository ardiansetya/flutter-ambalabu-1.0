// lib/services/user_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserService {
  static const String _userKey = 'users';

  Future<List<User>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_userKey);
    if (usersJson == null) return [];

    List<dynamic> decoded = jsonDecode(usersJson);
    return decoded.map((json) => User.fromJson(json)).toList();
  }

  Future<void> registerUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getUsers();

    // Check if username already exists
    if (users.any((u) => u.username == user.username)) {
      throw Exception('Username already exists');
    }

    users.add(user);
    final usersJson = users.map((u) => u.toJson()).toList();
    await prefs.setString(_userKey, jsonEncode(usersJson));
  }

  Future<User> login(String username, String password) async {
    final users = await getUsers();
    final user = users.firstWhere(
          (user) => user.username == username && user.password == password,
      orElse: () => throw Exception('Invalid credentials'),
    );

    // Save current user to preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUser', username);

    return user;
  }

  Future<void> updateUser(String currentUsername, User updatedUser) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getUsers();

    // Check if new username already exists (unless it's the same as current username)
    if (updatedUser.username != currentUsername &&
        users.any((u) => u.username == updatedUser.username)) {
      throw Exception('Username already exists');
    }

    // Find and update the user
    final userIndex = users.indexWhere((u) => u.username == currentUsername);
    if (userIndex == -1) {
      throw Exception('User not found');
    }

    users[userIndex] = updatedUser;
    final usersJson = users.map((u) => u.toJson()).toList();
    await prefs.setString(_userKey, jsonEncode(usersJson));

    // Update current user in preferences if username changed
    if (currentUsername != updatedUser.username) {
      await prefs.setString('currentUser', updatedUser.username);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUsername = prefs.getString('currentUser');
    if (currentUsername == null) return null;

    final users = await getUsers();
    return users.firstWhere(
          (user) => user.username == currentUsername,
      orElse: () => throw Exception('Current user not found'),
    );
  }
}