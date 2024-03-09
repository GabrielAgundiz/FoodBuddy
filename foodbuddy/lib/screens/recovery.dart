import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodbuddy/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:foodbuddy/widgets/utils.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

Future resetPassword() async {
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    print(e);
    Utils.showSnackBar(e.message);
    Navigator.pop(context);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Theme(
          data: ThemeData(
            fontFamily: 'Roboto',
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Recupera',
                  style: GoogleFonts.roboto(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'example@email.com',
                      prefixIcon: Icon(Icons.email),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                     validator: (email) => EmailValidator.validate(email!)
                            ? null
                            : 'Ingresa un correo valido',
                  ),
                ),
                SizedBox(height: 40.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.green[400],
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Enviar contraseña temporal'),
                  onPressed: resetPassword,
                ),
                SizedBox(height: 40.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: '¿Ya recordaste tu contraseña? ',
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
    );
  }
}
