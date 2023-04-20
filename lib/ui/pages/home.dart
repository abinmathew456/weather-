
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:machine_test/blocs/users/user_bloc.dart';
import 'package:machine_test/blocs/users/user_event.dart';
import 'package:machine_test/blocs/users/user_state.dart';
import 'package:machine_test/repositories/UserRepository.dart';
import 'package:machine_test/services/db.dart';
import 'package:machine_test/ui/pages/user_form.dart';
import 'package:machine_test/ui/pages/weather.dart';

class HomeScreen extends StatelessWidget {


/*  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade200,
        actions: <Widget>[

          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserForm()));
                },
                child: Icon(
                    Icons.add
                ),
              )
          ),
        ],
      ),
      body:BlocProvider(

          create: (context) => UserBloc(UserRepository(),)..add(LoadUserEvent()),
          child:  BlocBuilder<UserBloc, UserState>(
            buildWhen: (previous, current) {

              return true;

            },

            builder: (context, state) {
              if (state is UserLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UserErrorState) {
                return  Center(child:  Text("No Users Found"),);
              }
              if (state is UserLoadedState) {
                List<Map<String, dynamic>>  userList = state.users;
                return userList.length==0?
                Center(child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/nodata.png',width: 270),
                    SizedBox(height: 20,),
                    Text("No Users Found",  style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                  ],
                ),)
                    :ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (_, index) {
                      return  InkWell(
                          onTap: (){

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Weather()));
                          },
                          child:Dismissible(
                            key: Key(userList[index]['id'].toString()),
                            background: Container(
                              color: Colors.red,
                              child: Align(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(Icons.delete),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.red,
                              child: Align(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(Icons.delete),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                            ),
                            confirmDismiss: (direction) async {

                                bool delete = true;
                                final snackbarController = ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Deleted ${userList[index]['fname']}'),
                                    action: SnackBarAction(label: 'Undo', onPressed: () => delete = false),
                                  ),
                                );
                                await snackbarController.closed;
                                return delete;

                            },
                            onDismissed: (_) {
                              Db.deleteData(userList[index]['id']);
                              context.read<UserBloc>().add(LoadUserEvent());
                            },
                            child:Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              child: Card(
                                  color: Colors.white,
                                  child: ListTile(
                                      title: Text(
                                        '${userList[index]['fname']}  ${userList[index]['lname']}',
                                        style: const TextStyle(color: Colors.black),
                                      ),

                                      subtitle: Text(
                                        '${userList[index]['email']}',
                                        style: const TextStyle(color: Colors.grey),
                                      ),

                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage("https://t3.ftcdn.net/jpg/05/17/79/88/360_F_517798849_WuXhHTpg2djTbfNf0FQAjzFEoluHpnct.jpg"),
                                      ))),
                            ),
                          )


                          );
                    });
              }

              return Container();
            },
          )),
    );
  }

}
