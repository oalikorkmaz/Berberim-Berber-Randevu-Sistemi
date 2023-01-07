import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'berberSayfa.dart';
import 'loginPage.dart';
import 'package:flutter/material.dart';
import 'services/auth.dart';
import 'detayEkran.dart';

const berberData = [
  {
    'berberAdi': 'Onur Ali Korkmaz',
    'puan': '4.8',
    'imgUrl': 'assets/onur2.jpg',
    'bgColor': Color(0xffFFF0Eb),
    'berberToplamPuan': '56',
  },
  {
    'berberAdi': 'Emre Kızak',
    'puan': '4.5',
    'imgUrl': 'assets/emrekizak.jpg',
    'bgColor': Color(0xffedf3ca),
    'berberToplamPuan': '36',
  },
  {
    'berberAdi': 'Burhan Keskin',
    'puan': '4.0',
    'imgUrl': 'assets/burhan2.jpg',
    'bgColor': Color(0xffcef1dc),
    'berberToplamPuan': '15',
  },
];

class anaEkran extends StatefulWidget {
  @override
  State<anaEkran> createState() => _anaEkranState();
}

class _anaEkranState extends State<anaEkran> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF478DE0),
      ),
      backgroundColor: const Color(0xFF478DE0),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                // içeriği öğren
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Berberim",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        berberCard(berberData[0]),
                        berberCard(berberData[1]),
                        berberCard(berberData[2]),
                        //berberCard(berberData[3]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  @override
  State<NavigationDrawer> createState() => NavigationDrawerState();
}

class NavigationDrawerState extends State<NavigationDrawer> {
  final AuthService _authService = AuthService();

  var Getemail, Getad, Getsoyad;

  getir() async {
    try {
      final User? userEmail = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('Person')
          .doc(userEmail!.uid)
          .get()
          .then((gelenVeri) {
        if (mounted) {
          setState(() {
            Getad = gelenVeri.data()!['ad'];
            Getsoyad = gelenVeri.data()!['soyad'];
            Getemail = gelenVeri.data()!['email'];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ));
  }

  Widget buildHeader(BuildContext context) {
    getir();
    return Material(
      color: Colors.blue.shade700,
      child: InkWell(
        onTap: () {},
        child: Container(
          color: Colors.blue.shade700,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 52,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          image: ExactAssetImage('assets/onur.jpg'))),
                ),
              ),
              Text(
                '${Getad.toString()} ${Getsoyad.toString()}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                Getemail.toString(),
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Ana Sayfa'),
                onTap: () {
                  return _checkAccountType();
                }),
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Favoriler'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Geçmiş'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Bildirimler'),
              onTap: () {},
            ),
            const Divider(color: Colors.black54),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Çıkış Yap'),
              onTap: () {
                _authService.signOut().then((value) {
                  return Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginPage()));
                });
              },
            ),
          ],
        ),
      );

  String role = "müsteri";

  void _checkAccountType() async {
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
}

class berberCard extends StatelessWidget {
  final berber;
  berberCard(this.berber);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4 - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: berber['bgColor'],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -15,
            right: -50,
            child: Image.asset(
              berber['imgUrl'],
              width: MediaQuery.of(context).size.width * 0.55,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  berber['berberAdi'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star, size: 16, color: Color(0xff4E295B)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      berber['puan'],
                      style: TextStyle(color: Color(0xff4E295B)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => detayEkran(berber)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff4E295B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Seç',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
