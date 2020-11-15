import 'package:floor/floor.dart';

@entity
class Guest {
  @PrimaryKey(autoGenerate: true)
  int id;
  String name;
  String status;
  String email;
  String cellPhone;

  /* Constructor */
  Guest({this.id, this.name, this.status, this.email, this.cellPhone});

  /// @brief Converts a Json into a Guest Object
  Guest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    status = json['status'];
    email = json['email'];
    cellPhone = json['cellPhone'];
  }

  /// @brief Converts a Guest Object into a Json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['email'] = this.email;
    data['cellPhone'] = this.cellPhone;
    return data;
  }
}
