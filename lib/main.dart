import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  GoogleMapController _controller;
  Marker marker;
  Set<Marker> _markers = {};
  var lat, long;
  CameraPosition _camPos;

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
              Icons.refresh,
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
      floatingActionButton: FloatingActionButton(
        // onPressed: _track,
        onPressed: () {},
        backgroundColor: Colors.blue[900],

        child: Column(
          children: [
            Icon(
              Icons.location_searching,
            ),
            Text(
              'Find ISS',
            ),
          ],
        ),
      ),
      body: GoogleMap(
        markers: Set.of((marker != null) ? [marker] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        // mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: const LatLng(0, 0),
          zoom: 2,
        ),
      ),
    );
  }

  Future<void> _getIss(GoogleMapController controller) async {
    var url = "http://api.open-notify.org/iss-now.json";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var lati = jsonResponse['iss_position']['latitude'];
      var longi = jsonResponse['iss_position']['longitude'];
      lat = double.parse(lati);
      long = double.parse(longi);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
