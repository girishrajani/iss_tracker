// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  _getIss();
}

Future<void> _getIss() async {
  var url = "http://api.open-notify.org/iss-now.json";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var lat = jsonResponse['iss_position']["latitude"];
    var long = jsonResponse['iss_position']["longitude"];
    print('Latitude: $lat.');
    print('Longitude: $long.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
