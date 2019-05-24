import 'package:flutter/material.dart';
import '../helpers/Constants.dart';

class LoginPage extends StatelessWidget {
  final _pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return appScaffold(context);
  }

  /// 整體架構
  Scaffold appScaffold(BuildContext context) {
    final logo = _appLogoMaker();
    final pinCode = _appPinCodeMaker();
    final loginButton = _appLoginButtonMaker(context);

    Scaffold scaffold = Scaffold(
      backgroundColor: appDarkGreyColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: bigRadius,),
            pinCode,
            SizedBox(height: buttonHeight,),
            loginButton
          ],
        ),
      ),
    );

    return scaffold;
  }

  /// 產生logo圖示
  CircleAvatar _appLogoMaker() {
    var circleAvatar = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );
    return circleAvatar;
  }

  /// 產生輸入框
  TextFormField _appPinCodeMaker() {
    var textFormField = TextFormField(
      controller: _pinCodeController,
      keyboardType: TextInputType.phone,
      maxLength: 4,
      minLines: 1,
      autofocus: true,
      decoration: InputDecoration(
        hintText: pinCodeHintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),),
        hintStyle: TextStyle(color: Colors.white,)
      ),
      style: TextStyle(color: Colors.white),
    );

    return textFormField;
  }

  /// 產生login按鈕
  Padding _appLoginButtonMaker(BuildContext context) {
    var loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: _raisedButtonMaker(context),
    );

    return loginButton;
  }

  /// 產生按鈕
  RaisedButton _raisedButtonMaker(BuildContext context) {
    var raisedButton = RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      padding: EdgeInsets.all(12),
      color: appDarkGreyColor,
      onPressed: () { Navigator.of(context).pushNamed(homePageTag); },
      child: _buttonTextMaker(),
    );

    return raisedButton;
  }

  /// 產生Button文字
  Text _buttonTextMaker() {
    var text = Text(
      loginButtonText,
      style: TextStyle(color: Colors.white),
    );
    return text;
  }
}
