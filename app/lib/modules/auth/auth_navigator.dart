import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/sign_up_page.dart';
 

class AuthNavigator {
  void pop() {
    return Modular.to.pop();
  }

  void openLogin() {
    return Modular.to.popUntil((route) => route.isFirst);
  }

  // Future openTemporaryPasswordPage() {
  //   // return Modular.to.pushNamed(
  //   //   ConfirmEmailPage.routePath,
  //   // );
  // }

  Future openSignUpPage() {
    return Modular.to.pushNamed(
      SignUpPage.routePath,
    );
  }

  void openSignInPage() {
      Modular.to.pop();
    // return Modular.to.pushNamed(
    //   LoginPage.routePath,
    // );
  }
}
