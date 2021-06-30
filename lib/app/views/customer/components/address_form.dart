import 'package:api_dotnet_app/app/models/address_model.dart';
import 'package:api_dotnet_app/shared/services/address_service.dart';
import 'package:flutter/material.dart';

import 'address_input.dart';

class AddressForm extends StatelessWidget {
  final TextEditingController cepController;
  final TextEditingController addressController;
  final TextEditingController numberController;
  final TextEditingController districtController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController complementController;

  AddressForm({
    Key? key,
    required this.cepController,
    required this.addressController,
    required this.numberController,
    required this.districtController,
    required this.cityController,
    required this.stateController,
    required this.complementController,
  }) : super(key: key);

  Future<void> _searchCep(BuildContext context) async {
    if (cepController.text.length == 8) {
      final cep = await AddressService(context).getCep(cepController.text);
      addressController.text = cep['logradouro'];
      districtController.text = cep['bairro'];
      cityController.text = cep['localidade'];
      stateController.text = cep['uf'];
    }
  }

  Future<dynamic> _saved(BuildContext context) async {
    AddressModel addressModel = AddressModel(
      cep: cepController.text,
      address: addressController.text,
      number: numberController.text,
      district: districtController.text,
      city: cityController.text,
      state: stateController.text,
      complement: complementController.text,
    );
    Navigator.of(context).pop(addressModel);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Endereço',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 36,
                      ),
                    )
                  ],
                ),
                AddressInput(
                  controller: cepController,
                  onChanged: (_) => _searchCep(context),
                  label: 'Cep',
                ),
                Row(
                  children: [
                    Expanded(
                      child: AddressInput(
                        label: 'Endereço',
                        controller: addressController,
                      ),
                    ),
                    Container(
                      width: 100,
                      child: AddressInput(
                        label: 'Número',
                        controller: numberController,
                      ),
                    ),
                  ],
                ),
                AddressInput(
                  label: 'Bairro',
                  controller: districtController,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AddressInput(
                        label: 'Cidade',
                        controller: cityController,
                      ),
                    ),
                    Container(
                      width: 100,
                      child: AddressInput(
                        label: 'UF',
                        controller: stateController,
                      ),
                    ),
                  ],
                ),
                AddressInput(
                  label: 'Complemento',
                  controller: complementController,
                ),
                OutlinedButton(
                  onPressed: () => _saved(context),
                  child: Text(
                    'Salvar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
