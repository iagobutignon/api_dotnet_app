import 'package:api_dotnet_app/app/models/address_model.dart';
import 'package:flutter/cupertino.dart';

class AddressController with ChangeNotifier {
  List<AddressModel> _addresses = [];
  List<String> _removeAddresses = [];

  List<AddressModel> get addresses => [..._addresses];
  List<String> get removeAddress => [..._removeAddresses];

  Future<void> add(AddressModel address) async {
    _addresses.add(address);

    notifyListeners();
  }

  void addRemoveAddressesList(String id) {
    _removeAddresses.add(id);

    notifyListeners();
  }
}
