import 'package:flutter/material.dart';
import 'second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int chosenIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      chosenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
      body: GridView.builder(
        itemCount: 5,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
                      return const SecondPage(title: 'SecondPage');
                    }));
                  },
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                            child: Text(
                              'Text',
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 5.0, 8.0, 8.0),
                            child: Text(
                              'Answer',
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 5.0, 8.0, 0.0),
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white, size: 40.0),
                                  tooltip: 'Delete',
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black
        ),
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
    ));
  }
}
