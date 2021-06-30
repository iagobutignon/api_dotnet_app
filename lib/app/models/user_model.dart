class UserModel {
  String id;
  String userName;
  String password;
  String createdAt;
  String updatedAt;

  UserModel({
    this.id = '',
    this.userName = '',
    this.password = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.userName = json['userName'];
    this.password = json['password'];
    this.createdAt = json['createdAt'];
    this.updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
