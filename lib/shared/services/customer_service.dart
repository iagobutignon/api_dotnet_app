import 'dart:convert';
import 'dart:io';

import 'package:api_dotnet_app/app/controllers/address_controller.dart';
import 'package:api_dotnet_app/app/controllers/customer_controller.dart';
import 'package:api_dotnet_app/app/controllers/user_controller.dart';
import 'package:api_dotnet_app/app/models/customer_model.dart';
import 'package:api_dotnet_app/shared/utils/endpoints.dart';
import 'package:api_dotnet_app/shared/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CustomerService {
  late BuildContext _context;
  late String basicAuth;

  CustomerService(BuildContext context) {
    _context = context;
    String email =
        Provider.of<UserController>(_context, listen: false).user.userName;
    String password =
        Provider.of<UserController>(_context, listen: false).user.password;
    basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
  }

  Future<void> insert() async {
    Provider.of<CustomerController>(_context, listen: false).customerEditing =
        CustomerModel(
      id: '',
      name: '',
      cpfCnpj: '',
      type: '',
      birthDate: '',
      active: true,
      createdAt: '',
      updatedAt: '',
    );

    var edited = await Navigator.of(_context).pushNamed(Routes.customer);
    print(edited);
    if (edited == null) {
      return;
    }

    CustomerModel customerModel =
        Provider.of<CustomerController>(_context, listen: false)
            .customerEditing;
    customerModel.addresses =
        Provider.of<AddressController>(_context, listen: false).addresses;

    edited = {
      'name': customerModel.name,
      'cpfCnpj': customerModel.cpfCnpj,
      'type': customerModel.type,
      'birthDate': customerModel.birthDate,
      'addresses':
          customerModel.addresses.map((address) => address.toJson()).toList(),
    };

    print(edited);

    final _url = Uri.parse('${Endpoints.customer_url}');
    final response = await http.post(
      _url,
      headers: {
        HttpHeaders.authorizationHeader: basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(edited),
    );

    print(response.statusCode);

    refresh();
  }

  Future<void> edit(CustomerModel customer) async {
    Provider.of<CustomerController>(_context, listen: false).customerEditing =
        customer;

    var edited = await Navigator.of(_context).pushNamed(Routes.customer);

    if (edited == null) {
      return;
    }

    final _url = Uri.parse('${Endpoints.customer_url}/${customer.id}');
    final response = await http.put(
      _url,
      headers: {
        HttpHeaders.authorizationHeader: basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(edited),
    );

    refresh();
  }

  Future<void> remove(String id) async {
    final _url = Uri.parse('${Endpoints.customer_url}/$id');
    await http.delete(
      _url,
      headers: {
        HttpHeaders.authorizationHeader: basicAuth,
      },
    );
    refresh();
  }

  Future<void> refresh() async {
    final _url = Uri.parse('${Endpoints.customer_url}?active=true');
    final response = await http.get(
      _url,
      headers: {
        HttpHeaders.authorizationHeader: basicAuth,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final List body = jsonDecode(response.body);
      final List<CustomerModel> customers = [];
      body.forEach((c) {
        customers.add(CustomerModel(
          id: c['id'] ?? '',
          name: c['name'] ?? '',
          cpfCnpj: c['cpfCnpj'] ?? '',
          type: c['type'],
          birthDate: c['birthDate'] ?? '',
          active: c['active'] ?? '',
          updatedAt: c['updatedAt'] ?? '',
          createdAt: c['createdAt'] ?? '',
        ));
      });

      Provider.of<CustomerController>(_context, listen: false).customers =
          customers;
    }
  }
}
