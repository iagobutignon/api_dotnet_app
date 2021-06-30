import 'package:api_dotnet_app/app/controllers/address_controller.dart';
import 'package:api_dotnet_app/app/controllers/customer_controller.dart';
import 'package:api_dotnet_app/app/models/address_model.dart';
import 'package:api_dotnet_app/app/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/address_form.dart';
import 'components/address_list.dart';
import 'components/customer_input.dart';

class CustomerView extends StatefulWidget {
  const CustomerView({Key? key}) : super(key: key);

  @override
  _CustomerViewState createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cpfCnpjController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _complementController = TextEditingController();

  void _refreshControllers(CustomerModel customer) {
    _nameController.text = customer.name;
    _cpfCnpjController.text = customer.cpfCnpj;
    _typeController.text = customer.type;
    _birthDateController.text = customer.birthDate;
  }

  Future<void> _saved() async {
    CustomerController controller =
        Provider.of<CustomerController>(context, listen: false);
    controller.customerEditing.name = _nameController.text;
    controller.customerEditing.cpfCnpj = _cpfCnpjController.text;
    controller.customerEditing.type = _typeController.text;
    controller.customerEditing.birthDate = _birthDateController.text;
    Navigator.of(context).pop(true);
  }

  Future<void> _add() async {
    CustomerController controller =
        Provider.of<CustomerController>(context, listen: false);
    final address = await _showAddressSheet();
    if (address != null) {
      setState(() {
        controller.addAddress(address);
      });
    }
  }

  Future<void> _edit(AddressModel addressModel) async {
    CustomerController controller =
        Provider.of<CustomerController>(context, listen: false);

    _cepController.text = addressModel.cep;
    _addressController.text = addressModel.address;
    _numberController.text = addressModel.number;
    _districtController.text = addressModel.district;
    _cityController.text = addressModel.city;
    _stateController.text = addressModel.state;
    _complementController.text = addressModel.complement;

    final address = await _showAddressSheet();
    if (address != null) {
      setState(() {
        controller.customerEditing.addresses
            .removeWhere((a) => a.id == addressModel.id);
        address.id = addressModel.id;
        controller.customerEditing.addresses.add(address);
      });
    }
  }

  Future<dynamic> _showAddressSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddressForm(
          cepController: _cepController,
          addressController: _addressController,
          numberController: _numberController,
          districtController: _districtController,
          cityController: _cityController,
          stateController: _stateController,
          complementController: _complementController,
        );
      },
    );
  }

  Future<void> _delete(String id) async {
    CustomerController customerController =
        Provider.of<CustomerController>(context, listen: false);

    AddressController addressesController =
        Provider.of<AddressController>(context, listen: false);

    addressesController.addRemoveAddressesList(id);
    setState(() => customerController.customerEditing.addresses
        .removeWhere((a) => a.id == id));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (
      context,
    ) {
      CustomerController controller =
          Provider.of<CustomerController>(context, listen: true);
      _refreshControllers(controller.customerEditing);
      return Scaffold(
        appBar: AppBar(
          title:
              Text(controller.newCustomer ? "Novo Cliente" : "Editar Cliente"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomerInput(
                    icon: Icons.person,
                    controller: _nameController,
                    label: 'Nome',
                  ),
                  CustomerInput(
                    icon: Icons.credit_card,
                    controller: _cpfCnpjController,
                    label: 'CPF / CNPJ',
                  ),
                  CustomerInput(
                    onTap: () async {
                      String? type = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () =>
                                    Navigator.of(context).pop('Física'),
                                title: Text('Física'),
                              ),
                              ListTile(
                                onTap: () =>
                                    Navigator.of(context).pop('Jurídica'),
                                title: Text('Jurídica'),
                              ),
                            ],
                          );
                        },
                      );
                      if (type != null) {
                        _typeController.text = type;
                      }
                    },
                    icon: Icons.work,
                    controller: _typeController,
                    label: 'Tipo',
                  ),
                  CustomerInput(
                    onTap: () async {
                      DateTime? birthDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(Duration(days: 365000)),
                        lastDate: DateTime.now(),
                      );
                      if (birthDate != null) {
                        _birthDateController.text = birthDate.toString();
                      }
                    },
                    icon: Icons.date_range_sharp,
                    controller: _birthDateController,
                    label: 'Data de Nascimento',
                  ),
                  OutlinedButton(
                    onPressed: _add,
                    child: Text(
                      "Adicionar Endereço",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                  ),
                  AddressList(
                    edit: _edit,
                    delete: _delete,
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _saved,
          child: Icon(Icons.save),
        ),
      );
    });
  }
}
