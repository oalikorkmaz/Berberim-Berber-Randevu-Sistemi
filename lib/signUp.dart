import 'loginPage.dart';
import 'services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class signUp extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<signUp> {
  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();

  AuthService _authService = AuthService();

  bool kullanimKosullari = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF478DE0),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Color(0xFF478DE0),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 20,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 170),
                child: Text(
                  'Kayıt Ol',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: _build(),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  Text(
                    'Zaten Üyemisiniz? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loginPage()),
                    ),
                    child: Text(
                      'Giriş Yap',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                child: SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.white),
                    onPressed: () {
                      if (kullanimKosullari == true) {
                        _authService
                            .createPerson(
                                adController.text,
                                soyadController.text,
                                emailController.text,
                                telefonController.text,
                                sifreController.text)
                            .then((value) {
                          return navigateNext(loginPage());
                        }).catchError((error) {
                          if (error.code.toString().contains('invalid-email')) {
                            hataMesaji('Geçersiz e-mail');
                          } else if (error.code
                              .toString()
                              .contains('weak-password')) {
                            hataMesaji('Zayıf Şifre');
                          } else if (error.code
                              .toString()
                              .contains('email-already-in-use')) {
                            hataMesaji('Email zaten kayıtlı.');
                          } else if (adController.text == "") {
                            hataMesaji('Lütfen Adınızı Giriniz.');
                          } else if (soyadController.text == "") {
                            hataMesaji('Lütfen Soyadınızı Giriniz.');
                          } else if (emailController.text == "") {
                            hataMesaji('Lütfen Emailinizi Giriniz.');
                          } else if (telefonController.text == "") {
                            hataMesaji('Lütfen Telefon Numaranızı Giriniz.');
                          } else if (sifreController.text == "") {
                            hataMesaji('Lütfen Şifrenizi Giriniz.');
                          }
                        });
                      } else {
                        hataMesaji(
                            'Lütfen Kullanım Koşullarını işaretleyiniz.');
                      }
                    },
                    child: Text(
                      'Kayıt Ol',
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
              ),
            ),
          ],
        ),
      )),
    );
  }

  void navigateNext(Widget route) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => route));
    hataMesaji('Başarı ile Kayıt Oldunuz.');
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

  Widget buildInputForm(
      String hint,
      bool pass,
      TextEditingController controller,
      TextInputType klavyegirisi,
      int maxGiris) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kutuDekorasyon,
          height: 50,
          child: TextField(
            keyboardType: klavyegirisi,
            inputFormatters: [new LengthLimitingTextInputFormatter(maxGiris)],
            controller: controller,
            obscureText: pass, // şifrenin görünmemesi için
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(null),
              hintText: hint,
              hintStyle: yaziStili,
            ),
          ),
        ),
      ],
    );
  }

  Widget _build() {
    return Column(
      children: [
        buildInputForm('Ad', false, adController, TextInputType.name, 30),
        buildInputForm('Soyad', false, soyadController, TextInputType.name, 30),
        buildInputForm(
            'Email', false, emailController, TextInputType.emailAddress, 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kutuDekorasyon,
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  new LengthLimitingTextInputFormatter(11),
                  FilteringTextInputFormatter.allow(RegExp("([0-9])")),
                ],
                controller: telefonController,
                obscureText: false, // şifrenin görünmemesi için
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(null),
                  hintText: 'Telefon',
                  hintStyle: yaziStili,
                ),
              ),
            ),
          ],
        ),
        buildInputForm('Şifre', true, sifreController, TextInputType.name, 30),
        const SizedBox(height: 20),
        _checkBox(),
      ],
    );
  }

  Widget _checkBox() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: kullanimKosullari,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  kullanimKosullari = value!;
                });
              },
            ),
          ),
          Flexible(
            child: Text(
              'Kullanım Koşulları ve Şartlarını okudum.',
              style: etiketStili,
            ),
          ),
        ],
      ),
    );
  }
}
