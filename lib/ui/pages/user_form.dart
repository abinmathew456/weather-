import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/blocs/user_form/user_form_bloc.dart';
import 'package:machine_test/ui/pages/home.dart';

class UserForm extends StatelessWidget {
   UserForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserFormBloc? _formBloc = BlocProvider.of<UserFormBloc>(context);
    return Scaffold(
      appBar: AppBar(title:Padding(
        padding: const EdgeInsets.only(top: 4,bottom: 3),
        child: Text(
          'Add New Users',
          style: TextStyle(fontFamily:"Gentium",fontSize:17,fontWeight:  FontWeight.normal,color: Colors.white),
        ),
      ),backgroundColor: Colors.redAccent.shade200,
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textFName(),
            SizedBox(height: 20,),
            textLName(),
            SizedBox(height: 20,),
            textEmail(),
            SizedBox(height: 40,),
            SizedBox(
              width: double.infinity,
              height: 50,
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                              textStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 40,
                        child: BlocListener<UserFormBloc, UserFormState>(
                          listener: (context, state) {
                          if (state is UserFormSuccessful) {

                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            } else if (state is UserFormError) {
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                content: Text(state.error),
                                duration: Duration(milliseconds: 5000),
                              ));
                            }
                          },
                          child: ElevatedButton(
                            onPressed: (){
                              _formBloc!.add(SubmitButtonPress(
                                  fname: first_nameController.text, lname: last_nameController.text,email: email_Controller.text));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                              textStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                           /* style: ButtonStyle(
                                shape: MaterialStateProperty
                                    .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(color: Colors.white)))),*/
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
  var first_nameController = TextEditingController();
  var last_nameController = TextEditingController();
  var email_Controller = TextEditingController();
  Padding textFName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18, color: Colors.black),
          controller: first_nameController,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
           labelText:'First Name',
            labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                color: Colors.green.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Padding textLName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18, color: Colors.black),
          controller: last_nameController,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Last Name',
labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                color: Colors.green.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Padding textEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18, color: Colors.black),

          controller: email_Controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                color: Colors.green.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }

}