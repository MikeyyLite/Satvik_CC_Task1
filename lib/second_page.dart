import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
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
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                            child: Text(
                              'Card #1',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            width: 800,
                          ),
                          Text(
                            'TITLE',
                            style: TextStyle(color: Colors.white, fontSize: 60),
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
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.navigate_next,
                          color: Colors.white, size: 60.0),
                      onPressed: () {}),
                ],
              ),
            ],
          ),
        ));
  }
}
