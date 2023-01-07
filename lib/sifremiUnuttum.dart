import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class sifremiUnuttum extends StatefulWidget {
  @override
  _sifremiUnuttumPageState createState() => _sifremiUnuttumPageState();
}

class _sifremiUnuttumPageState extends State<sifremiUnuttum> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF478DE0),
      appBar: AppBar(
        backgroundColor: Color(0xFF478DE0),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Şifre Sıfırlama İşlemi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                decoration: kutuDekorasyon,
                height: 50,
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(top: 14),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    hintText: "E-postanızı giriniz.",
                    hintStyle: yaziStili,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  sifremiSifirla();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginPage()));
                },
                child: Text(
                  'Şifremi Sıfırla',
                  style: TextStyle(
                    color: Colors.blue,
                    letterSpacing: 1.5,
                    fontSize: 18,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future sifremiSifirla() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());

    Fluttertoast.showToast(
      msg: 'Epostanıza şifre sıfırlamak mesajı gönderildi.',
      timeInSecForIosWeb: 2,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue[600],
      textColor: Colors.white,
      fontSize: 14,
    );
  }
}
