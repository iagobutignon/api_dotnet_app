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
    CustomerController controller =
        Provider.of<CustomerController>(_context, listen: false);

    controller.customerEditing = CustomerModel(addresses: []);
    controller.newCustomer = true;

    var edited = await Navigator.of(_context).pushNamed(Routes.customer);
    if (edited == null) {
      return;
    }

    CustomerModel customerModel =
        Provider.of<CustomerController>(_context, listen: false)
            .customerEditing;

    final _url = Uri.parse('${Endpoints.customer_url}');
    final response = await http.post(
      _url,
      headers: {
        HttpHeaders.authorizationHeader: basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(customerModel.toJson()),
    );

    refresh();
  }

  Future<void> edit(CustomerModel customer) async {
    CustomerController controller =
        Provider.of<CustomerController>(_context, listen: false);

    controller.customerEditing = customer;
    controller.newCustomer = false;

    var edited = await Navigator.of(_context).pushNamed(Routes.customer);
    if (edited == null) {
      return;
    }

    CustomerModel customerModel =
        Provider.of<CustomerController>(_context, listen: false)
            .customerEditing;

    final _url = Uri.parse('${Endpoints.customer_url}/${customer.id}');
    final response = await http.put(
      _url,
      headers: {
        HttpHeaders.authorizationHeader: basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(customerModel.toJson()),
    );

    final userId = customerModel.id;
    customerModel.addresses.forEach((address) async {
      if (address.id.isEmpty) {
        final addressRequest = address.toJson();
        addressRequest['customerId'] = userId;

        final response = await http.post(
          Uri.parse('${Endpoints.address_url}'),
          headers: {
            HttpHeaders.authorizationHeader: basicAuth,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(addressRequest),
        );
      } else {
        final response = await http.put(
          Uri.parse('${Endpoints.address_url}/${address.id}'),
          headers: {
            HttpHeaders.authorizationHeader: basicAuth,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(address.toJson()),
        );
      }
    });

    controller.removeAddress.forEach((id) async {
      final response = await http.delete(
        Uri.parse('${Endpoints.address_url}/$id'),
        headers: {
          HttpHeaders.authorizationHeader: basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    });

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
      body.forEach((customer) {
        CustomerModel customerModel = CustomerModel();
        customerModel.fromJson(customer);
        customers.add(customerModel);
      });

      Provider.of<CustomerController>(_context, listen: false).customers =
          customers;
    }
  }
}
