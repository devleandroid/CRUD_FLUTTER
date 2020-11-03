import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/user_form.dart';
import 'package:flutter_crud/views/user_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
          create: (context) => Users()
        )
    ],
        child: MaterialApp(
          title: 'My App CRUD',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
          home: UserList(),
          routes: {
            //AppRoutes.HOME: (context) => UserList(),
            AppRoutes.USER_FORM: (context) => UserForm()
          },//MyHomePage(title: 'Flutter Demo Home Page'),
    )
    );
  }
}
