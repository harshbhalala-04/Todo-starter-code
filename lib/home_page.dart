// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String newTodo = "";
  List<String> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: todos.length,
        itemBuilder: ((context, index) {
          return Dismissible(
              key: Key(todos[index]),
              child: Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListTile(
                  title: Text(todos[index]),
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Edit Todo"),
                                    content: TextFormField(
                                      initialValue: todos[index],
                                      onChanged: (value) {
                                        newTodo = value;
                                        todos[index] = value;
                                      },
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Save"),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              todos.remove(todos[index]);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add New Todo"),
                  content: TextField(
                    onChanged: (value) {
                      newTodo = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          todos.add(newTodo);
                        });

                        Navigator.of(context).pop();
                      },
                      child: Text("Add"),
                    ),
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
