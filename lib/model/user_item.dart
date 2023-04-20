
import 'package:machine_test/db/DbHelper.dart';

class User {
   int? id;
 late String fname;
  late String  lname;
  late String email;


  User(this.id, this.fname, this.lname, this.email);

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    fname = map['fname'];
    lname = map['lname'];
    email = map['email'];
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.columnId: id,
      DbHelper.columnFname: fname,
      DbHelper.columnLname: lname,
      DbHelper.columnEmail: email,
    };
  }
}