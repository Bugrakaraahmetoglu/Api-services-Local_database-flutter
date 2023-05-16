import 'package:flutter/material.dart';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:services/add.dart';
import 'package:services/post_model.dart';

class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}



class _addState extends State<add> {

  

bool _isLoading = false;
late final Dio _networkManager;
late final _baseUrl = "http://192.168.1.37:8080/api/customers?name=${_nameController.text}&lastName=${_lastNameController.text}";

 TextEditingController _nameController = TextEditingController();
 TextEditingController _lastNameController = TextEditingController();



@override
  void initState() {
    super.initState();
    
    
   
  }

void _changeLoading() {
  setState(() {
    _isLoading = !_isLoading;
  });
}


void _addCustomer(PostModel postModel) async {
  _changeLoading();
  final response = await Dio().post(_baseUrl,data: postModel);

  if(response.statusCode == HttpStatus.created){
   
  }
  _changeLoading();
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          _isLoading ? const CircularProgressIndicator.adaptive():SizedBox.shrink(),],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
           
           TextField(
            controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),),
              
              SizedBox(height: 10,),
             
             TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: "Last name")),

              ElevatedButton(onPressed:
               (){  
                setState(() {
                  late final  model = PostModel(name: _nameController.text,lastName: _lastNameController.text); 
               _addCustomer(model);
                });
               
               debugPrint(_lastNameController.text);
               debugPrint(_nameController.text);
               Navigator.pop(context);
              }, child: Text("Kaydet"),)
          ],
        ),
      )
    );
  }
}

