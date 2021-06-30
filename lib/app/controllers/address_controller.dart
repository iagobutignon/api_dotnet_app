import 'package:api_dotnet_app/app/models/address_model.dart';
import 'package:flutter/cupertino.dart';

class AddressController with ChangeNotifier {
  List<AddressModel> _addresses = [];

  List<AddressModel> get addresses => [..._addresses];

  Future<void> add(AddressModel address) async {
    _addresses.add(address);

    notifyListeners();
  }
}
