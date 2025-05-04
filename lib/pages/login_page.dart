import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:hnest/helpers/auto_theme.dart';
import 'package:hnest/helpers/palette_helper.dart';
import 'package:hnest/pages/home_page.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future(() => 'Function not available');
  }

  Future<String> _recoverPassword(String name) {
    return Future(() => 'Function not available');
  }

  @override
  Widget build(BuildContext context) {
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return Container(
      color: PaletteHelper.getColor(AppColorId.primaryColor.value),
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: FlutterLogin(
            title: "The Hunter's Nest",
            logo: const AssetImage('assets/images/community_logo.png'),
            onLogin: _authUser,
            onSignup: _signupUser,
            hideForgotPasswordButton: true,
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomePage(title: AutoTheme.appName),
              ));
            },
            onRecoverPassword: _recoverPassword,
            theme: LoginTheme(
              accentColor: PaletteHelper.getColor(AppColorId.fieldColor.value),
              errorColor: PaletteHelper.getColor(AppColorId.fieldError.value),
              bodyStyle: AutoTheme.getH3Style(StyleDimension.bold),
              cardTheme: CardTheme(
                color: PaletteHelper.getColor(AppColorId.primaryCardColor.value)
              ),
              inputTheme: InputDecorationTheme(
                filled: true,
                fillColor: PaletteHelper.getColor(AppColorId.fieldColor.value),
                contentPadding: EdgeInsets.zero,
                labelStyle: AutoTheme.getH3Style(StyleDimension.bold),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PaletteHelper.getColor(AppColorId.unSelectedField.value), width: 4),
                  borderRadius: inputBorder,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PaletteHelper.getColor(AppColorId.selectedField.value), width: 5),
                  borderRadius: inputBorder,
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PaletteHelper.getColor(AppColorId.fieldError.value), width: 7),
                  borderRadius: inputBorder,
                ),
              ),
              buttonTheme: LoginButtonTheme(
                splashColor: PaletteHelper.getColor(AppColorId.unSelectedField.value),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )),
      ),
    );
  }
}
