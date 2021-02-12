import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(People());
}

class People extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'People on ISS',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: GetData(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: Colors.blue[900],
          child: Icon(
            Icons.navigate_before,
          ),
        ),
      ),
    );
  }
}

class GetData extends StatefulWidget {
  @override
  _GetDataState createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  Future<List<Data>> _getData() async {
    var url = 'http://api.open-notify.org/astros.json';
    var response = await http.get(url);
    List<Data> data1 = [];
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var people = jsonResponse['people'];
      for (var i in people) {
        var astroName = i['name'];
        Data presentData = Data(astroName);
        data1.add(presentData);
      }
    }
    return data1;
  }

  void _openLink(String astroname) async {
    var url = 'https://duckduckgo.com/?q=';
    var _mainUrl = url + astroname;
    if (await canLaunch(_mainUrl)) {
      await launch(_mainUrl);
    } else {
      throw 'Could not launch $_mainUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: SizedBox(
                height: 75,
                width: 75,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                  strokeWidth: 7,
                ),
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    _openLink(snapshot.data[index].name);
                  },
                  splashColor: Colors.pink,
                  child: Card(
                    color: Colors.red,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class Data {
  final String name;
  Data(this.name);
}
