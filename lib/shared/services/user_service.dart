import 'dart:io';

import 'package:api_dotnet_app/app/controllers/user_controller.dart';
import 'package:api_dotnet_app/app/models/user_model.dart';
import 'package:api_dotnet_app/shared/utils/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class UserService {
  late BuildContext _context;

  UserService(BuildContext context) {
    _context = context;
  }

  Future<void> signin(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text('Email ou senha inválidos'),
        ),
      );

      return;
    }

    final _url = Uri.parse('${Endpoints.user_url}');
    final response = await http.post(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': email,
        'password': password,
      }),
    );

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text('Email ou senha inválidos'),
        ),
      );

      return;
    }

    if (response.statusCode == HttpStatus.ok) {
      final userResponse = jsonDecode(response.body);

      final UserModel user = UserModel(
          id: userResponse['id'],
          userName: userResponse['userName'],
          password: password,
          createdAt: userResponse['createdAt'],
          updatedAt: userResponse['updatedAt']);

      Provider.of<UserController>(_context, listen: false).user = user;
    }
  }
}
