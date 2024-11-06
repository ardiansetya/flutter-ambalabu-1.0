import 'package:flutter/material.dart';
import 'services/user_service.dart';
import 'models/user_model.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _formKey = GlobalKey<FormState>();
  final _userService = UserService();

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _currentUsername;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentUser() async {
    try {
      setState(() => _isLoading = true);

      final currentUser = await _userService.getCurrentUser();
      if (currentUser != null && mounted) {
        setState(() {
          _nameController.text = currentUser.name;
          _usernameController.text = currentUser.username;
          _currentUsername = currentUser.username;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load user: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updateUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final updatedUser = User(
        name: _nameController.text,
        username: _usernameController.text,
        password: _passwordController.text,
      );

      await _userService.updateUser(_currentUsername ?? '', updatedUser);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update successful!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF908F91), Color(0xFF86B786)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 80,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Update Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'JetBrainsMono',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Name',
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontFamily: 'JetBrainsMono',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.account_circle, color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Username',
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontFamily: 'JetBrainsMono',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'New Password (optional)',
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontFamily: 'JetBrainsMono',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isNotEmpty ?? false) {
                        if ((value?.length ?? 0) < 6) {
                          return 'Password must be at least 6 characters';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF2575FC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: _isLoading ? null : _updateUser,
                    child: _isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                        : const Text(
                      'Update Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}