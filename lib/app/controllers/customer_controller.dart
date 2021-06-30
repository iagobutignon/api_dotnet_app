import 'package:api_dotnet_app/app/models/address_model.dart';
import 'package:api_dotnet_app/app/models/customer_model.dart';
import 'package:flutter/cupertino.dart';

class CustomerController with ChangeNotifier {
  List<CustomerModel> _customers = [];
  CustomerModel _customerEditing = CustomerModel();
  bool _newCustomer = true;
  String _filter = '';
  String _filterOption = 'name';

  List<CustomerModel> get customers {
    if (_filter == '' || _filter.isEmpty) {
      return [..._customers];
    }
    if (_filterOption == 'name') {
      return [..._customers]
          .where((customer) =>
              customer.name.toLowerCase().contains(_filter.toLowerCase()))
          .toList();
    } else if (_filterOption == 'cpfCnpj') {
      return [..._customers]
          .where((customer) => customer.cpfCnpj == _filter)
          .toList();
    } else if (_filterOption == 'status') {
      if (_filter == 'active') {
        return [..._customers]
            .where((customer) => customer.active == true)
            .toList();
      }
      if (_filter == 'inactive') {
        return [..._customers]
            .where((customer) => customer.active == false)
            .toList();
      }
    }
    return [..._customers];
  }

  int get count {
    if (_filter == '' || _filter.isEmpty) {
      return _customers.length;
    }
    if (_filterOption == 'name') {
      return [..._customers]
          .where((customer) =>
              customer.name.toLowerCase().contains(_filter.toLowerCase()))
          .toList()
          .length;
    } else if (_filterOption == 'cpfCnpj') {
      return [..._customers]
          .where((customer) => customer.cpfCnpj == _filter)
          .toList()
          .length;
    } else if (_filterOption == 'status') {
      if (_filter == 'active') {
        return [..._customers]
            .where((customer) => customer.active == true)
            .toList()
            .length;
      }
      if (_filter == 'inactive') {
        return [..._customers]
            .where((customer) => customer.active == false)
            .toList()
            .length;
      }
    }
    return _customers.length;
  }

  CustomerModel get customerEditing => _customerEditing;
  bool get newCustomer => _newCustomer;
  String get filter => _filter;
  String get filterOption => _filterOption;

  set filter(String filter) {
    _filter = filter;

    notifyListeners();
  }

  set filterOption(String option) {
    _filter = '';
    _filterOption = option;

    notifyListeners();
  }

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
