// Created by ferdyhaspin on 06/03/21.

import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'validator.dart';

class Bloc extends Object with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  //add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get submitValue =>
      Observable.combineLatest2(email, password, (a, b) {
        print('email:$a,password:$b');
        return true;
      });

  //change data
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  submit() {
    print('email:${_email.value}, password: ${_password.value}');
  }

  dispose() {
    _email.close();
    _password.close();
  }
}
