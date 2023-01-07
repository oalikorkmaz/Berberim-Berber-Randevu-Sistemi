import 'dart:math';

import 'loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'anaEkran.dart';

const TIME_SLOT = {
  '08:00 - 09:00',
  '09:00 - 10:00',
  '10:00 - 11:00',
  '11:00 - 12:00',
  '12:00 - 13:00',
  '13:00 - 14:00',
  '14:00 - 15:00',
  '15:00 - 16:00',
  '16:00 - 17:00',
  '17:00 - 18:00',
  '18:00 - 19:00',
  '19:00 - 20:00',
  '20:00 - 21:00',
  '21:00 - 22:00',
};

class randevuSistemi extends StatefulWidget {
  @override
  State<randevuSistemi> createState() => _randevuSistemi2State();
}

class _randevuSistemi2State extends State<randevuSistemi> {
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
        title: Text(
          'Randevu Alma Sayfası',
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
          children: [
            //displayTimeSlot(),
            _tableCalendar(),
            Goster(),
            _gridView(),
            _randevuAlButon(),
          ],
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

  int selectedCard = -1;
  Widget _gridView() {
    return Expanded(
      child: FutureBuilder(
        future: getTimeSlotOfBarber(DateFormat('dd_MM_yyyy').format(today)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var listTimeSlot = snapshot.data as List<int>;
            return GridView.builder(
                shrinkWrap: false,
                scrollDirection: Axis.vertical,
                itemCount: TIME_SLOT.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: listTimeSlot.contains(index)
                          ? null
                          : () {
                              setState(() {
                                selectedCard = index;
                              });
                            },
                      child: Card(
                        color: listTimeSlot.contains(index)
                            ? Colors.red
                            : selectedCard == index
                                ? Colors.amber
                                : Colors.green,
                        child: Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${TIME_SLOT.elementAt(index)}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                });
          }
        },
      ),
    );
  }

  Widget Goster() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.circle_rounded,
          color: Colors.green,
        ),
        Text('Müsait'),
        SizedBox(width: 15),
        Icon(
          Icons.circle_rounded,
          color: Colors.red,
        ),
        Text('Dolu'),
        SizedBox(width: 15),
        Icon(
          Icons.circle_rounded,
          color: Colors.amber,
        ),
        Text('Seçili'),
        SizedBox(width: 15),
        SizedBox(width: 15),
        Icon(
          Icons.circle_rounded,
          color: Colors.grey,
        ),
        Text('Öğle Arası'),
      ],
    );
  }

  Widget _randevuAlButon() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            padding: EdgeInsets.all(15),
            backgroundColor: Color(0xffFF8573)),
        onPressed: () {
          addTimeSlotOfBarber();
        },
        child: Text(
          'Randevu Al',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  String? ad, soyad, telefon, email;
  getir() async {
    final User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Person')
        .doc(user!.uid)
        .get()
        .then((gelenVeri) {
      setState(() {
        ad = gelenVeri.data()!['ad'];
        soyad = gelenVeri.data()!['soyad'];
        email = gelenVeri.data()!['email'];
        telefon = gelenVeri.data()!['telefon'];
      });
    });
  }

  Future<dynamic> addTimeSlotOfBarber() async {
    await Future.delayed(const Duration(seconds: 1));
    getir();
    var format = "${today.day}-${today.month}-${today.year}";
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var booking = "${TIME_SLOT.elementAt(selectedCard)}, ${format}";
    _firestore.collection('date').add({
      'Tarih': booking,
      'Ad': ad,
      'Soyad': soyad,
      'email': email,
      'telefon': telefon,
    });
  }

  Future<List<int>> getTimeSlotOfBarber(String date) async {
    List<int> result = new List<int>.empty(growable: true);

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var bookingRef = _firestore.collection(date);
    QuerySnapshot snapshot = await bookingRef.get();
    snapshot.docs.forEach((element) {
      result.add(int.parse(element.id));
    });

    return result;
  }
}
