import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Pages/homepage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 235, 239, 251),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 159, 177, 241),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50)),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/h.png',
                      scale: 0.8,
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 159, 177, 241),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                padding: EdgeInsets.only(top: 40, bottom: 30),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 235, 239, 251),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50))),
                child: Column(
                  children: [
                    const Text(
                      'Stay on Track with DailyPlanner',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          wordSpacing: 2,
                          color: Color.fromARGB(255, 8, 8, 97)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Welcome to DailyPlanner! Organize tasks and achieve goals effortlessly. Stay focused and never miss a deadline. Let's plan your day and make every moment count!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 19, 23, 29),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Material(
                      color: Color.fromARGB(255, 9, 1, 64),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 60),
                          child: const Text(
                            'Get Start',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
