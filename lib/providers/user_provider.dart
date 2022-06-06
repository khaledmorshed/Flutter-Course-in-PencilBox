import 'package:flutter/foundation.dart';
import '../db/db_helper.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  //UserModel? userModel;
  Future<void> addUser(UserModel userModel) {
    return DBHelper.addNewUser(userModel);
  }

  Future<UserModel?> getCurrentUserDetails(String userId) async{
    final snapshot = await DBHelper.fetchUserDetails(userId);
    if(!snapshot.exists){
      return null;
    }
    final userModel = UserModel.fromMap(snapshot.data()!);
    return userModel;
    //direct returned object of userModel
    // return UserModel.fromMap(snapshot.data()!);

    //it will be for our local bus concept for sqflite
    // DBHelper.fetchUserDetails(userId).then((snapshot) {
    //     if(snapshot.exists){
    //       userModel = UserModel.fromMap(snapshot.data()!);
    //     }
    // });
  }
  Future<void> updateUserAddress(String userId, String address) =>
      DBHelper.updateDeliveryAddress(userId, address);
}