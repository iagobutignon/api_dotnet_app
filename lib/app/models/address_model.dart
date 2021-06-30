class AddressModel {
  String id;
  String customerId;
  String cep;
  String address;
  String number;
  String district;
  String city;
  String state;
  String complement;

  AddressModel({
    this.id = '',
    this.customerId = '',
    this.address = '',
    this.number = '',
    this.district = '',
    this.city = '',
    this.state = '',
    this.cep = '',
    this.complement = '',
  });

  fromJson(Map<String, dynamic> json) {
    this.id = json['id'] ?? '';
    this.customerId = json['customerId'] ?? '';
    this.address = json['address'] ?? '';
    this.number = json['number'] ?? '';
    this.district = json['district'] ?? '';
    this.city = json['city'] ?? '';
    this.state = json['state'] ?? '';
    this.cep = json['cep'] ?? '';
    this.complement = json['complement'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.id;
    data['address'] = this.address;
    data['number'] = this.number;
    data['district'] = this.district;
    data['city'] = this.city;
    data['state'] = this.state;
    data['cep'] = this.cep;
    data['complement'] = this.complement;
    return data;
  }
}
