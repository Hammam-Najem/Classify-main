import 'package:classify/widgets/MyCircles.dart';
import 'package:classify/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  var themeid = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 30, 25, 51),
        child: Column(
          children: [
            MyCircles(themeid: themeid, title: 'Technolab'),
            Expanded(
              child: ListView(
                children: [
                  // technolab image
                  Image(image: AssetImage('assets/images/technolab.png')),
                  // tecnolab icon
                  // ListTile(
                  //   leading: Image(image: AssetImage('assets/icons/technolab.png')),
                  //   title: Text(
                  //     'Technolab Electronics',
                  //     style: TextStyle(
                  //         color: myColors[themeid]![0]
                  //     ),
                  //   ),
                  //   subtitle: Text(
                  //     'For electronic parts and technical solutions\n'+ 'للقطع الإلكترونية والحلول التقنية',
                  //     style: TextStyle(
                  //         color: myColors[themeid]![0]
                  //     ),
                  //   ),
                  //   dense: true,
                  //   isThreeLine: true,
                  // ),
                  // map
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    height: 300,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(32.226673, 35.222009),
                        zoom: 17.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(32.226673, 35.222009),
                              width: 80,
                              height: 80,
                              builder: (context) => Icon(Icons.location_on, color: myColors[themeid]![0], size: 70,),

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // facebook
                  ListTile(
                    leading: Icon(Icons.facebook, color: myColors[themeid]![0], size: 70),
                    subtitle: SelectableText(
                      'fb.com/technolab.electronics',
                      style: TextStyle(
                          color: myColors[themeid]![0]
                      ),
                    ),
                  ),
                  // email
                  ListTile(
                    leading: Icon(Icons.email, color: myColors[themeid]![0], size: 70),
                    subtitle: SelectableText(
                      'technolab.electronics@gmail.com',
                      style: TextStyle(
                          color: myColors[themeid]![0]
                      ),
                    ),
                  ),
                  // telephone number
                  ListTile(
                    leading: Icon(Icons.phone_android, color: myColors[themeid]![0], size: 70),
                    subtitle: SelectableText(
                      '972568182180+',
                      style: TextStyle(
                          color: myColors[themeid]![0]
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
