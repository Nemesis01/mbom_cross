import 'package:flutter/material.dart';
import 'package:mbom/res/strings.dart';

class LoginScreen extends StatefulWidget {
  final String title;

  LoginScreen({Key key, this.title}) : super(key: key);

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  //
  final GlobalKey<FormState> formKey = new GlobalKey();
  final _usernameController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _usernameFocusNode = new FocusNode();
  final _passwordFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 24.0)),
              Image.asset(
                'assets/images/logo_annickos.png',
                width: 80.0,
                height: 80.0,
                scale: 1.0,
              ),
              //FlutterLogo(size: Dimens.SIZE_APP_LOGO), // APPLICATION LOGO
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  Strings.APP_NAME,
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(letterSpacing: 5.0),
                  textAlign: TextAlign.center,
                ),
              ), // APPLICATION NAME
              Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: Text(
                  Strings.BRANDING,
                  style: Theme.of(context).textTheme.subhead.copyWith(
                        fontSize: 14.0,
                        letterSpacing: 4.0,
                        color: Colors.blue,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              // LOGIN FORM
              _buildForm(),
              // BUTTONS
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: FlatButton(
                        onPressed: _performLogin,
                        child: Text(Strings.TEXT_LOGIN_BUTTON.toUpperCase()),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 100.0,
                child: Center(child: _separator(context)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child: _buttonPanel(context),
              ),
              // LOGIN LINK
              InkWell(
                child: Text(
                  Strings.TEXT_REGISTER_LINK,
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                  textAlign: TextAlign.center,
                ),
                splashColor: Theme.of(context).accentColor,
                onTap: () => Navigator.pushNamed(context, '/register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      //leading: Navigator.of(context).canPop() ? BackButton() : null,
      automaticallyImplyLeading: false,
      title: Text(Strings.TITLE_LOGIN_SCREEN),
      centerTitle: true,
      actions: <Widget>[
        //IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
      ],
    );
  }

  Widget _buildForm() {
    return Padding(
      padding:
          EdgeInsets.only(left: 32.0, top: 32.0, right: 32.0, bottom: 16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _textField(
              controller: _usernameController,
              icon: Icons.person_outline,
            ),
            _textField(
              controller: _passwordController,
              icon: Icons.lock_outline,
            ),
          ],
        ),
        autovalidate: true,
      ),
    );
  }

  Widget _separator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Center(child: Divider(color: Colors.black54))),
          Expanded(child: Text('OR', textAlign: TextAlign.center)),
          Expanded(child: Center(child: Divider(color: Colors.black54))),
        ],
      ),
    );
  }

  Widget _buttonPanel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _button(
            context,
            iconUrl: 'assets/images/google-plus.png',
            label: '${Strings.TEXT_LOGIN_WITH_ACCOUNT_BUTTON} ',
            accountName: 'Google',
          ),
          _button(
            context,
            iconUrl: 'assets/images/facebook2.png',
            label: '${Strings.TEXT_LOGIN_WITH_ACCOUNT_BUTTON} ',
            accountName: 'Facebook',
          ),
          /* _button(
            context,
            icon: Icons.account_circle,
            label: '${Strings.TEXT_LOGIN_WITH_ACCOUNT_BUTTON} ',
            accountName: 'Instagram',
          ),*/
        ],
      ),
    );
  }

  Widget _textField(
      {TextEditingController controller,
      String label,
      String hint,
      IconData icon,
      FocusNode focusNode}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.text,
        keyboardAppearance: Brightness.dark,
        obscureText: controller == _usernameController ? false : true,
        textInputAction: controller == _usernameController
            ? TextInputAction.next
            : TextInputAction.done,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: IconButton(
            onPressed: null,
            icon: Icon(icon),
            disabledColor: Colors.black,
            padding: EdgeInsets.all(16.0),
          ),
          hintText: controller == _usernameController
              ? Strings.HINT_USERNAME_TEXT_FIELD
              : Strings.HINT_PASSWORD_TEXT_FIELD,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            //borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.black),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _button(
    BuildContext context, {
    String iconUrl,
    String label,
    String accountName,
  }) {
    return FlatButton(
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(100.0),
      ),
      onPressed: () {},
      child: Row(
        children: <Widget>[
          SizedBox(
            child: Image.asset(
              iconUrl,
              scale: 0.5,
              width: 24.0,
              height: 24.0,
              //color: Colors.indigo,
            ),
          ),
          SizedBox(width: 18.0),
          Text(label.toUpperCase() + ' ' + accountName.toUpperCase()),
        ],
      ),
    );
  }

  //****************************************************************************
  //
  //
  //
  //****************************************************************************

  void _performLogin({String username, String password}) {
    // TODO: implement effective login (Firestore or database)
    // Launches HomeScreen after
    Navigator.popAndPushNamed(context, '/home');
  }
}
