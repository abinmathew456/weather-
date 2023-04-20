
import 'package:machine_test/db/DbHelper.dart';

class UserRepository {
   getUsers() async {
    final db = DbHelper.instance;
    List<Map<String, dynamic>>  userList =await  db.getUsers();


      return userList;

  }
}