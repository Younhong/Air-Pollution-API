import 'package:air_pollution_api/models/AirResult.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  AirResult _result;

  //비동기로 데이터 받기
  Future<AirResult> fetchData() async {
    String url = "https://api.airvisual.com/v2/nearest_city?key=";
    String id = "use your api key";

    var response = await http
        .get(url + id);

    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }

  @override
  void initState() {
    super.initState();

    fetchData().then((airResult) {
      setState(() {
        _result = airResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _result == null
            ? CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '현재 위치 미세먼지',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  //여백 주기
                  height: 16,
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          //글 간격을 공간을 두고 띄움
                          children: <Widget>[
                            Image.asset('asset/weather.jpeg', width: 40),
                            Text(
                              '${_result.data.current.pollution.aqius}',
                              style: TextStyle(fontSize: 40),
                            ),
                            Text(
                              getString(_result),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        color: getColor(_result),
                        padding: const EdgeInsets.all(8.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          //글 간격을 공간을 두고 띄움
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.network(
                                  'https://airvisual.com/images/${_result.data.current.weather.ic}.png',
                                  width: 32,
                                  height: 32,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  '${_result.data.current.weather.tp}°',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Text(
                                '습도 ${_result.data.current.weather.hu}%'),
                            Text(
                                '풍속 ${_result.data.current.weather.ws}m/s'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  //여백 주기
                  height: 16,
                ),
                ClipRRect(
                  //모서리를 둥글게 해주는 위젯
                  borderRadius: BorderRadius.circular(30),
                  child: RaisedButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 50), //버튼에 여백 주기
                    color: Colors.orange,
                    child: Icon(Icons.refresh, color: Colors.white),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(AirResult result) {
    if (result.data.current.pollution.aqius <= 50) {
      return Colors.greenAccent;
    } else if (result.data.current.pollution.aqius <= 100) {
      return Colors.yellow;
    } else if (result.data.current.pollution.aqius <= 150) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String getString(AirResult result) {
    if (result.data.current.pollution.aqius <= 50) {
      return '좋음';
    } else if (result.data.current.pollution.aqius <= 100) {
      return '보통';
    } else if (result.data.current.pollution.aqius <= 150) {
      return '나쁨';
    } else {
      return '최악';
    }
  }
}
