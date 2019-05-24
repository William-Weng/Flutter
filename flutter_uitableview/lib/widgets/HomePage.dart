import 'package:flutter/material.dart';
import 'DetailsPage.dart';
import '../models/Record.dart';
import '../models/RecordList.dart';
import '../models/RecordService.dart';
import '../helpers/Constants.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _filterTextEditingController = TextEditingController();
  Widget _appBarTitle = Text(appTitle);

  RecordList _records = RecordList();
  RecordList _filteredRecords = RecordList();
  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search);

  @override
  void initState() {
    super.initState();
    initSetting();
  }

  @override
  Widget build(BuildContext context) {
    return _appScaffold();
  }

  _HomePageState() {
    _filterTextEditingController.addListener(_filterListener);
  }

  /// 初始化數據
  void initSetting() {
    _records.records = List();
    _filteredRecords.records = List();
    _getRecords();
  }

  /// 整體架構
  Scaffold _appScaffold() {
    Scaffold scaffold = Scaffold(
      appBar: _buildBar(context),
      backgroundColor: appDarkGreyColor,
      body: _buildList(context),
      resizeToAvoidBottomPadding: false,
    );

    return scaffold;
  }

  /// UINavigationBar
  Widget _buildBar(BuildContext context) {
    return new AppBar(
      elevation: 0.1,
      backgroundColor: appDarkGreyColor,
      centerTitle: true,
      title: _appBarTitle,
      leading: IconButton(
        icon: _searchIcon,
        onPressed: () { _searchPressed(); },
      )
    );
  }

  /// UITableView
  Widget _buildList(BuildContext context) {
    _filterRecords();

    ListView listView = ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this._filteredRecords.records.map((data) => _buildListItem(context, data)).toList(),
    );

    return listView;
  }

  /// UITableViewCell
  Widget _buildListItem(BuildContext context, Record record) {
    return Card(
      key: ValueKey(record.name),
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: _listTitle(context, record),
      ),
    );
  }

  /// UITableViewCell的內容
  ListTile _listTitle(BuildContext context, Record record) {
    ListTile listTile = ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(border: Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: Hero(tag: "avatar_" + record.name, child: _getRecordPhoto(record),
        )
      ),
      title: _getRecordText(record),
      subtitle: Row(
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getRecordRichText(record)
              ]
            )
          )
        ],
      ),
      trailing: _getArrowIcon(),
      onTap: () { _gotoDetailPage(context, record); },
    );

    return listTile;
  }

  /// 取得資料
  void _getRecords() async {
    RecordList records = await RecordService().loadRecords();

    setState(() {
      for (Record record in records.records) {
        this._records.records.add(record);
        this._filteredRecords.records.add(record);
      }
    });
  }

  /// 過濾資料 (轉小寫比較)
  void _filterRecords() {
    if (_searchText.isNotEmpty) {
      _filteredRecords.records = List();
      for (int i = 0; i < _records.records.length; i++) {
        if (_records.records[i].name.toLowerCase().contains(_searchText.toLowerCase()) || _records.records[i].address.toLowerCase().contains(_searchText.toLowerCase())) {
          _filteredRecords.records.add(_records.records[i]);
        }
      }
    }
  }

  /// 取得大頭照
  CircleAvatar _getRecordPhoto(Record record) {
    CircleAvatar circleAvatar = CircleAvatar(
      radius: 32,
      backgroundImage: NetworkImage(record.photo),
    );
    return circleAvatar;
  }

  /// 取得內容文字 (介紹)
  RichText _getRecordRichText(Record record) {
    RichText richText = RichText(
      text: TextSpan(
        text: record.address,
        style: TextStyle(color: Colors.white),
      ),
      maxLines: 3,
      softWrap: true,
    );

    return richText;
  }

  /// 取得內容文字 (姓名)
  Text _getRecordText(Record record) {
    Text text = Text(
      record.name, 
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
    
    return text;
  }

  /// 取得箭頭圖示
  Icon _getArrowIcon() {
    Icon icon = Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0);
    return icon;
  }

  /// 過濾的規則
  void _filterListener() {

    setState(() {
      if (_filterTextEditingController.text.isNotEmpty) {
        _searchText = _filterTextEditingController.text;
        return;
      }
      _resetRecords();
    });
  }

  /// 還原資料
  void _resetRecords() {
    
    _searchText = "";
    this._filteredRecords.records = List();

    for (Record record in _records.records) {
      this._filteredRecords.records.add(record);
    }
  }

  /// 搜尋功能
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon != Icons.search) { _closeSerachBar(); return; }
      _openSerachBar();
    });
  }

  /// 把SearchBar打開
  void _openSerachBar() {
    this._searchIcon = Icon(Icons.close);
    this._appBarTitle = TextField(
      controller: _filterTextEditingController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.white),
        fillColor: Colors.white,
        hintText: 'Search by name',
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  /// 把SearchBar關掉
  void _closeSerachBar() {
    this._searchIcon = Icon(Icons.search);
    this._appBarTitle = Text(appTitle);
    _filterTextEditingController.clear();
  }

  /// 跳到下一頁
  void _gotoDetailPage(BuildContext context, Record record) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(record: record)));
  }
}
