import 'package:flutter/material.dart';
import 'package:iss_tracker/people.dart';

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
                heroTag: null,
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.blue[900],
                child: Icon(
                  Icons.navigate_before,
                ),
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => People()),
                  );
                },
                backgroundColor: Colors.blue[900],
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
                color: Colors.red,
                child: ListTile(
                  title: Text(
                    'International Space Center',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    _issInfo,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Image(
              image: AssetImage(
                'assets/iss2.jpg',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Image(
              image: AssetImage(
                'assets/iss1.jpg',
              ),
            )
          ],
        ),
      ),
    );
  }
}
