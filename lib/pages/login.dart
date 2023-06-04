import 'package:classify/widgets/MyCircles.dart';
import 'package:classify/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:classify/user.dart';
import 'package:classify/pages/home.dart';
import 'package:classify/pages/about_us.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var themeid = 4;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 30, 25, 51),
        child: Column(
          children: [
            MyCircles(themeid: themeid, title: 'تسجيل الدخول'),
            SizedBox(height: MediaQuery.of(context).size.height/10,),
            Container(
              // width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Column(
                  children: [
                    // name
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: myColors[themeid]![1],
                              ),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: myColors[themeid]![0], width: 0.0),
                                ),
                                labelText: 'رقم الهاتف',
                                labelStyle: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: myColors[themeid]![1],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // password
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: passwordController,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: myColors[themeid]![1],
                              ),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: myColors[themeid]![0], width: 0.0),
                                ),
                                labelText: 'كلمة السر',
                                labelStyle: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: myColors[themeid]![1],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // login button
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myColors[themeid]![3],
                        ),
                        onPressed: () async {
                          showMyLoadingDialog(context);
                          User user = User();
                          BackendMessage response = await user.loginToBackend(phoneController.text, passwordController.text);
                          Navigator.pop(context);
                          if (response.status == 'success'){
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return HomePage();
                            }));
                          } else {
                            showMyDialog(context, 'خطأ', 'الرقم أو كلمة المورور غير صحيحين !!');
                          }
                        },
                        child: Text('تسجيل الدخول'),
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
