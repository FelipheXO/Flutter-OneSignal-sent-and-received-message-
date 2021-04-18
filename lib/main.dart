import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    // Start OneSignal connection
    OneSignal.shared.init(
      "9b982bd2-a90d-4d30-9601-af4e649bda99",
      iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: false,
      },
    );
    //PARA TIRAR O DISPLA FEIO
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
//Função receber
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {});
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFBC2C3D),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  // Start OneSignal connection

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Start OneSignal connection

  // Start OneSignal connection

  //mensagem
  Future<void> sendMessegerfForAllUser({String title, String body}) async {
    //link da api
    final endpoint = 'https://onesignal.com/api/v1/notifications';
//declarando o dio
    final Dio dio = Dio();
//passando o token para o dio
    dio.options.headers[HttpHeaders.authorizationHeader] =
        'Basic TDBiOTZiZWEtNWU0My00MjQ4LWJhNDctNzQ4NDBhOGQyMTU2';
//testando requisições
    //declrando como responde as repostas do endpoint que é a api declarada encima
    await dio.post(endpoint, data: {
      "app_id": "9b982bd2-a90d-4d30-9601-af4e649bda99",
      "included_segments": ["Subscribed Users"],
      "headings": {"en": "$title"},
      "contents": {"en": "$body"},
    });
  }

  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manda notificação para todos os úsuarios'),
      ),
      body: Center(
        child: Form(
          key: formkey,
          child: Center(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(hintText: 'Título'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (t) {
                      if (t.isEmpty) {
                        return 'Campo obrigatório';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: body,
                    decoration: InputDecoration(hintText: 'Mensagem'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (m) {
                      if (m.isEmpty) {
                        return 'Campo obrigatório';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      color: Color(0xFFBC2C3D),
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          sendMessegerfForAllUser(
                              title: title.text, body: body.text);
                        }
                      },
                      child: Text(
                        'Enviar mensagem',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
