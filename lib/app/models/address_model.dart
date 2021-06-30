class AddressModel {
  String cep;
  String address;
  String number;
  String district;
  String city;
  String state;
  String complement;

  AddressModel({
    required this.address,
    required this.number,
    required this.district,
    required this.city,
    required this.state,
    required this.cep,
    this.complement = '',
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['number'] = this.number;
    data['district'] = this.district;
    data['city'] = this.city;
    data['state'] = this.state;
    data['cep'] = this.cep;
    this.complement = '';
    return data;
  }
}
