import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // se colocar no provider listen: false ele não atualiza a tela com a lista quando adicionar um elemento.
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM
                );
              }
          )
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
          itemBuilder: (context, i) => UserTile(users.byIndex(i))
      ),
    );
  }

}