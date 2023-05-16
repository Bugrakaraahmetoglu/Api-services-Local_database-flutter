class PostModel {
  int? id;
  String? name;
  String? lastName;

  PostModel({this.name, this.lastName,this.id});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json['name'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    return data;
  }
}
