import 'package:flutter/material.dart';
import 'services/user_service.dart';
import 'models/user_model.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _userService = UserService();

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = User(
        name: _nameController.text,
        username: _usernameController.text,
        password: _passwordController.text,
      );

      await _userService.registerUser(user);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF5D9CEC), Color(0xFF4A90E2)],
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
                  Icon(
                    Icons.person_add,
                    color: Colors.white,
                    size: 80,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Create an Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  _buildTextField(
                    controller: _nameController,
                    labelText: 'Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _usernameController,
                    labelText: 'Username',
                    icon: Icons.person_outline,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a password';
                      }
                      if ((value?.length ?? 0) < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF4A90E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      elevation: 5,
                    ),
                    onPressed: _isLoading ? null : _register,
                    child: _isLoading
                        ? CircularProgressIndicator(color: Color(0xFF4A90E2))
                        : Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Sudah punya akun? Login di sini',
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Poppins',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black54,
          fontFamily: 'Poppins',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      obscureText: obscureText,
      validator: validator ??
          (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your $labelText';
            }
            return null;
          },
    );
  }
}
