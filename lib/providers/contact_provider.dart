import 'package:flutter/material.dart';
import 'package:vitual_visiting_card/db/contact_db.dart';

import '../models/contact_model.dart';

class ContactProvider with ChangeNotifier{
  List<ContactModel> _contactList = [];
  List<ContactModel> get contactList => _contactList;

  //method for insert contact into table of database
  Future<int> insertContactIntoTableInProvider(ContactModel contactModel){
    return DbHelper.insertContactIntoTableInDb(contactModel);
     }


     //get all contactModel List
  void getAllContactsInProvider() async{
    _contactList = await DbHelper.getAllContactsInDb();
    notifyListeners();
  }

  //when new contact will create
  void addNewContactInotTable(ContactModel model){
    _contactList.add(model);
    notifyListeners();
  }

 //get only one contactModel by id
  Future<ContactModel> getContactsByInProvider(int id) async{
    return await DbHelper.getContactByIdInDb(id);
    //notifyListeners();
  }

  //for deleting a contactModel from table of database
  Future<int> deleteContactByIdInProvider(int id){
    return DbHelper.deleteContactByIdInDb(id);
  }
  //remove from also local contact list
  void removeContactModelFromContactList(ContactModel model){
    _contactList.remove(model);
    notifyListeners();
  }

   //update favorite in table if we use setState (1) go to contact_item_widget.dart
  // Future<int> updateContactFavoriteByIdInProvider(int id, int value){
  //   return DbHelper.updateContactFavoriteByIdInDb(id, value);
  // }

   //update favorite in table if we dont use setState (2) go to contact_item_widget.dart
  void updateContactFavoriteByIdInProvider(int id, int value){
     DbHelper.updateContactFavoriteByIdInDb(id, value);
     final contact = _contactList.firstWhere((element) => element.id == id);
     //je contact list ta change korbo tar index
     final index = _contactList.indexOf(contact);
     _contactList[index].favorite = !_contactList[index].favorite;
     notifyListeners();
  }
  }