//Local DatabaBase

import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:services/add.dart';
import 'package:services/post_model.dart';

class serviceLearn extends StatefulWidget {
  const serviceLearn({super.key});

  @override
  State<serviceLearn> createState() => _serviceLearnState();
}



class _serviceLearnState extends State<serviceLearn> {

  

List<PostModel> ? _items;
bool _isLoading = false;
late final Dio _networkManager;
final _baseUrl = "http://ipAdress:8080/api/customers/getAll";





@override
  void initState() {
    super.initState();
    _networkManager = Dio(BaseOptions(baseUrl: _baseUrl));
    
       fetchGetItems();
    
   
  }

void _changeLoading() {
  setState(() {
    _isLoading = !_isLoading;
  });
}





void fetchGetItems() async{
  _changeLoading();
  final response = await Dio().get(_baseUrl);

 

  if(response.statusCode == HttpStatus.ok){
    final _datas = response.data;

    if(_datas is List){
      setState(() {
        _items = _datas.map((e) => PostModel.fromJson(e)).toList();
      });
    }
  }
  _changeLoading();
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
   context,
   MaterialPageRoute(
     builder: (BuildContext context) => add()
     ),
);
          }, icon: Icon(Icons.add_circle_outlined)),
          _isLoading ? const CircularProgressIndicator.adaptive():SizedBox.shrink(),],
      ),
      body: ListView.builder(
        itemCount: _items?.length ?? 0 ,
        itemBuilder: (context, index) {
        return _customers(model: _items?[index]);
      },) ,
    );
  }
}

class _customers extends StatelessWidget {
   _customers({
    super.key,
    required PostModel? model,
  }) : _model = model;

  final PostModel? _model;
  late final _delUrl = "http://192.168.1.37:8080/api/customers/{id}?id=${_model?.id}";


  void _delete(int id) async{
    
  final delResponse = await Dio().delete(_delUrl,data: id);

  if(delResponse.statusCode == HttpStatus.ok){
    
  }

}


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(8,5,8,5),
      child: ListTile(
        leading: Text(_model?.id.toString() ?? "id bulunamadı"),
        title: Text(_model?.name ?? "kişi bulunamadı"),
        subtitle: Text(_model?.lastName ?? "kişi bulunamadı"),
        trailing: IconButton(onPressed: (){
        
      _delete(_model?.id ?? 404 );
        }, icon: Icon(Icons.delete),color: Colors.red,),
        ),
    );
  }
}