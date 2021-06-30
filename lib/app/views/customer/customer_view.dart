import 'package:api_dotnet_app/app/controllers/address_controller.dart';
import 'package:api_dotnet_app/app/controllers/customer_controller.dart';
import 'package:api_dotnet_app/app/models/address_model.dart';
import 'package:api_dotnet_app/app/models/customer_model.dart';
import 'package:api_dotnet_app/shared/services/address_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomerView extends StatelessWidget {
  CustomerView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  TextEditingController _cepController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  final Map<String, dynamic> _customerData = {};

  Future<dynamic> _save(BuildContext context) async {
    _formKey.currentState!.save();
    var customer =
        Provider.of<CustomerController>(context, listen: false).customerEditing;

    customer.name = _customerData['name'] ?? '';
    customer.cpfCnpj = _customerData['cpfCnpj'] ?? '';
    customer.type = _customerData['type'] ?? '';
    customer.birthDate = _customerData['birthDate'] ?? '';

    Navigator.of(context).pop(_customerData);
  }

  Future<void> _saveAddress(BuildContext context) async {
    final AddressModel addressModel = AddressModel(
      address: _addressController.text,
      number: _numberController.text,
      district: _districtController.text,
      city: _cityController.text,
      state: _stateController.text,
      cep: _cepController.text,
    );

    Provider.of<AddressController>(context, listen: false).add(addressModel);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cliente'),
        actions: [
          IconButton(
            onPressed: () => _save(context),
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Builder(builder: (context) {
        CustomerController controller =
            Provider.of<CustomerController>(context, listen: true);
        return Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: controller.customerEditing.name,
                    onSaved: (v) => _customerData['name'] = v,
                  ),
                  TextFormField(
                    initialValue: controller.customerEditing.cpfCnpj,
                    onSaved: (v) => _customerData['cpfCnpj'] = v,
                  ),
                  TextFormField(
                    initialValue: controller.customerEditing.type,
                    onSaved: (v) => _customerData['type'] = v,
                  ),
                  TextFormField(
                    initialValue: controller.customerEditing.birthDate,
                    onSaved: (v) => _customerData['birthDate'] = v,
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) {
                      return AddressForm(
                        saveAddress: () => _saveAddress(context),
                        cepController: _cepController,
                        addressController: _addressController,
                        numberController: _numberController,
                        districtController: _districtController,
                        cityController: _cityController,
                        stateController: _stateController,
                      );
                    });
              },
              child: Text("Adicionar Endereço"),
            ),
            Expanded(child: buildListView(context)),
          ],
        );
      }),
    );
  }

  ListView buildListView(BuildContext context) {
    AddressController addressProvider =
        Provider.of<AddressController>(context, listen: true);
    return ListView.builder(
      itemCount: addressProvider.addresses.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(addressProvider.addresses[index].address),
        );
      },
    );
  }
}

class AddressForm extends StatelessWidget {
  final Function saveAddress;
  final TextEditingController cepController;
  final TextEditingController addressController;
  final TextEditingController numberController;
  final TextEditingController districtController;
  final TextEditingController cityController;
  final TextEditingController stateController;

  AddressForm({
    Key? key,
    required this.saveAddress,
    required this.cepController,
    required this.addressController,
    required this.numberController,
    required this.districtController,
    required this.cityController,
    required this.stateController,
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
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
                      onChanged: (_) {},
                      controller: addressController,
                    ),
                  ),
                  Container(
                    width: 100,
                    child: AddressInput(
                      label: 'Número',
                      onChanged: (_) {},
                      controller: numberController,
                    ),
                  ),
                ],
              ),
              AddressInput(
                label: 'Bairro',
                onChanged: (_) {},
                controller: districtController,
              ),
              Row(
                children: [
                  Expanded(
                    child: AddressInput(
                      label: 'Cidade',
                      onChanged: (_) {},
                      controller: cityController,
                    ),
                  ),
                  Container(
                    width: 100,
                    child: AddressInput(
                      label: 'UF',
                      onChanged: (_) {},
                      controller: stateController,
                    ),
                  )
                ],
              ),
              OutlinedButton(
                onPressed: () => saveAddress(),
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressInput extends StatelessWidget {
  final Function onChanged;
  final String label;
  final TextEditingController controller;

  const AddressInput({
    Key? key,
    required this.controller,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (v) => onChanged(v),
      controller: controller,
      decoration: InputDecoration(
        labelText: '$label',
      ),
    );
  }
}
