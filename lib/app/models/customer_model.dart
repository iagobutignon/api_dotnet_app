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
    required this.id,
    required this.name,
    required this.cpfCnpj,
    required this.type,
    required this.birthDate,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.addresses = const [],
  });
}
