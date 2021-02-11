import 'package:flutter/material.dart';

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
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue[900],
          child: Icon(
            Icons.arrow_back,
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
            ListTile(
              title: Text(
                'International Space Center',
                style: TextStyle(fontSize: 25),
              ),
              subtitle: Text(_issInfo),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                'People on ISS',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            // FutureBuilder(builder: ,)
          ],
        ),
      ),
    );
  }
}

class Data {
  final String name;
  Data(this.name);
}
