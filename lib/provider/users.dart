import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_crud/data/dummy.dart';
import 'package:flutter_crud/models/user.dart';

class Users with ChangeNotifier{
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all{
    return [..._items.values];
  }


  int get count{
    return _items.length;
  }

  User byIndex(int idx){
    return _items.values.elementAt(idx);
  }

  void put(User user){
    if(user == null){
      return;
    }

    if(user.id != null && user.id.trim().isNotEmpty && _items.containsKey(user.id)){
      // adicionar
        _items.update(user.id, (_) => User(
            id: user.id,
            nome: user.nome,
            email: user.email,
            avatarUrl: user.avatarUrl
        ));
    } else {
      // altera
      final id = Random().nextDouble().toString();
      _items.putIfAbsent('1000', () => User(
          id: '1000',
          nome: user.nome,
          email: user.email,
          avatarUrl: user.avatarUrl
      ));
    }

    notifyListeners();
  }

  void remove(User user){
    if(user != null && user.id != null){
      _items.remove(user.id);
      notifyListeners();
    }
  }
}