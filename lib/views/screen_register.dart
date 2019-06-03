import 'package:flutter/material.dart';
import 'package:mbom/res/strings.dart';

/// TODO: Add Fingerprint's connnection button
///
///
///
///

class RegisterScreen extends StatefulWidget {
  final String title;

  RegisterScreen({Key key, this.title}) : super(key: key);

  @override
  _RegisterScreenState createState() => new _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //
  //
  final GlobalKey<FormState> registerFormKey = new GlobalKey();
  final _usernameController = new TextEditingController();
  final _emailController = new TextEditingController();
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
              Padding(padding: EdgeInsets.only(top: 32.0)),
              // APPLICATION LOGO
              Image.asset(
                'assets/images/logo_annickos.png',
                width: 100.0,
                height: 100.0,
                scale: 1.0,
              ),
              //FlutterLogo(size: Dimens.SIZE_APP_LOGO),
              // APPLICATION NAME
              Text(
                Strings.APP_NAME,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(letterSpacing: 5.0),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: Text(
                  Strings.BRANDING,
                  style: Theme.of(context).textTheme.subhead.copyWith(
                        fontSize: 12.0,
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
                  /*OutlineButton(
                    onPressed: () {},
                    child: Text(Strings.TEXT_CANCEL_BUTTON.toUpperCase()),
                    borderSide: BorderSide(color: Colors.black),
                  ),*/
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(Strings.TEXT_REGISTER_BUTTON.toUpperCase()),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        //borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100.0,
                child: Center(child: _separator(context)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child: _buttonPanel(context),
              ),
              // LOGIN LINK
              Text(
                Strings.TEXT_LOGIN_LINK,
                style: TextStyle(
                  fontSize: 14.0,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                ),
                textAlign: TextAlign.center,
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
      leading: Navigator.canPop(context) ? BackButton() : null,
      title: Text(Strings.TITLE_REGISTER_SCREEN),
      centerTitle: true,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
      ],
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: Form(
        key: registerFormKey,
        child: Column(
          children: <Widget>[
            _textField(
              controller: _usernameController,
              icon: Icons.person_outline,
            ),
            // TODO: Change obscureText property to false
            _textField(
              controller: _emailController,
              icon: Icons.mail_outline,
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
            icon: Icons.account_circle,
            label: '${Strings.TEXT_LOGIN_WITH_ACCOUNT_BUTTON} ',
            accountName: 'Google',
          ),
          _button(
            context,
            icon: Icons.account_circle,
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

  Widget _button(
    BuildContext context, {
    IconData icon,
    String label,
    String accountName,
  }) {
    return FlatButton(
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(300.0),
      ),
      onPressed: () {},
      child: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(width: 18.0),
          Text(label.toUpperCase() + ' ' + accountName.toUpperCase()),
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
        autovalidate: true,
        focusNode: focusNode,
        keyboardType: controller == _emailController
            ? TextInputType.emailAddress
            : TextInputType.text,
        obscureText: controller == _usernameController ? false : true,
        textInputAction: controller == _passwordController
            ? TextInputAction.done
            : TextInputAction.next,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: IconButton(
            onPressed: null,
            icon: Icon(icon),
            disabledColor: Colors.black,
            padding: EdgeInsets.all(16.0),
          ),
          hintText: _getLabel(controller),
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

  String _getLabel(TextEditingController controller) {
    if (controller == _usernameController)
      return Strings.HINT_USERNAME_TEXT_FIELD;
    if (controller == _emailController)
      return Strings.HINT_EMAIL_TEXT_FIELD;
    else
      return Strings.HINT_PASSWORD_TEXT_FIELD;
  }
}
