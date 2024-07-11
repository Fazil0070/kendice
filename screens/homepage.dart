import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kendice/colors.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String username = '';
  late double _width;
  late double _height;
  String _checkInTime = " --/--";
  String _checkOutTime = " --/--";
  bool slideCompleted = false;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              const Column(
                children: [
                  CircleAvatar(
                    minRadius: 30,
                    backgroundImage: AssetImage('lib/assests/avatar1.png'),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("students")
                      .where("id", isEqualTo: user!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error on fetching user id');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      username = snapshot.data!.docs[0]['name'];
                    }

                    return RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Hey there!",
                            style: TextStyle(
                              color: Color.fromARGB(255, 43, 42, 42),
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: '\n$username', // Displaying the username here
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 39, 37, 37),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: DatePicker(
                DateTime.now(),
                height: _height * 0.12,
                width: _width * 0.17,
                initialSelectedDate: DateTime.now(),
                selectedTextColor: Colors.white,
                selectionColor: primary,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              padding: const EdgeInsets.all(16),
              width: _width,
              height: _height * 0.75,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Today attendance",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: _height * 0.15,
                          width: _width * 0.42,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons
                                                .arrowRightToBracket,
                                            color: primary,
                                          ),
                                          const Text(
                                            "Check In",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                _checkInTime,
                                                style: GoogleFonts.lato(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "On Time",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: _height * 0.15,
                          width: _width * 0.42,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons
                                                .arrowRightFromBracket,
                                            color: primary,
                                          ),
                                          const Text(
                                            "Check Out",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                _checkOutTime,
                                                style: GoogleFonts.lato(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "Out Time",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                  Center(
                    child: Builder(
                      builder: (context) {
                        final GlobalKey<SlideActionState> key =
                            GlobalKey<SlideActionState>();
                        return SlideAction(
                          borderRadius: 12,
                          outerColor: Colors.deepPurple.shade400,
                          text: slideCompleted
                              ? "Slide to Check Out"
                              : "Slide to Check In",
                          key: key,
                          onSubmit: () async {
                            try {
                              String currentTime =
                                  DateFormat('HH:mm').format(DateTime.now());

                              // Check if the user document exists
                              DocumentSnapshot<Map<String, dynamic>> userDoc =
                                  await FirebaseFirestore.instance
                                      .collection("students")
                                      .doc(username)
                                      .get();

                              // If the user document doesn't exist, create it
                              if (!userDoc.exists) {
                                await FirebaseFirestore.instance
                                    .collection("students")
                                    .doc(username)
                                    .set({});
                              }

                              if (!slideCompleted) {
                                // Update the check-in time field with the current time
                                await FirebaseFirestore.instance
                                    .collection("students")
                                    .doc(username)
                                    .update({"checkInTime": currentTime});

                                setState(() {
                                  _checkInTime = currentTime;
                                  slideCompleted = true;
                                });
                              } else {
                                // Update the check-out time field with the current time
                                await FirebaseFirestore.instance
                                    .collection("students")
                                    .doc(username)
                                    .update({"checkOutTime": currentTime});

                                setState(() {
                                  _checkOutTime = currentTime;
                                  slideCompleted = true;
                                });
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
