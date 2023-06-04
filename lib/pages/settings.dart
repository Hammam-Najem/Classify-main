import 'package:classify/widgets/MyCircles.dart';
import 'package:classify/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:classify/user.dart';
import 'about_us.dart';
import 'bluetooth_serial/MainPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var themeid = 4;
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 30, 25, 51),
        child: Column(
          children: [
            MyCircles(themeid: themeid, title: 'الإعدادات'),
            SizedBox(height: 50,),
            Container(
              // material design
              // height: 200,
              // width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Column(
                  children: [
                    // bluetooth settings button
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myColors[themeid]![3],
                        ),
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return BluetoothSerialMainPage();
                          }));
                        },
                        child: Text('إعدادات WIFI'),
                      ),
                    ),
                    // Who are we
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: ListTile(
                          leading: Icon(Icons.info, color: myColors[themeid]![0]),
                          title: Text(
                            'من نحن',
                            style: TextStyle(
                                color: myColors[themeid]![0]
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return AboutUs();
                            }));
                          },
                        )
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
