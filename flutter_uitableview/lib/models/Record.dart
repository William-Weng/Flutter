class Record {
  String name;
  String address;
  String contact;
  String photo;
  String url;

  Record({this.name, this.address, this.contact, this.photo, this.url});

  factory Record.fromJson(Map<String, dynamic> json) {
    var record = Record(
        name: json['name'],
        address: json['address'],
        contact: json['contact'],
        photo: json['photo'],
        url: json['url']);
    return record;
  }
}
