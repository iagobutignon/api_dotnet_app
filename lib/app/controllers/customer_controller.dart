import 'package:api_dotnet_app/app/models/customer_model.dart';
import 'package:flutter/cupertino.dart';

class CustomerController with ChangeNotifier {
  List<CustomerModel> _customers = [];
  CustomerModel _customerEditing = CustomerModel(
    id: '',
    name: '',
    cpfCnpj: '',
    type: '',
    birthDate: '',
    active: true,
    createdAt: '',
    updatedAt: '',
  );

  List<CustomerModel> get customers => [..._customers];
  int get count => _customers.length;

  CustomerModel get customerEditing => _customerEditing;

  set customers(List<CustomerModel> customers) {
    _customers = customers;

    notifyListeners();
  }

  set customerEditing(CustomerModel customer) {
    _customerEditing = customer;

    notifyListeners();
  }
}
