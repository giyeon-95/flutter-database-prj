import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

User loggedInUser;

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget MainCategory(title, url) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _launchURL('$url');
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 17),
                  blurRadius: 17,
                  spreadRadius: -17,
                ),
              ]),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "$title",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
      flex: 1,
    );
  }

  Widget CategoryCard(title, Icon icon) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
      decoration: BoxDecoration(
        color: Color(0xFF2C5BA7),
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 17,
            spreadRadius: -13,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(
            height: 10,
          ),
          Text(
            "$title",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF6691C7),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text(
          "홍익대학교병원",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFF6691C7),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 0, right: 0),
                      child: Image.asset(
                        "images/hospital.png",
                      ),
                      // width: double.infinity,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: <Widget>[
                        MainCategory("공지사항",
                            'http://www.hongik.ac.kr/contents/www/cor/sejong.html'),
                        SizedBox(
                          width: 10,
                        ),
                        MainCategory("새소식",
                            'http://www.hongik.ac.kr/contents/www/cor/generalno.html'),
                        SizedBox(
                          width: 10,
                        ),
                        MainCategory("오시는길",
                            'http://www.hongik.ac.kr/contents/www/cor/sejongroad_1.html'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      children: <Widget>[
                        GestureDetector(
                          child: CategoryCard(
                            "진료예약",
                            Icon(
                              FontAwesomeIcons.stethoscope,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Container(
                                  color: Colors.grey,
                                );
                              }),
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Container(
                                  color: Colors.grey,
                                );
                              }),
                            );
                          },
                          child: CategoryCard(
                            "의사조회",
                            Icon(
                              FontAwesomeIcons.userMd,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Container(
                                  color: Colors.grey,
                                );
                              }),
                            );
                          },
                          child: CategoryCard(
                            "간호사조회",
                            Icon(
                              FontAwesomeIcons.userNurse,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        CategoryCard(
                          "건강 TV",
                          Icon(
                            FontAwesomeIcons.laptopMedical,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        CategoryCard(
                          "코로나공지",
                          Icon(
                            FontAwesomeIcons.shieldVirus,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        CategoryCard(
                          "처방전",
                          Icon(
                            FontAwesomeIcons.fileMedical,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        color: Color(0xFFFAFAFA),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage(
                                "images/hongik-logo.png",
                              ),
                              width: 100,
                            ),
                            Text(
                              "30016 세종특별자치시 조치원읍 세종로 2369",
                              style: TextStyle(fontSize: 11),
                            ),
                            Text("홍익대학교 세종캠퍼스", style: TextStyle(fontSize: 11)),
                            Text("TEL. 044-860-2114",
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}
