import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String role = 'müsteri';

  //giriş yap fonksiyonu
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (error) {
      print(error);
    } catch (e) {
      print(e);
    }
  }

  //çıkış yap fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

  //kayıt ol fonksiyonu
  Future<UserCredential> createPerson(String ad, String soyad, String email,
      String telefon, String sifre) async {
    final UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email, password: sifre);
    await _firestore.collection('Person').doc(user.user!.uid).set({
      'ad': ad,
      'soyad': soyad,
      'email': email,
      'telefon': telefon,
      'sifre': sifre,
      'role': role
    });
    return user;
  }
}
