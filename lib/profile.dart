import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Change password screen.dart';

class ManageProfileScreen extends StatefulWidget {
  @override
  _ManageProfileScreenState createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  final String userName = "John Doe";
  final String userEmail = FirebaseAuth.instance.currentUser?.email ?? "Not logged in";
  final String userAddress = "123 Main Street, City";

  String _location = "Not set yet";

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location services are disabled.")),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permission denied.")),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks.first;

    setState(() {
      _location = "${place.locality}, ${place.administrativeArea}, ${place.country}";
    });
  }

  // void _changePasswordDialog() {
  //   final TextEditingController _passwordController = TextEditingController();
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("Change Password"),
  //       content: TextField(
  //         controller: _passwordController,
  //         decoration: InputDecoration(labelText: "New Password"),
  //         obscureText: true,
  //       ),
  //       actions: [
  //         TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text("Cancel")),
  //         ElevatedButton(
  //           onPressed: () async {
  //             try {
  //               await FirebaseAuth.instance.currentUser!
  //                   .updatePassword(_passwordController.text);
  //               Navigator.pop(context);
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text("Password changed successfully.")));
  //             } catch (e) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text("Error: ${e.toString()}")));
  //             }
  //           },
  //           child: Text("Update"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/login'); // Make sure '/login' route exists
  }

  void _deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      Navigator.of(context).pushReplacementNamed('/signup'); // Make sure '/signup' route exists
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 2,
        centerTitle: true,
        title: Text("Manage Profile", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(userName,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(userEmail,
                style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const SizedBox(height: 30),
            _buildInfoTile("Email", userEmail, Icons.email_outlined),
            _buildInfoTile("Address", userAddress, Icons.home_outlined),

            // Location Tile
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.blueGrey),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Location",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600])),
                        const SizedBox(height: 4),
                        Text(_location,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.gps_fixed, color: Colors.blueAccent),
                    onPressed: _getCurrentLocation,
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Action Buttons
            _buildActionButton(
              text: "Change Password",
              icon: Icons.lock_outline,
              color: Colors.teal,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChangePasswordScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              text: "Logout",
              icon: Icons.logout,
              color: Color(0xFF475569),
              onTap: _logout,
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              text: "Delete Account",
              icon: Icons.delete_forever,
              color: Color(0xFFEF4444),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Confirm Delete"),
                    content: Text("Are you sure you want to delete your account?"),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _deleteAccount();
                        },
                        child: Text("Delete"),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600])),
              const SizedBox(height: 4),
              Text(value,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
        ),
      ),
    );
  }
}
