import 'package:flutter/material.dart';
import '../models/Record.dart';
import '../helpers/URLLauncher.dart';

class DetailPage extends StatelessWidget {
  final Record record;
  DetailPage({this.record});

  @override
  Widget build(BuildContext context) {
    return _appScaffold();
  }

  /// 整體架構
  Scaffold _appScaffold() {
    Scaffold scaffold = Scaffold(
      appBar: AppBar(title: Text(record.name),),
      body: ListView(children: <Widget>[
        Hero(tag: "avatar_" + record.name, child: _getRecordPhoto(record),),
        GestureDetector(
          onTap: () { _gotoWebPage(record.url); },
          child: Container(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(padding: const EdgeInsets.only(bottom: 8.0), child: _getNameText(record.name),),
                      _getAddressText(record.address),
                    ],
                  ),
                ),
                _getIcon(Icons.phone, Colors.red[500]),
                _getContactText(record.contact),
                ],
              ),
            )
          ),
        ]
      )
    );

    return scaffold;
  }
  /// 取得大頭照
  Image _getRecordPhoto(Record record) {
    return Image.network(record.photo);
  }

  /// 取得姓名的TextView
  Text _getNameText(String name) {
    Text text = Text(
      "Name: " + name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );

    return text;
  }

  /// 取得地址的TextView
  Text _getAddressText(String address) {
    Text text = Text(
      "Address: " + address,
      style: TextStyle(
      color: Colors.grey[500],
      ),
    );

    return text;
  }

  /// 取得電話號碼的TextView
  Text _getContactText(String contact) {
    Text text = Text(' $contact');
    return text;
  }

  /// 取得ImageView
  Icon _getIcon(IconData data, Color color) {
    Icon icon = Icon(
      data,
      color: color,
    );
    return icon;
  }
 
  /// 打開網頁
  void _gotoWebPage(String url) {
    URLLauncher().launchURL(record.url);
  }
}
