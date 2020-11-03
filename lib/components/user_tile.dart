import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget{

  final User user;


  const UserTile(this.user);


  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
    ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.nome),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: (){
                Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user
                );
              }
          ),
          IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Excluir Usuário'),
                      content: Text('Deseja excluir o usuário?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Não'),
                          onPressed: () => Navigator.of(context).pop(false),
                          /*onPressed: (){
                              Navigator.of(context).pop();
                          },*/
                         ),
                        FlatButton(
                          child: Text('Sim'),
                          onPressed: () => Navigator.of(context).pop(true),
                          /*onPressed: (){
                              Provider.of<Users>(context, listen: false).remove(user);
                              Navigator.of(context).pop();
                          },*/
                        ),
                      ],
                    )
                ).then((confirmed){
                  if(confirmed){
                    Provider.of<Users>(context, listen: false).remove(user);
                  }
                });

              }
          )
        ],
      ),)
    );
  }

}