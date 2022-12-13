import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud_getx/create_user.dart';
import 'package:flutter_firebase_crud_getx/read_users.dart';
import 'package:flutter_firebase_crud_getx/single_user.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUser()));
            }, child: Text("Create User",style: TextStyle(fontSize: 18),),),
            SizedBox(height:20),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ReadUser()));
            }, child: Text("See Users List",style: TextStyle(fontSize: 18),),),
            SizedBox(height:20),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SingleUser()));
            }, child: Text("Single User",style: TextStyle(fontSize: 18),),),
          ],
        ),
      ),
    );
  }
}
