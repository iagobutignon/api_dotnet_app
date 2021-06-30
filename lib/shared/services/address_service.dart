import 'package:api_dotnet_app/app/models/address_model.dart';
import 'package:api_dotnet_app/shared/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressService {
  late BuildContext _context;

  AddressService(BuildContext context) {
    _context = context;
  }

  Future<Map<String, dynamic>> getCep(String cep) async {
    final _url = Uri.parse('${Endpoints.via_cep}/$cep/json/');
    final response = await http.get(_url);

    return jsonDecode(response.body);
  }

  Future<void> insert(List<AddressModel> addresses) async {}

  Future<void> update(List<AddressModel> addresses) async {}

  Future<void> delete(List<AddressModel> addresses) async {}
}
