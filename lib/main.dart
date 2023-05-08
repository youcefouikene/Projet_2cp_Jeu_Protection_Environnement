import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_2cp/Screens/LoadingPage.dart';
import 'dart:io';
import 'dart:ui' as ui;
//                    ----------------------
//                    ----------------------
import '../Screens/AcquisitionPage.dart';
import '../Screens/Classement.dart';
import '../Screens/DefiPage.dart';
import '../Screens/Defis/DefiClean/ScereenClean.dart';
import '../Screens/Defis/DefieProtectionEscargot/ScreenShoe.dart';
import '../Screens/MiniJeux/AmeriqueNordMiniJeu/dataAmerique.dart';
import '../Screens/MiniJeux/AsieMiniJeu/data.dart';
import '../Screens/MiniJeux/AsieMiniJeu/flipcardgame1.dart';
import '../Widgets/Afrique/AnimalSauve.dart';
import '../Screens/ChooseGamePage.dart';
import '../Screens/MiniJeux/OceanieMiniJeu.dart';
import '../Widgets/Iconbutton.dart';
import '../Widgets/ScoreBAR.dart';
import '../Widgets/WiningBox.dart';
import '../try.dart';
import 'Screens/Defis/DefiArrosageScreen/screenArrosage.dart';
import 'Screens/Defis/DefiVelo/ScreenVelo.dart';
import 'Screens/Defis/defiEau/screenEau.dart';
import 'Screens/Defis/defiEnergie/screenSwitch.dart';
import 'Screens/MiniJeux/AmeriqueNordMiniJeu/flipcardgame2.dart';
import 'Screens/Profil/AjouterProfilPage.dart';
import 'Screens/Profil/ChoisirProfilPage.dart';
import 'Screens/Profil/ChoseAvatar.dart';
import 'Screens/Profil/Profil.dart';
import 'Screens/WelcomePage.dart';
import 'Screens/help.dart';
import 'Screens/helpPageEu.dart';
import 'Screens/quiz/quiz.dart';
import 'Widgets/StationBar.dart';
import 'Screens/WelcomeStationPage.dart';
import 'Widgets/ChooseBoxgame2.dart';
import 'Widgets/WelcomeTextBox.dart';
import 'Screens/EndGamePage.dart';
import 'Widgets/Afrique/AfriqueSquareAnimal.dart';
import 'Widgets/Afrique/AfriqueAnimalOption.dart';
import 'Widgets/Afrique/ListeAfrica.dart';
import 'Screens/MiniJeux/AfriqueMiniJeu.dart';
import 'Screens/MiniJeux/throw_garbage.dart';
import 'Screens/MiniJeux/AmeriqueDuSudMiniJeu.dart';
import 'Widgets/Oceanie/Timer.dart';
import 'settings.dart';
//                    ----------------------
//                    ----------------------
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//                    ----------------------
//                    ----------------------
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
//                    ----------------------
//                    ----------------------
import 'progress/progress.dart';
import 'backend/local_progress/local_progress.dart';
import 'backend/progress_controllers.dart';
import 'backend/synchronization.dart';
import 'backend/database.dart';
//                    ----------------------
//                    ----------------------
late UserProgress user;
late bool isConnected;
//                    ----------------------
//                    ----------------------

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  if (Platform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isConnected = await InternetConnectionChecker().hasConnection;
  kUser = await prefs.getString('kUser') ?? 'guest';
  kLang = await prefs.getString('kLang') ?? 'fr';
  kLogin = await prefs.getBool('kLogin') ?? false;
  kSound = await prefs.getBool('kSound') ?? true;


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  //! Online vs Local
  // ignore: unused_local_variable
  Future<UserProgress> online;
  Future<UserProgress> local;

  if (kLogin) {
    /*
    //! Modification
    if (isConnected) {
      // online = LocalProgress.getChildren(kUser);
      //! Get only children
      Future<List<UserProgress>> c = OnlineProgress.getChildren(kUser);
      children = await c;
      //! if length != 0
      if (children.length != 0) {
        Future<String> d = OnlineProgress.getParentOnlineDate(kUser);
        kOnlineDate = await d;
        if (kOnlineDate.compareTo(kLocalDate) == 1) {
          //! Get All Children
          Future<UserProgress> ch = getFireBase(kUser);
          children = await ch;
          for (UserProgress childProgress in children) {
            LocalProgress.addChild(kUser, childProgress);
          }
        } else if (kOnlineDate.compareTo(kLocalDate) == -1) {
          //! Get All Children
          Future<UserProgress> ch = getSQFLite(kUser);
          children = await ch;
          for (UserProgress childProgress in children) {
            OnlineProgress.updateChild(childProgress);
          }
        } else {
          Future<List<ChildProgress>> ch = getSQFLite(kUser);
          children = await ch;
        }
        String date = DateTime.now().toString();
        prefs.setString('kLocalDate', date);
        OnlineProgress.updateParent(kUser, date);
      }
     */
    } else {
      local = getSQFLite(kUser);
      user = await local;
    }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoadingPage(),
      ),
      routes: <String, WidgetBuilder>{
        '/WelcomeStation': (BuildContext context) => WelcomePage(),
        '/AfriqueMiniJeu': (BuildContext context) => AfriqueMiniJeu(),
        '/OceanieMiniJeu': (BuildContext context) =>   Oceanie_miniJeu(),
        '/AmeriqueSudMiniJeu': (BuildContext context) =>  Samerique_miniJeu(),
        '/EuropeMiniJeu': (BuildContext context) => ThrowGarbage(),
        '/AmeriqueNordMiniJeu': (BuildContext context) =>  const FlipCardGame(Level.Medium),
        '/AsieMiniJeu': (BuildContext context) =>  const FlipCardGame1(Level1.Medium),
        '/QuizOceanie': (BuildContext context) => BigQuiz(continentNumber: 0),
        '/QuizAsie': (BuildContext context) => BigQuiz(continentNumber: 1),
        '/QuizAfrique': (BuildContext context) => BigQuiz(continentNumber: 2),
        '/QuizEurope': (BuildContext context) => BigQuiz(continentNumber: 3),
        '/QuizAmeriqueNord': (BuildContext context) => BigQuiz(continentNumber: 4),
        '/QuizAmeriqueSud': (BuildContext context) => BigQuiz(continentNumber: 5),
      },
    );
  }
}
