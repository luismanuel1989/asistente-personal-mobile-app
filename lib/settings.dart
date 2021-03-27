

import 'package:controlVoiceApp/main.dart';
import 'package:controlVoiceApp/sensors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

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
                selected: true,
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
          title: Text("Configuraciones"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Ajustar temperatura de sala"),
              subtitle: Text("Ajuste la temperatura para que la ssala se mantenga a una temperatura contante"),
              onTap: (){

              },
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: CupertinoTextField(
                placeholder: "Enter new Value",
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: FlatButton(onPressed: (){

              }, child: Text("Guardar")),
            ),

            ListTile(
              title: Text("Ajustar valor maximo de sensor de luz"),
              subtitle: Text("Ajustar valor en el que la alarma dispara"),
              onTap: (){

              },

            ),
            Container(
              margin: EdgeInsets.all(10),
              child: CupertinoTextField(
                placeholder: "Enter new Value",
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: FlatButton(onPressed: (){

              }, child: Text("Guardar")),
            ),

          ],
        )
    );

  }
}
