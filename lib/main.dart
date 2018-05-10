import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  createState() => new MyAppState();
}

String url = "https://www.doviz.com/api/v1/currencies/all/latest";
List data;

Future<String> istek() async {
  http.Response response = await http.get(url);
  data = JSON.decode(response.body);
  return "Succes";
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Döviz"),
          centerTitle: true,
          backgroundColor: Colors.yellow,
        ),
        body: new Container(
          child: new FutureBuilder(
            future: istek(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new Text('Press button to start');
                case ConnectionState.waiting:
                  return new Text('Awaiting result...');
                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return new ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new ListTile(
                          title: new Text(data[index]['selling'].toString()),
                          trailing: new Text(data[index]['full_name']),
                          leading: new Icon(Icons.monetization_on),
                        );
                      },
                    );
              }
            },
          ),
        ),
      ),
    );
  }
}
