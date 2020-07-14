import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work/mainpage.dart';
import 'package:work/user.dart';

class SliderQuangCao extends StatefulWidget {
  User user;
  SliderQuangCao({Key key, @required this.user}) : super(key: key);
  @override
  _SliderQuangCaoState createState() => _SliderQuangCaoState();
}

final List<String> _imageUrls = [
  "http://sanxuattom.000webhostapp.com/image/hinh1.jpg",
  "http://sanxuattom.000webhostapp.com/image/hinh2.jpg",
  "http://sanxuattom.000webhostapp.com/image/hinh3.jpg",
  "http://sanxuattom.000webhostapp.com/image/hinh4.jpg",
  "http://sanxuattom.000webhostapp.com/image/hinh5.jpg"
];

class _SliderQuangCaoState extends State<SliderQuangCao> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final CarouselSlider autoPlayDemo = CarouselSlider(
      options: CarouselOptions(
          viewportFraction: 0.8,
          aspectRatio: 3 / 4,
          autoPlayInterval: Duration(seconds: 3),
          autoPlay: true,
          enlargeCenterPage: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
              print(_current);
            });
          }),
      items: _imageUrls.map(
        (url) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(
                  url,
                  fit: BoxFit.fill,
                  width: 1000.0,
                ),
              ),
            ),
            onTap: () {
              var route = new MaterialPageRoute(
                  builder: (BuildContext context) => MainPage(
                        user: widget.user,
                      ));

              Navigator.of(context).pushAndRemoveUntil(route,
                  (Route<dynamic> route) {
                print(route);
                return route.isFirst;
              });
            },
          );
        },
      ).toList(),
    );
    return Center(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            autoPlayDemo,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(_imageUrls, (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.redAccent : Colors.green,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
