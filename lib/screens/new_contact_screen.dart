import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitual_visiting_card/models/contact_model.dart';
import 'package:vitual_visiting_card/providers/contact_provider.dart';

class NewContactScreen extends StatefulWidget {
  static const String path = '/newContact';

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  late ContactProvider _provider;
  bool _init = true;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _companeyController = TextEditingController();
  final _designationController = TextEditingController();
  final _websiterController = TextEditingController();

  //kotho context a change hole eta bar bar call hobe
  //here we get context but in the initState we dont get context
  @override
  void didChangeDependencies(){
    if(_init){
      _provider = Provider.of<ContactProvider>(context, listen:false);
      _init = false;
    }
    super.didChangeDependencies();
  }
  @override
  void dispose(){
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _companeyController.dispose();
    _designationController.dispose();
    _websiterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New contact"),
      actions: [
        IconButton(onPressed: _saveContact,
          icon: Icon(Icons.save),),
      ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "this must not be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _mobileController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Mobile number",
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "this must not be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "email",
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "this must not be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _addressController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "address",
              ),
            ),
            TextFormField(
              controller: _companeyController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Company",
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _designationController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "designation",
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "this must not be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _websiterController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "website",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveContact() {
    if(_formKey.currentState!.validate()){
      //here we create a object(contact) of ContactModel
      final contact = ContactModel(
        name: _nameController.text,
        mobile: _mobileController.text,
        email: _emailController.text,
        address: _addressController.text,
        company: _companeyController.text,
        designation: _designationController.text,
        website: _websiterController.text,
      );
      //it will print from toString()
      //print(contact);
      _provider.insertContactIntoTableInProvider(contact).then((rowId){
        //after insert contact informaiton into table then we get rowId
        contact.id = rowId;
        _provider.addNewContactInotTable(contact);
        Navigator.pop(context);
      }).catchError((onError){
        throw onError;
      });
    }
  }
}
