import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfileScreen extends StatelessWidget {
  static String routeName = '/my_profile';

  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Navigate back to previous screen
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'My Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Center(
            child: FutureBuilder<User?>(
              future: FirebaseAuth.instance.authStateChanges().first,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (!snapshot.hasData) {
                  return Text(
                    'No user logged in',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error fetching user data',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  );
                } else {
                  final user = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(user.photoURL == null
                              ? 'lib/assests/avatar1.png'
                              : 'assets/avatar2.png'),
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                      SizedBox(height: 20),
                      buildProfileInfo(
                          title: 'Full Name:', value: user.uid ?? 'N/A'),
                      SizedBox(height: 20),
                      buildProfileInfo(
                          title: 'Email:', value: user.email ?? 'N/A'),
                      SizedBox(height: 20),
                      buildProfileInfo(
                          title: 'Phone Number:',
                          value: user.phoneNumber ?? 'N/A'),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileInfo({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 16),
        Divider(
          color: Colors.grey[300],
          height: 1,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
