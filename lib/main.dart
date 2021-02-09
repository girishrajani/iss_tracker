import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(
    MaterialApp(
      home: IssTracker(),
    ),
  );
}

class IssTracker extends StatefulWidget {
  @override
  _IssTrackerState createState() => _IssTrackerState();
}

class _IssTrackerState extends State<IssTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('ISS Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.help_center_rounded,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue[900],
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Text('ISS Tracker'),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                title: Text(
                  'People on ISS',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                title: Text(
                  'Exit',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
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
