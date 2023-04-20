import 'package:machine_test/db/DbHelper.dart';
import 'package:machine_test/model/user_item.dart';

class Db  {

  static insertData(String fname,String lname,String email) async {
    final dbHelper = DbHelper.instance;
   final id= await dbHelper.addUserData(User(null,fname,lname,email));
  }
  static deleteData(int? id) async {
    final dbHelper = DbHelper.instance;
    await dbHelper.delete(id);

  }
}

