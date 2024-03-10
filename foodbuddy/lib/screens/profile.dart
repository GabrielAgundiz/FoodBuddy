import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodbuddy/screens/notifies.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _description;
  String? _address;
  String? _photoUrl;
  bool _notifications = false;
  bool _news = false;
  String? _preferences;

  final picker = ImagePicker();

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
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotifiesPage()),
                );
              })
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: client,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final clientData = snapshot.data!.data();

          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 75,
                          backgroundImage: _photoUrl != null
                              ? FileImage(File(_photoUrl!))
                              : const AssetImage(
                                      'assets/images/profile_picture.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedFile != null) {
                              setState(() {
                                _photoUrl = pickedFile.path;
                              });
                            }
                          },
                          child: const Text('Seleccionar foto'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue:
                              clientData?['name'], // Set initial value
                          decoration:
                              const InputDecoration(labelText: 'Nombre'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu nombre';
                            }
                            return null;
                          },
                          onSaved: (value) => _name = value,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user?.email ?? 'Correo',
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue:
                              clientData?['description'], // Set initial value
                          decoration:
                              const InputDecoration(labelText: 'Descripción'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa una descripción';
                            }
                            return null;
                          },
                          onSaved: (value) => _description = value,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue:
                              clientData?['address'], // Set initial value
                          decoration:
                              const InputDecoration(labelText: 'Dirección'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu dirección';
                            }
                            return null;
                          },
                          onSaved: (value) => _address = value,
                        ),
                        const SizedBox(height: 16),
                         DropdownButtonFormField<String>(
                          value:
                              clientData?['preferences'], // Set initial value
                          decoration: const InputDecoration(
                              labelText: 'Preferencias alimenticias'),
                          onChanged: (value) {
                            setState(() {
                              _preferences = value;
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                              child: Text('Vegetariano'),
                              value: 'vegetarian',
                            ),
                            DropdownMenuItem(
                              child: Text('Vegano'),
                              value: 'vegan',
                            ),
                            DropdownMenuItem(
                              child: Text('Diabético'),
                              value: 'diabetic',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text('Notificaciones'),
                          value: _notifications,
                          onChanged: (value) {
                            setState(() {
                              _notifications = value;
                            });
                          },
                          activeTrackColor: Colors.green.withAlpha(50),
                          activeColor: Colors.green,
                        ),
                        SwitchListTile(
                          title: const Text('Noticias'),
                          value: _news,
                          onChanged: (value) {
                            setState(() {
                              _news = value;
                            });
                          },
                          activeTrackColor: Colors.green.withAlpha(50),
                          activeColor: Colors.green,
                        ),
                       
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              try {
                                await FirebaseFirestore.instance
                                    .collection('client')
                                    .doc(user?.uid)
                                    .update({
                                  'name': _name,
                                  'description': _description,
                                  'address': _address,
                                  'photo': _photoUrl,
                                  'notifications': _notifications,
                                  'news': _news,
                                  'preferences': _preferences,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Los datos se han guardado')),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Error al guardar los datos')),
                                );
                              }
                            }
                          },
                          child: const Text('Guardar cambios'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
