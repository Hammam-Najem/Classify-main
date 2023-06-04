import 'package:classify/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetoHome();
  }

  _navigatetoHome() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splashPage.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText(
                          'حصص المدرسة',
                          textStyle: const TextStyle(
                              fontSize: 56.0,
                              color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          duration: const Duration(milliseconds: 5000),
                          // speed: const Duration(milliseconds: 200),
                        ),
                      ],
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
              ),
            ],
          )
        ],
      ),
    );
  }
}
