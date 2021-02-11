import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: ISS(),
  ));
}

class ISS extends StatefulWidget {
  @override
  _ISSState createState() => _ISSState();
}

class _ISSState extends State<ISS> {
  var _issInfo =
      'The International Space Station (ISS) is a multi-nation construction project that is the largest single structure humans ever put into space. Its main construction was completed between 1998 and 2011, although the station continually evolves to include new missions and experiments';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.navigate_before,
                ),
              ),
              FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.people,
                ),
              )
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            Image(
              image: AssetImage(
                'assets/iss.jpg',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Colors.tealAccent,
                child: ListTile(
                  title: Text(
                    'International Space Center',
                    style: TextStyle(fontSize: 25),
                  ),
                  subtitle: Text(_issInfo),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Card(
                color: Colors.tealAccent,
                child: ListTile(
                  title: Text(
                    'People on ISS',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
