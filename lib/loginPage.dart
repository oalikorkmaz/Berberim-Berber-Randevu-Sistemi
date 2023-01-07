import 'anaEkran.dart';
import 'services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'berberSayfa.dart';
import 'signUp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sifremiUnuttum.dart';
import 'services/auth_service.dart';

const yaziStili = TextStyle(
  color: Colors.white54,
  fontFamily: 'Open Sans',
);

const etiketStili = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontFamily: 'Open Sans',
);

final kutuDekorasyon = BoxDecoration(
  color: const Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    const BoxShadow(
      color: Colors.black12,
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ],
);

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => LoginPageState();
}

class LoginPageState extends State<loginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget emailKutusu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kutuDekorasyon,
          height: 60,
          child: TextField(
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
          ),
        ),
      ],
    );
  }

  Widget sifreKutusu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kutuDekorasyon,
          height: 60,
          child: TextField(
            controller: passwordController,
            obscureText: true, // şifrenin görünmemesi için
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: "Şifrenizi giriniz.",
              hintStyle: yaziStili,
            ),
          ),
        ),
      ],
    );
  }

  Widget sifreniMiUnuttun() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => sifremiUnuttum())),
        child: Text(
          'Şifreni mi Unuttun?',
          style: etiketStili,
        ),
      ),
    );
  }

  String role = "müsteri";
  Future<void> _checkAccountType() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('Person')
        .doc(user!.uid)
        .get();
    setState(() {
      role = snap['role'];
    });

    if (role == 'müsteri') {
      navigateNext(anaEkran());
    } else if (role == 'berber') {
      navigateNext(berberSayfa());
    }
  }

  void navigateNext(Widget route) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => route));
  }

  Widget girisButonu() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: SizedBox(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 5,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.white),
          onPressed: () {
            if (emailController.text == "" || passwordController.text == "") {
              hataMesaji('Lütfen Email ve Şifrenizi giriniz.');
            }
            _authService
                .signIn(emailController.text, passwordController.text)
                .then((value) {
              return _checkAccountType();
            }).catchError((error) {
              if (error.code.toString().contains('invalid-email')) {
                hataMesaji('Geçersiz email.');
              }
              if (error.code.toString().contains('user-not-found')) {
                hataMesaji('Kullanıcı Bulunamadı.');
              }
              if (error.code.toString().contains('wrong-password')) {
                hataMesaji('Parola Yanlış.');
              }
              if (error.code.toString().contains('too-many-requests')) {
                hataMesaji(
                    'Çok fazla giriş denemesi oldu. Birazdan tekrar dene');
              }
            });
          },
          child: const Text(
            'Giriş',
            style: TextStyle(
              color: Colors.blue,
              letterSpacing: 1.5,
              fontSize: 18,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void hataMesaji(String text) {
    Fluttertoast.showToast(
      msg: text,
      timeInSecForIosWeb: 2,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue[600],
      textColor: Colors.white,
      fontSize: 14,
    );
  }

  Widget facebookLogo() {
    return GestureDetector(
      onTap: () => signInWithFacebook(),
      child: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
          image: DecorationImage(
            image: AssetImage('assets/logo/facebook.jpg'),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Widget googleLogo() {
    return GestureDetector(
      onTap: () {
        AuthServiceForGoogle().signInWithGoogle();
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
          image: DecorationImage(
            image: AssetImage('assets/logo/google.jpg'),
          ),
        ),
      ),
    );
  }

  Widget kayitOl() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => signUp()),
      ),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Hesabınız mı yok? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Kayıt Ol',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationThickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 40.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 120),
                  const Text(
                    'Giriş Yap',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  emailKutusu(),
                  const SizedBox(height: 30),
                  sifreKutusu(),
                  sifreniMiUnuttun(),
                  girisButonu(),
                  Column(
                    children: const <Widget>[
                      Text(
                        '-- YA DA --',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Şunula Giriş Yap',
                        style: etiketStili,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // facebook
                        facebookLogo(),
                        googleLogo(),
                      ],
                    ),
                  ),
                  // Kayıt Ol
                  kayitOl(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
