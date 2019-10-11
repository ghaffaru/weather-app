import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
  }

  void getData() async {
    http.Response response = await http.get('https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
//    print(response.statusCode);

    if (response.statusCode == 200) {
      
      String data = response.body;
      var decodedData = jsonDecode(data);

      int condition = decodedData['weather'][0]['id'];
      double temperature = decodedData['main']['temp'];
      String city = decodedData['name'];

      print(condition);
      print(temperature);
      print(city);

    }else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
//            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
