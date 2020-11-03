import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget{
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user){
    if(user != null){
      _formData['id'] = user.id;
      _formData['nome'] = user.nome;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Pode ser feito com um cast da classe User
    // final user = ModalRoute.of(context).settings.arguments as User;
    // ou ser feito assim
    final User user = ModalRoute.of(context).settings.arguments;

    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final isValid = _form.currentState.validate();

                if(isValid){
                  _form.currentState.save();

                  Provider.of<Users>(context, listen: false).put(
                      User(
                        id: _formData['id'],
                        nome: _formData['nome'],
                        email: _formData['email'],
                        avatarUrl: _formData['avatarUrl'],
                      ),
                    );

                  Navigator.of(context).pop();
                }
              },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['nome'],
                decoration: InputDecoration(labelText: 'Nome'),
                // ignore: missing_return
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return 'Campo Obrigtório';
                  }
                  if(value.trim().length < 3){
                    return 'Nome muito pequeno';
                  }

                  return null;
                },
                onSaved: (value) => _formData['nome'] = value,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _formData['email'] = value,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'Url do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value,
              )
            ],
        ),
        ),
      ),
    );
  }
}