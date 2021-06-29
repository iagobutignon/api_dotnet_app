import 'package:flutter/material.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({Key? key}) : super(key: key);

  @override
  _CustomersViewState createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
      ),
      body: Center(
        child: Text('Logado'),
      ),
    );
  }
}
