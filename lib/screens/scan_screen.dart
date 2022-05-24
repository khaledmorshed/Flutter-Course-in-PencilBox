import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitual_visiting_card/global/selected_line_list.dart';
import 'package:vitual_visiting_card/models/contact_model.dart';
import 'package:vitual_visiting_card/screens/new_contact_screen.dart';
import 'package:vitual_visiting_card/utils/constant_varibale.dart';
import 'package:vitual_visiting_card/widgets/line_item_widget.dart';

class ScanScreen extends StatefulWidget {
  static const String path = '/scan';

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var _line = <String>[];
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;
  String name = "", mobile = "", email = "", address = "", company = "", designation = "",
      website = "", image = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("scan visiting card"),
      actions: [
        TextButton(
            onPressed: _imagePath == null ? null : _createContactModelFromScanText,
            child: Text("next", style: TextStyle(color: Colors.white),)),
      ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: _imagePath == null ?
              Image.asset("images/1.png", width: double.infinity, height: 200, fit: BoxFit.fill,) :
              Image.file(File(_imagePath!), width: double.infinity, height: 200, fit: BoxFit.fill,),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(onPressed: (){
                _imageSource = ImageSource.camera;
                _takePhoto();
              }, icon: Icon(Icons.camera), label: Text("capature with camera")),
              TextButton.icon(onPressed: (){
                _imageSource = ImageSource.gallery;
                _takePhoto();
              }, icon: Icon(Icons.photo_album), label: Text("select from gallery")),
            ],
          ),
          Column(
            children:  _line.map((e) => LineItemWidget(e)).toList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: _imagePath == null ? null : Wrap(
          children: [
            const SizedBox(width: 8,),
            createPropertyButton(ContactProperties.name),
            const SizedBox(width: 8,),
            createPropertyButton(ContactProperties.mobile),
            const SizedBox(width: 8,),
            createPropertyButton(ContactProperties.email),
            const SizedBox(width: 8,),
            createPropertyButton(ContactProperties.address),
            const SizedBox(width: 33,),
            createPropertyButton(ContactProperties.company),
            const SizedBox(width: 8,),
            createPropertyButton(ContactProperties.designation),
            const SizedBox(width: 8,),
            createPropertyButton(ContactProperties.website),
            //const SizedBox(width: 8,),
          ],
        ),
      ),
    );
  }
  void _takePhoto()async{
    final imageFile = await ImagePicker().pickImage(source: _imageSource);
    if(imageFile != null){
      setState((){
        //here .paht return a string of imageFile
        _imagePath = imageFile.path;
      });
      image = _imagePath!;
      //textRecognizer = object of GoogleMlKit.vision.textRecognizer()
      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      //recognizedText = we got our text from image
      final recognizedText = await textRecognizer.processImage(InputImage.fromFile(File(_imagePath!)));
      final _tempLine = <String>[];
      for(var block in recognizedText.blocks){
        for(var line in block.lines){
          _tempLine.add(line.text);
        }
      }
      setState((){
        _line = _tempLine;
      });
    }
  }

  //cusetom button widget
  Widget createPropertyButton(String name) {
    return ElevatedButton(onPressed: (){
      _getTextLine(name);
    }, child: Text(name));
  }

  void _getTextLine(String name2) {
    final mergedText = selectedLines.join(' ');
    switch(name2){
      case ContactProperties.name:
        name = mergedText;
        break;
        case ContactProperties.mobile:
        mobile = mergedText;
        break;
        case ContactProperties.email:
        email = mergedText;
        break;
        case ContactProperties.address:
        address = mergedText;
        break;
        case ContactProperties.company:
        company = mergedText;
        break;
        case ContactProperties.designation:
        designation = mergedText;
        break;
        case ContactProperties.website:
        website = mergedText;
        break;
    }
    selectedLines.clear();
  }

  void _createContactModelFromScanText() {
    final contact = ContactModel(
        name: name,
        mobile: mobile,
        email: email,
        address: address,
        company: company,
        designation: designation,
        website: website,
        image: image,
    );
    Navigator.pushNamed(context, NewContactScreen.path, arguments: contact);
  }
}
