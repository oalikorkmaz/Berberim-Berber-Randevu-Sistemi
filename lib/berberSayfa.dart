import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'anaEkran.dart';
import 'loginPage.dart';
import 'services/auth.dart';
import 'randevuSistemi.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class berberSayfa extends StatefulWidget {
  @override
  State<berberSayfa> createState() => _berberSayfaState();
}

class _berberSayfaState extends State<berberSayfa> {
  //List<DocumentSnapshot<Object?>> documents;
  final AuthService _authService = AuthService();

  final Stream<QuerySnapshot> dateRef =
      FirebaseFirestore.instance.collection('date').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF478DE0),
        title: Text(
          'Berber Paneli',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          children: [_tableCalendar(), _streamBuilder()],
        ),
      ),
    );
  }

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: today,
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2030, 3, 14),
      locale: 'tr-TR',
      onDaySelected: _onDaySelected,
      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(day, today),
      startingDayOfWeek: StartingDayOfWeek.monday,
    );
  }

  Widget _streamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: dateRef,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Bir şeyler ters gitti');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Flexible(
          child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Container(
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                    color: Colors.white38,
                    child: ListTile(
                      title: Text(
                        '${data['Ad']} ${data['Soyad']}',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                      subtitle: Text(
                        'Tarih: ${data['Tarih']}, Telefon: ${data['telefon']}, Email: ${data['email']}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  /* void _getirTarih() async {
    List<int> result = new List<int>.empty(growable: true);
    _firestore.collection('date').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['Tarih']);
      });
    });
  } */
}
