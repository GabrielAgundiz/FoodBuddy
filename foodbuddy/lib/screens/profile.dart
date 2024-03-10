import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isNotificationsSelected = true;
  bool _isLikesSelected = false;

  void _selectNotification() {
    setState(() {
      _isNotificationsSelected = true;
      _isLikesSelected = false;
    });
  }

  void _selectLikes() {
    setState(() {
      _isNotificationsSelected = false;
      _isLikesSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final client = FirebaseFirestore.instance
        .collection('client')
        .doc(user?.uid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        
        stream: client,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final clientData = snapshot.data!.data();

          return Column(
            children: [
              
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: clientData?['photo'] ??
                          AssetImage('assets/images/profile_picture.png'),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      clientData?['name'] ?? 'Nombre',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user?.email ?? 'Correo',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      clientData?['description'] ?? 'Descripcion',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: _selectNotification,
                      child: Column(
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: _isNotificationsSelected
                                ? Colors.green[400]!
                                : Colors.grey[200]!,
                            onPressed: _selectNotification,
                            child: Icon(
                              Icons.notifications,
                              color: _isNotificationsSelected
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Notifications',
                            style: TextStyle(
                              color: _isNotificationsSelected
                                  ? Colors.green[400]
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _selectLikes,
                      child: Column(
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: _isLikesSelected
                                ? Colors.green[400]!
                                : Colors.grey[200]!,
                            onPressed: _selectLikes,
                            child: Icon(
                              Icons.favorite_border,
                              color: _isLikesSelected
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Likes',
                            style: TextStyle(
                              color: _isLikesSelected
                                  ? Colors.green[400]
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    
    );
  }
}
