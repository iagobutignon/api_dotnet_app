import 'package:api_dotnet_app/app/models/address_model.dart';
import 'package:api_dotnet_app/app/models/customer_model.dart';
import 'package:flutter/cupertino.dart';

class CustomerController with ChangeNotifier {
  List<CustomerModel> _customers = [];
  CustomerModel _customerEditing = CustomerModel();
  bool _newCustomer = true;

  List<CustomerModel> get customers => [..._customers];
  CustomerModel get customerEditing => _customerEditing;
  int get count => _customers.length;
  bool get newCustomer => _newCustomer;

  set customers(List<CustomerModel> customers) {
    _customers = customers;

    notifyListeners();
  }

  set customerEditing(CustomerModel customer) {
    _customerEditing = customer;

    notifyListeners();
  }

  set newCustomer(bool value) {
    _newCustomer = value;

    notifyListeners();
  }

  void addAddress(AddressModel addressModel) {
    _customerEditing.addresses.add(addressModel);

    notifyListeners();
  }
}
