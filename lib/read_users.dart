import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud_getx/Models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ReadUser extends StatefulWidget {
  const ReadUser({Key? key}) : super(key: key);

  @override
  State<ReadUser> createState() => _ReadUserState();
}

class _ReadUserState extends State<ReadUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User's List"),
      ),
      body: StreamBuilder<List<Person>>(
        stream: readUser(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text('${snapshot.error}');
          }
          else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(children: users.map(buildUser).toList(),);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(Person user) => ListTile(
        leading: CircleAvatar(
          child: Text('${user.age}'),
        ),
        title: Text(user.name),
        subtitle: Text(user.birthday.toIso8601String()),
      );

  Stream<List<Person>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Person.fromJson(doc.data())).toList());
}
