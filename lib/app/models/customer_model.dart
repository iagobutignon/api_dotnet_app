import 'package:api_dotnet_app/app/models/address_model.dart';

class CustomerModel {
  String id;
  String name;
  String cpfCnpj;
  String type;
  String birthDate;
  bool active;
  String createdAt;
  String updatedAt;
  List<AddressModel> addresses;

  CustomerModel({
    this.id = '',
    this.name = '',
    this.cpfCnpj = '',
    this.type = '',
    this.birthDate = '',
    this.active = true,
    this.createdAt = '',
    this.updatedAt = '',
    this.addresses = const [],
  });

  fromJson(Map<String, dynamic> json) {
    this.id = json['id'] ?? '';
    this.name = json['name'] ?? '';
    this.cpfCnpj = json['cpfCnpj'] ?? '';
    this.type = json['type'] ?? '';
    this.birthDate = json['birthDate'] ?? '';
    this.active = json['active'] ?? true;
    this.createdAt = json['createdAt'] ?? '';
    this.updatedAt = json['updatedAt'] ?? '';
    this.addresses = [];

    json['addresses'].forEach((address) {
      AddressModel addressModel = AddressModel();
      addressModel.fromJson(address);
      this.addresses.add(addressModel);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cpfCnpj'] = this.cpfCnpj;
    data['type'] = this.type;
    data['birthDate'] = this.birthDate;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['addresses'] = this.addresses;
    return data;
  }
}
