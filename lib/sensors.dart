

import 'package:controlVoiceApp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Sensors extends StatefulWidget {
  @override
  _SensorsState createState() => _SensorsState();
}

class _SensorsState extends State<Sensors> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text("Control por Voz"),
                decoration: BoxDecoration(
                    color: Colors.blue
                ),
              ),
              ListTile(
                trailing: Icon(Icons.person_outline),
                title: Text("Mi perfil"),
                onTap: (){

                },
              ),
              ListTile(

                hoverColor: Colors.blue,
                focusColor: Colors.blue,
                trailing: Icon(Icons.mic),

                title: Text("Comandos de Voz"),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (_) => MyHomePage()));
                },
              ),
              ListTile(
                selected: true,
                trailing: Icon(Icons.gradient),
                title: Text("Sensores"),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (_) => Sensors()));
                },
              ),
              ListTile(
                trailing: Icon(Icons.lightbulb_outline),
                title: Text("Actuadores"),
                onTap: (){

                },
              ),
              ListTile(
                trailing: Icon(Icons.settings),
                title: Text("Configuraciones"),
                onTap: (){

                },
              ),
              ListTile(
                trailing: Icon(Icons.accessibility_new),
                title: Text("Lista de acciones"),
                onTap: (){

                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Sensores"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Sensor de Temperatura"),
              subtitle: Text("Temp: 36"),
              onTap: (){

              },
            ),
            ListTile(
              title: Text("Sensor de Presion"),
              subtitle: Text("P: 31"),
              onTap: (){

              },
            ),
            ListTile(
              title: Text("Sensor de luz"),
              subtitle: Text("Lum: 56"),
              onTap: (){

              },
            ),
            ListTile(
              title: Text("Sensor de precencia"),
              subtitle: Text("False"),
              onTap: (){

              },
            )
          ],
        )
    );

  }
}
