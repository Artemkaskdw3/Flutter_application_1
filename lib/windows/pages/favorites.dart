import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/windows/help/Grid.dart';

import '../Auth/services/user.dart';

class MainWindow extends StatefulWidget {
  const MainWindow({Key? key}) : super(key: key);

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  @override
    final ScrollController _controller = ScrollController();

  void _scrollToTop() {
    if (_controller.hasClients) {
      _controller.animateTo(0,
          duration: const Duration(milliseconds: 30), curve: Curves.linear);
    }
  }
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final uid = AuthUser.fromFirebase(user).id;
    
    final Stream<QuerySnapshot> _isFavorite = FirebaseFirestore.instance
        .collection(uid.toString())
        .where('favorites', isEqualTo: true)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title:   const Text(
              'ZaEdy',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            actions: [
              IconButton(
              onPressed: () {
                setState(() {
                  _scrollToTop();
                  _MainWindowState();
                });
              },
              icon: Icon(Icons.refresh)),
            ],
        centerTitle: true,
        backgroundColor: Colors.black,
        ),
      body: Container(
        
          margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Column(children: [
            StreamBuilder<QuerySnapshot>(
                stream: _isFavorite,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading');
                  }
                  if (snapshot.data!.docs.isEmpty == true) {
                    return Container(
                        padding: const EdgeInsets.only(top: 250),
                        width: 200,
                        child: const AutoSizeText(
                          "Oh!Nothing in favorites!",
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ));
                  }
                  return Expanded(
                    
                    child: SizedBox(
                      height: 200,
                      child: ListView(
                                    // gridDelegate:
                                    //     const SliverGridDelegateWithFixedCrossAxisCount(
                                    //   mainAxisExtent: 200,
                                    //   mainAxisSpacing: 100,
                                    //   crossAxisSpacing: 10,
                                    //   crossAxisCount: 1,
                                    // ),
                      children: snapshot.data!.docs
                                            .map<Widget>((DocumentSnapshot document) {
                                          Map<String, dynamic> data =
                                              document.data() as Map<String, dynamic>;
                                              return GridWidget(id: data['recipeId'],
                                              title: data['title'],
                                              image: data['image'].toString()
                                              );
                                                
                                        }).toList(),
                      ),
                    ),
                  );
                })
          ])),
    );
  }
}
