import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodbuddy/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:foodbuddy/widgets/utils.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Theme(
            data: ThemeData(
              fontFamily: 'Roboto',
            ),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Regístrate',
                      style: GoogleFonts.roboto(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          hintText: 'Ingresa tu nombre',
                          prefixIcon: Icon(Icons.person),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : 'Este campo es requerido',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'example@email.com',
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        validator: (email) => EmailValidator.validate(email!)
                            ? null
                            : 'Ingresa un correo valido',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          hintText: '••••••••',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(obscureText
                                ? Icons.visibility_off
                                : Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        obscureText: obscureText,
                        validator: (value) => value!.length >= 8
                            ? null
                            : 'Ingresa minimo 8 digitos',
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.green[400],
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Registrarse'),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          } on FirebaseAuthException catch (e) {
                            print(e);

                            Utils.showSnackBar(e.message);
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 40.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: '¿Ya tienes una cuenta? ',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Accede',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: const Color(0xFF5DB075),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
