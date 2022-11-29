import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List todo_list = [];
  String _userToDo = '';

 
  @override
  void initState() {
    super.initState();

    todo_list.addAll(['asd', 'sdasd', 'aaaa']);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список дел'),
        backgroundColor: Colors.black45,
      ),
      body: ListView.builder(
          itemCount: todo_list.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(todo_list[index]),
              child: Card(
                child: ListTile(
                  title: Text(todo_list[index]),
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          todo_list.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete_sweep)),
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  todo_list.removeAt(index);
                });
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (BuildContext){return AlertDialog(
              title: Text('Добавить'),
              content: TextField(
                onChanged: (String value) {
                  _userToDo  = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: () {
                    FirebaseFirestore.instance.collection('items').add({'item': _userToDo});
                    Navigator.of(context).pop();
                  
                }, child: Text('Добавить'))
              ],
            );
            });
          },
          child: Icon(
            Icons.add_box,
            color: Colors.green,
          )),
    );
  }
}
