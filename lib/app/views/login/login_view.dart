import 'package:api_dotnet_app/shared/services/user_service.dart';
import 'package:flutter/material.dart';

import 'components/login_button.dart';
import 'components/login_input.dart';
import 'components/login_title.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _userData = {
    'email': '',
    'password': '',
  };

  Future<void> _submit(context) async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    UserService(context).signin(_userData['email'], _userData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      LoginTitle('Entrar no app'),
                      LoginInput(
                        title: 'Email',
                        onSaved: (value) => _userData['email'] = value,
                      ),
                      LoginInput(
                        title: 'Senha',
                        onSaved: (value) => _userData['password'] = value,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          LoginButton(
                            title: 'Entrar',
                            onPressed: () => _submit(context),
                          ),
                          LoginButton(
                            title: 'Registrar',
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
