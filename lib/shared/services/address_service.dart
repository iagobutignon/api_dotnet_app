import 'dart:io';

import 'package:api_dotnet_app/app/controllers/address_controller.dart';
import 'package:api_dotnet_app/app/controllers/user_controller.dart';
import 'package:api_dotnet_app/app/models/address_model.dart';
import 'package:api_dotnet_app/shared/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class AddressService {
  late BuildContext _context;
  late String basicAuth;

  AddressService(BuildContext context) {
    _context = context;
    String email =
        Provider.of<UserController>(_context, listen: false).user.userName;
    String password =
        Provider.of<UserController>(_context, listen: false).user.password;
    basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
  }

  Future<Map<String, dynamic>> getCep(String cep) async {
    final _url = Uri.parse('${Endpoints.via_cep}/$cep/json/');
    final response = await http.get(_url);

    return jsonDecode(response.body);
  }

  Future<void> save(String customerId, List<AddressModel> addresses) async {
    addresses.forEach((address) async {
      if (address.id.isEmpty) {
        final response = await insert(customerId, address);
      } else {
        final response = await update(address);
      }
    });
    delete();
  }

  Future<Response?> insert(String customerId, AddressModel address) async {
    final addressRequest = address.toJson();
    addressRequest['customerId'] = customerId;
    return await http.post(
      Uri.parse('${Endpoints.address_url}'),
      headers: {
        HttpHeaders.authorizationHeader: basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(addressRequest),
    );
  }

  Future<Response?> update(AddressModel address) async {
    return await http.put(
      Uri.parse('${Endpoints.address_url}/${address.id}'),
      headers: {
        HttpHeaders.authorizationHeader: basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(address.toJson()),
    );
  }

  Future<void> delete() async {
    AddressController controller =
        Provider.of<AddressController>(_context, listen: false);

    controller.removeAddress.forEach((id) async {
      final response = await http.delete(
        Uri.parse('${Endpoints.address_url}/$id'),
        headers: {
          HttpHeaders.authorizationHeader: basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    });
  }
}
