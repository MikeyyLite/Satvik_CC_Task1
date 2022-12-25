import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'second_page.dart';
import 'database.dart';
import 'dart:math';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int chosenIndex = 0;
  int i = 0;
  Future _onItemTapped(int index) async {
    docIDs = [];
    setState(() {
      chosenIndex = index;
    });

    await getDocId();

    if (index == 1) {
      return practice();
    }
    if (index == 0) {
      docIDs = [];
    }
  }

  void _setText(title, answer) {
    String text = "";
    String text2 = "";
    docIDs = [];
    setState(() {
      text = title;
      text2 = answer;
    });
  }

  Future updateData(String question, String answer) async {
    final docUser = FirebaseFirestore.instance
        .collection('flashcards')
        .doc()
        .set({'question': question, 'answer': answer});
    debugPrint('----------------------------updated---------------------');
  }

  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('flashcards').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  Future deleteButtonPressed(index) async {
    await FirebaseFirestore.instance
        .collection('flashcards')
        .doc(docIDs[index])
        .delete();
    docIDs = [];
    setState(() {});
  }

  practice() {
    var randomItem = (docIDs.toList()..shuffle()).first;

    print('');
    print('');
    print(docIDs);
    docIDs = [];

    return Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SecondPage(
        title: 'SecondPage',
        documenntid: randomItem,
      );
    }));
  }

  String answer = "";
  String title = "";
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        title: const Text("FLASHCARDS",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        titleSpacing: 0,
        centerTitle: true,
        toolbarHeight: 70,
        toolbarOpacity: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
        ),
        elevation: 0.00,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) {
          return GridView.builder(
            itemCount: docIDs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SecondPage(
                            title: 'SecondPage',
                            documenntid: docIDs[index],
                          );
                        }));
                      },
                      child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                                child: Container(
                                  height: 80,
                                  child: (Text(
                                    'CARD $index',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                                ),
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 62,
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.white, size: 40.0),
                                      tooltip: 'Delete',
                                      onPressed: () =>
                                          deleteButtonPressed(index)),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              return Container(
                child: SimpleDialog(
                  elevation: 20,
                  title: const Text('Enter New Card Info.'),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        decoration:
                            const InputDecoration(labelText: 'Question'),
                        onChanged: (value) => title = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        decoration: const InputDecoration(labelText: 'Answer'),
                        onChanged: (value) => answer = value,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    ElevatedButton(
                        onPressed: () {
                          _setText(title, answer);
                          updateData(title, answer);
                          Navigator.pop(context);
                          docIDs = [];
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(8),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        child: const Text('Submit')),

                    const SizedBox(
                      height: 20,
                    ),
                    Text(text),

                    // changes in text
                    // are shown here
                  ],
                  //   SimpleDialogOption(
                  //     onPressed: () {},
                  //     child: const Text('Option 1'),
                  //   ),
                  //   SimpleDialogOption(
                  //     onPressed: () {},
                  //     child: const Text('Option 2'),
                  //   ),
                ),
              );
            }),
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      // ignore: unnecessary_new
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey,
        ),
        child: BottomNavigationBar(
          selectedFontSize: 30,
          unselectedFontSize: 30,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(null),
              label: 'CARDS',
            ),
            BottomNavigationBarItem(
              icon: Icon(null),
              label: 'PRACTICE',
            ),
          ],
          currentIndex: chosenIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );

    // Widget buildTiles(question, answer) => GridView.builder(
    //       itemCount: 5,
    //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 2),
    //       itemBuilder: (context, index) {
    //         return Card(
    //           color: Colors.black,
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(30.0),
    //           ),
    //           child: Column(
    //             children: [
    //               TextButton(
    //                 onPressed: () {
    //                   Navigator.push(context,
    //                       MaterialPageRoute(builder: (context) {
    //                     return const SecondPage(title: 'SecondPage');
    //                   }));
    //                 },
    //                 child: Container(
    //                     padding:
    //                         const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         const Padding(
    //                           padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
    //                           child: Text(
    //                             'Text',
    //                             textAlign: TextAlign.left,
    //                             style: TextStyle(
    //                                 color: Colors.white, fontSize: 20),
    //                           ),
    //                         ),
    //                         const Padding(
    //                           padding: EdgeInsets.fromLTRB(0.0, 5.0, 8.0, 8.0),
    //                           child: Text(
    //                             'Answer',
    //                             textAlign: TextAlign.left,
    //                             style: TextStyle(
    //                                 color: Colors.white, fontSize: 20),
    //                           ),
    //                         ),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.end,
    //                           children: [
    //                             Padding(
    //                               padding: const EdgeInsets.fromLTRB(
    //                                   0.0, 5.0, 8.0, 0.0),
    //                               child: IconButton(
    //                                 icon: const Icon(Icons.delete,
    //                                     color: Colors.white, size: 40.0),
    //                                 tooltip: 'Delete',
    //                                 onPressed: () {},
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     )),
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     );
  }
}
