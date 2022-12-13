import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud_getx/Models/users_model.dart';

class SingleUser extends StatefulWidget {
  const SingleUser({Key? key}) : super(key: key);

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  final docUser=FirebaseFirestore.instance.collection("users").doc("8QMgGqVjqZgDgvSBpI98");
  @override
  Widget build(BuildContext context) {
    final _nameController=TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Single User"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FutureBuilder<Person?>(
              future: readUser(),
              builder: (context,snapshot){
                if(snapshot.hasError){
                  return Center(child: Text("${snapshot.error}"),);
                }
                else if(snapshot.hasData){
                  final user=snapshot.data;
                  return user==null ? Center(child: Text("No user"),):buildUser(user);
                }
                else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "Add the updated name"),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              docUser.update({'name':_nameController.text});
            }, child: Text("Update")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              docUser.delete();
            }, child: Text("Delete")),
          ],
        ),
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
  Future<Person?> readUser() async {
    final snapshot=await docUser.get();

    if (snapshot.exists){
      return Person.fromJson(snapshot.data()!);
    }
  }
}
