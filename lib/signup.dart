import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Login.dart';

class Item {
  String name;
  String address;
  String email;
  String role;
  String password;

  Item({
    required this.name,
    required this.address,
    required this.email,
    required this.role,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'email': email,
      'role': role,
      'password': password,
    };
  }
}

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();


  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _auth = FirebaseAuth.instance;
  final _databaseref = FirebaseDatabase.instance.ref();

  Future<void> signupUser() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      Item item = Item(
        name: nameController.text.trim(),
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text.trim(),
        address: addressController.text.trim(),
        role: '0',
      );

      await _databaseref.child('Users').child(uid).set(item.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered Successfully')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Widget _buildTextField(String label, {
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator ?? _validateNotEmpty,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black),

        ),

      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required bool obscureText,
    required TextEditingController controller,
    required VoidCallback onToggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: onToggle,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  String? _validateNotEmpty(String? value) =>
      (value == null || value.trim().isEmpty) ? 'This field is required' : null;

  String? _validateEmail(String? value) =>
      (value == null || !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))
          ? 'Enter a valid email'
          : null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.lock, size: 80, color: Colors.teal),
                const SizedBox(height: 10),
                const Text("Signup Page!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text("Create a new account", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                const SizedBox(height: 25),

                _buildTextField("Full Name", controller: nameController),
                const SizedBox(height: 15),
                _buildTextField("Email", controller: emailController, validator: _validateEmail),
                const SizedBox(height: 15),
                _buildPasswordField(
                  label: "Password",
                  obscureText: _obscurePassword,
                  controller: passwordController,
                  onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
                const SizedBox(height: 15),
                _buildPasswordField(
                  label: "Confirm Password",
                  obscureText: _obscureConfirmPassword,
                  controller: confirmPasswordController,
                  onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
                const SizedBox(height: 15),
                _buildTextField("Address", controller: addressController),


                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: signupUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text("Login", style: TextStyle(color: Colors.purple)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}