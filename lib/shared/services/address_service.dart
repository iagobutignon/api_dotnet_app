import 'package:api_dotnet_app/app/controllers/address_controller.dart';
import 'package:api_dotnet_app/app/models/address_model.dart';
import 'package:api_dotnet_app/shared/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class AddressService {
  late BuildContext _context;

  AddressService(BuildContext context) {
    _context = context;
  }

  Future<Map<String, dynamic>> getCep(String cep) async {
    final _url = Uri.parse('${Endpoints.via_cep}/$cep/json/');
    final response = await http.get(_url);

    return jsonDecode(response.body);
    // final body = jsonDecode(response.body);
    // Provider.of<AddressController>(_context, listen: false).addressEditing =
    //     AddressModel(
    //   address: body['logradouro'],
    //   number: '',
    //   district: body['bairro'],
    //   city: body['localidade'],
    //   state: body['uf'],
    //   cep: body['cep'],
    // );
  }
}
