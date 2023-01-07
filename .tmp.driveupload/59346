import 'dart:developer';
import 'randevuSistemi.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';

var serviceList = [
  {'baslik': 'Saç', 'süre': 30, 'fiyat': 100},
  {'baslik': 'Sakal', 'süre': 10, 'fiyat': 25},
  {'baslik': 'Saç Bakim', 'süre': 60, 'fiyat': 150},
  {'baslik': 'Saç ve Sakal', 'süre': 45, 'fiyat': 110},
];

class detayEkran extends StatefulWidget {
  @override
  final berber;
  detayEkran(this.berber);
  State<detayEkran> createState() => _detayEkranState();
}

class _detayEkranState extends State<detayEkran> {
  bool servisList = false;
  bool servisList1 = false;
  bool servisList2 = false;
  bool servisList3 = false;

  @override
  Widget ServiceTile(service) {
    return Container(
      child: Wrap(children: [
        ListTile(
          leading: Checkbox(
            value: servisList,
            checkColor: Colors.white,
            activeColor: Colors.amber,
            onChanged: (bool? value) {
              setState(() {
                servisList = value!;
              });
            },
          ),
          title: Text(
            service['baslik'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            '${service['süre']} dakika',
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            '${service['fiyat']}₺',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        )
      ]),
    );
  }

  @override
  Widget ServiceTile1(service) {
    return Container(
      child: Wrap(children: [
        ListTile(
          leading: Checkbox(
            value: servisList1,
            checkColor: Colors.white,
            activeColor: Colors.amber,
            onChanged: (bool? value) {
              setState(() {
                servisList1 = value!;
              });
            },
          ),
          title: Text(
            service['baslik'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            '${service['süre']} dakika',
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            '${service['fiyat']}₺',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        )
      ]),
    );
  }

  @override
  Widget ServiceTile2(service) {
    return Container(
      child: Wrap(children: [
        ListTile(
          leading: Checkbox(
            value: servisList2,
            checkColor: Colors.white,
            activeColor: Colors.amber,
            onChanged: (bool? value) {
              setState(() {
                servisList2 = value!;
              });
            },
          ),
          title: Text(
            service['baslik'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            '${service['süre']} dakika',
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            '${service['fiyat']}₺',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        )
      ]),
    );
  }

  @override
  Widget ServiceTile3(service) {
    return Container(
      child: Wrap(children: [
        ListTile(
          leading: Checkbox(
            value: servisList3,
            checkColor: Colors.white,
            activeColor: Colors.amber,
            onChanged: (bool? value) {
              setState(() {
                servisList3 = value!;
              });
            },
          ),
          title: Text(
            service['baslik'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            '${service['süre']} dakika',
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            '${service['fiyat']}₺',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        )
      ]),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3 + 30,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      'assets/detail_bg.png',
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.purple.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 10,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3 - 30,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 150,
                        ),
                        Text(
                          'Servis Listesi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ServiceTile(serviceList[0]),
                        ServiceTile1(serviceList[1]),
                        ServiceTile2(serviceList[2]),
                        ServiceTile3(serviceList[3]),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: Size.fromHeight(50),
                            backgroundColor: Color(0xffFF8573),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => randevuSistemi()));
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
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3 - 120,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        height: MediaQuery.of(context).size.height / 6 + 55,
                        decoration: BoxDecoration(
                          color: widget.berber['bgColor'],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Positioned(
                              top: 10,
                              right: -25,
                              child: Image.asset(
                                widget.berber['imgUrl'],
                                scale: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget
                                .berber['berberAdi'], // berberin adı ve soy adı
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Color(0xffff8573), // yıldız iconu
                              ),
                              SizedBox(
                                width: 5, //Yıldızla Puan arasındaki boşluk
                              ),
                              Text(
                                widget.berber['puan'],
                                style: TextStyle(
                                  color: Color(0xffFF8535), //puan
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '(${widget.berber['berberToplamPuan']})',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: MediaQuery.of(context).size.height / 3 - 55,
                child: MaterialButton(
                  onPressed: () {},
                  padding: EdgeInsets.all(10),
                  shape: CircleBorder(),
                  color: Colors.white,
                  child: Icon(Icons.favorite_border),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
