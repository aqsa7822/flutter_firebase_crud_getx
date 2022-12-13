import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_crud_getx/Models/users_model.dart';
import 'package:date_field/date_field.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _nameController= TextEditingController();
  final _ageController=TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
        actions: [
          IconButton(onPressed: (){
            final name=_nameController.text;
            final age=int.parse(_ageController.text);
            createUser(name: name, age:age, birthday: selectedDate!);
          }, icon: Icon(Icons.add),iconSize: 22,),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: "Name"),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(hintText: "Age"),
                keyboardType: TextInputType.number,
              ),
              DateTimeField(
                  decoration: const InputDecoration(
                      hintText: 'Please select your birthday date and time'),
                  selectedDate: selectedDate,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      selectedDate = value;
                    });
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future createUser({required String name,required int age, required DateTime birthday})async{
    final docUser= FirebaseFirestore.instance.collection('users').doc();

    final user=Person(id: docUser.id,
      name:name,
      age:age,
      birthday: birthday);
    final json=user.toJson();
    await docUser.set(json);

  }

}