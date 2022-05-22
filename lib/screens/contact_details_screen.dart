import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/contact_model.dart';
import '../providers/contact_provider.dart';
class ContactDetailsScreen extends StatelessWidget {
  static const String path = '/detailsScreen';

  @override
  Widget build(BuildContext context) {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    final id = argList[0];
    final name = argList[1];
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Consumer<ContactProvider>(
          builder: (context, provider, child){
            return FutureBuilder<ContactModel>(
              future: provider.getContactsByInProvider(id),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  final contact = snapshot.data;
                  return buildListView(contact, context);
                }
                if(snapshot.hasError){
                  return const Text("Failed to fetch data");
                }
                return CircularProgressIndicator();
              }
            );
          },
        ),
      ),
    );
  }

  Widget buildListView(ContactModel? contact, BuildContext context) {
    return ListView(
        children: [
          Image.network(contact!.image, width: double.infinity, height: 250, fit: BoxFit.fill,),
         ListTile(
           title: Text(contact.mobile),
           trailing: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
                IconButton(onPressed: (){
                  _call(contact.mobile, context);
                }, icon: Icon(Icons.call)),
               IconButton(onPressed: (){
                 _sms(contact.mobile, context);
               }, icon: Icon(Icons.sms)),
             ],
           ),
         ),
          ListTile(
            title: Text(contact.email),
            trailing: IconButton(onPressed: (){
              _email(contact.email, context);
            }, icon: Icon(Icons.email))
          ),
          ListTile(
              title: Text(contact.address),
              trailing: IconButton(onPressed: (){
                _map(contact.address, context);
              }, icon: Icon(Icons.map))
          ),
          ListTile(
              title: Text(contact.website),
              trailing: IconButton(onPressed: (){
                _website(contact.website, context);
              }, icon: Icon(Icons.web))
          )
        ],
      );
  }

  void _call(String mobile, BuildContext context) async{
      final uri = "tel:$mobile";
      if(await canLaunchUrlString(uri)){
        await launchUrlString(uri);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not launch application")));
        throw "Could not launch application";
      }
  }

  void _sms(String mobile, BuildContext context)async {
    final uri = "sms:$mobile";
    if(await canLaunchUrlString(uri)){
      await launchUrlString(uri);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not launch application")));
      throw "Could not launch application";
    }
  }

  void _email(String email, BuildContext context) async{
    final subject = "Test";
    final body = "This is test";
    final uri = "mailto:$email?subject=$subject&body=$body";
    if(await canLaunchUrlString(uri)){
      await launchUrlString(uri);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not launch application")));
      throw "Could not launch application";
    }
  }

  void _map(String address, BuildContext context) async{
    final uriAndroid = "geo:0,0?q=1600+Amphitheatre+Parkway%2C+CA";
    final uriIos = "http://maps.apple.com/?q=Mexican+Restaurant";
    if(Platform.isAndroid){
      if(await canLaunchUrlString(uriAndroid)){
        await launchUrlString(uriAndroid);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not launch application")));
        throw "Could not launch application";
      }
    }else if(Platform.isIOS){
      if(await canLaunchUrlString(uriIos)){
        await launchUrlString(uriIos);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not launch application")));
        throw "Could not launch application";
      }
    }
  }

  void _website(String website, BuildContext context)async {
    final uri = "https://$website";
    if(await canLaunchUrlString(uri)){
      await launchUrlString(uri);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not launch application")));
      throw "Could not launch application";
    }
  }
}
