
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:book_share/main_navigation.dart';

import 'Signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _databaseref = FirebaseDatabase.instance.ref();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  void login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        User? user = _auth.currentUser;
        if (user != null) {
          DatabaseReference userRef = _databaseref.child('Users').child(
              user.uid);
          DataSnapshot snapshot = await userRef.get();

          if (snapshot.exists) {
            Map userData = snapshot.value as Map;
            String role = userData['role'];

            if (role == '0') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainNavigation()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainNavigation()),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User data not found.')),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed: $e')),
        );
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 100, color: Colors.teal),
                const SizedBox(height: 16),
                const Text('Login Page!', style: TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Login to your account'),
                const SizedBox(height: 32),
                Text(
                  'Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter your email here",
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter your email';
                    else if (!value.contains('@'))
                      return 'Please enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
            TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: "Enter your Password",
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your password';
              return null;
            },
          ),

          const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: loading
                        ? CircularProgressIndicator(color: Colors.white)
                        : const Text('Login',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) => AddData()));
                      },
                      child: const Text('Sign Up'),
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
