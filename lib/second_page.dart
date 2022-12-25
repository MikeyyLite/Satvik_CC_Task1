import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';

class SecondPage extends StatelessWidget {
  final String documenntid;
  final String title;
  SecondPage({Key? key, required this.title, required this.documenntid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference flashcards =
        FirebaseFirestore.instance.collection('flashcards');

    return FutureBuilder<DocumentSnapshot>(
        future: flashcards.doc(documenntid).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            print(data);

            return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  title: const Text("FLASHCARDS",
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                  toolbarHeight: 70,
                  toolbarOpacity: 1,
                  titleSpacing: 0,
                  centerTitle: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white12,
                ),
                body: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
                        child: SizedBox(
                          height: 300,
                          width: 800,
                          child: Card(
                              color: Colors.white12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 50.0, 0.0, 0.0),
                                    child: Text(
                                      'CARD $documenntid',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 800,
                                  ),
                                  Text(
                                    '${data['question']}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 60),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Show Answer',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.navigate_next,
                                  color: Colors.white, size: 60.0),
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                        child: AlertDialog(
                                      elevation: 20,
                                      title: Text(
                                        ' Q| ${data['question']} \n \n A| ${data['answer']}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ));
                                  })),
                        ],
                      ),
                    ],
                  ),
                ));
          }
          return Text('');
        }));
  }
}
