import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitual_visiting_card/providers/contact_provider.dart';
import 'package:vitual_visiting_card/screens/scan_screen.dart';

import '../widgets/contact_item_widget.dart';
import 'new_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  static const String path = '/';

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  bool _init = true;

  @override
  void didChangeDependencies(){
    if(_init){
      final provid = Provider.of<ContactProvider>(context).getAllContactsInProvider();
      _init = false;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact list"),),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index){
            final contact = provider.contactList[index];
            return ContactItemWidget(contact);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, ScanScreen.path);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
