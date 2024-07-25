# Modular + Clean - test 01

<br />
This project was developed to enhance skills and evaluate the microservices architecture using NestJs. The goal was to prepare the back-end to integrate seamlessly with a web interface and a Flutter application.

---
<br /><br />

## ✔️ Topics Covered in Front-End 
 - Built with Flutter/Dart.
 - Clean architecture.
 - Modularization and dependency injection using Flutter Modular 6.
 - State management using the BLoC pattern.
 - User session management using JWT tokens.
 - File upload.
 - Form validation using the Validatorless package.
 - Interceptors for maintaining user sessions using Dio.
 - Nested navigation using the Modular RouterOutlet.
 - Responsiveness using Flutter's MediaQuery.
---
<br /><br />


### 🔥 Firebase CLI 
Some commands and usefull links
- [Documentacao](https://firebase.flutter.dev/docs/cli)
- [parte flutter](https://firebase.google.com/docs/flutter/setup?platform=android)
```console

  // to install flutterfire
  dart pub global activate flutterfire_cli
  
  firebase login

  // listing projects
  firebase projects:list

  // setup the project
  flutterfire configure
```
---
<br /><br /><br />

 

## 🔒🔥 Environment Variables
Using external packages like dotEnv leaves the variables exposed. This [article](https://blog.flutterando.com.br/uma-forma-eficaz-de-gerenciar-suas-vari%C3%A1veis-de-ambiente-env-66e3258e78fd) explains the native way of dealing with this from flutter 3.1 onwards. 


Example of .env-dev (to be placed in the root folder of the project)
```JSON 
  {
      "SUFIX": "dev",
      "API_KEY": "XXXYYYZZZ",
      "BASE_URL": "http://localhost"
  }
```

To retrieve the contents of the variable, simply:
```Dart 
  var sufix = String.fromEnvironment('SUFIX');
```

In order for the flutter commands to understand the config:
```console 
  flutter run — dart-define-from-file=.env-dev
```

Or prepare the launch.json file with the necessary parameters:
```JSON
    "configurations": [
        {
            "name": "meu_app_name (debug)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "toolArgs": [
                "--dart-define-from-file",
                ".env-dev"
            ]
        },
        {
            "name": "meu_app_name (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release"
        }
    ]
```

<br /><br /><br />

 


### 🌘 App Lifecircle
No projeto tera um socket para apontar quando o usuario nao esta realmente com o app aberto. Ai eh util entender o ciclo de vida do app: 
 - resumed: The app is in the foreground and is receiving user input.
 - inactive: The app is in the foreground but is not receiving user input. This state can occur, for example, when a phone call comes in or when the user switches to another app.
 - paused: The app is in the background and is not visible to the user. This state occurs when the user presses the home button or switches to another app.
 - detached: The app is not running at all. This state can occur, for example, when the app is terminated by the operating system or when the device is restarted.
Esse [artigo](https://medium.com/gytworkz/deep-dive-into-flutter-app-lifecycle-342b797480aa) cobre bem o tema. 

```Dart
 
```
---
<br /><br /><br />


#
<footer>
  <p style="float:right; width: 30%;"> Copyright © Moacir Jacomin 
</p>
