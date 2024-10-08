import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projet_2cp/Widgets/Afrique/AnimalSauve.dart';
import 'package:projet_2cp/Widgets/Afrique/AfriqueSquareAnimal.dart';
import 'package:projet_2cp/Widgets/Afrique/AfriqueAnimalOption.dart';
import 'package:projet_2cp/Widgets/Afrique/ListeAfrica.dart';
import 'package:projet_2cp/backend/progress_controllers.dart';
import 'package:projet_2cp/progress/progress.dart';
import 'package:projet_2cp/constants.dart';
import 'package:projet_2cp/settings.dart';
import '../help.dart';

class AfriqueMiniJeu extends StatefulWidget {
  AfriqueMiniJeu({super.key});

  final List<ListItem> myList = [
    ListItem(
      name: 'Cheval',
      isCorrect: false,
      image: 'assets/images/afrique/cheval.png',
      isPressed: false,
      width: 85,
    ),
    ListItem(
      name: 'Rhinocéros',
      isCorrect: true,
      image: 'assets/images/afrique/rhinocéros.png',
      isPressed: false,
      width: 91,
    ),
    ListItem(
      name: 'Paresseux',
      isCorrect: false,
      image: 'assets/images/afrique/Paresseux.png',
      isPressed: false,
      width: 85,
    ),
    ListItem(
      name: 'Ours polaire',
      isCorrect: true,
      image: 'assets/images/afrique/polar_bear.png',
      isPressed: false,
      width: 86,
    ),
    ListItem(
      name: 'Chien',
      isCorrect: false,
      image: 'assets/images/afrique/dog.png',
      isPressed: false,
      width: 46,
    ),
    ListItem(
      name: 'cow',
      isCorrect: false,
      image: 'assets/images/afrique/cow.png',
      isPressed: false,
      width: 85,
    ),
    ListItem(
      name: 'Grenouille',
      isCorrect: false,
      image: 'assets/images/afrique/grenouille.png',
      isPressed: false,
      width: 72,
    ),
    ListItem(
      name: 'Panda',
      isCorrect: true,
      image: 'assets/images/afrique/panda.png',
      isPressed: false,
      width: 83,
    ),
    ListItem(
      name: 'oiseau',
      isCorrect: false,
      image: 'assets/images/afrique/oiseau.png',
      isPressed: false,
      width: 81,
    ),
    ListItem(
      name: 'Tigre',
      isCorrect: true,
      image: 'assets/images/afrique/tiger.png',
      isPressed: false,
      width: 92,
    ),
    ListItem(
      name: 'gazelle',
      isCorrect: false,
      image: 'assets/images/afrique/gazelle.png',
      isPressed: false,
      width: 55,
    ),
    ListItem(
      name: 'vache',
      isCorrect: false,
      image: 'assets/images/afrique/vache.png',
      isPressed: false,
      width: 96,
    ),
    ListItem(
      name: 'Crocodille',
      isCorrect: true,
      image: 'assets/images/afrique/crocodille.png',
      isPressed: false,
      width: 96,
    ),
    ListItem(
      name: 'chameau',
      isCorrect: false,
      image: 'assets/images/afrique/chameau.png',
      isPressed: false,
      width: 96,
    ),
    ListItem(
      name: 'Puma',
      isCorrect: false,
      image: 'assets/images/afrique/puma.png',
      isPressed: false,
      width: 96,
    ),
    ListItem(
      name: 'inconnu',
      isCorrect: false,
      image: 'assets/images/afrique/inconnu.png',
      isPressed: false,
      width: 96,
    ),
    ListItem(
      name: 'Koala',
      isCorrect: true,
      image: 'assets/images/afrique/koala.png',
      isPressed: false,
      width: 82,
    ),
    ListItem(
      name: 'Putois',
      isCorrect: false,
      image: 'assets/images/afrique/putois.png',
      isPressed: false,
      width: 96,
    ),
  ];

  @override
  State<AfriqueMiniJeu> createState() => _AfriqueMiniJeu();
}

class _AfriqueMiniJeu extends State<AfriqueMiniJeu> {
  final StationProgress stationProgress = userProgress.stations[2];
  final GameProgress gameProgress = userProgress.stations[2].games[1];

  bool answer = false;
  String text = 'je suis en voie de disparition';
  double y = 1;
  int cpt = 0;
  bool isVisible = false;
  int index = 0;
  bool pressed = false;
  int animal = 0;
  Color couleur = const Color.fromARGB(255, 255, 243, 210);
  int click = 0;

  void setpressed(bool value) {
    setState(() {
      pressed = value;
    });
  }

  void mettreAJourEtat(bool isPressed, bool isCorrect, String name) {
    setState(() {
      if (isPressed && isCorrect) {
        answer = true;
        text = name;
        couleur = const Color(0xffD2FFDF);
        cpt++;
        if (cpt == 1) {
          y = 0;
          isVisible = true;
        }
        if (cpt == 2) {
          y = -1;
        }
      }
    });
  }

  String choixImage() {
    String s = '';
    for (int i = index; i < index + 3; i++) {
      if (widget.myList[i].isCorrect) {
        s = widget.myList[i].image;
      }
    }
    return s;
  }

  String choixTexte() {
    String s = '';
    for (int i = index; i < index + 3; i++) {
      if (widget.myList[i].isCorrect) {
        s = widget.myList[i].name;
      }
    }
    return s;
  }

  void next() {
    setState(() {
      answer = false;
      text = 'je suis en voie de disparition';
      y = 1;
      cpt = 0;
      isVisible = false;
      index = index + 3;
      pressed = false;
      animal++;
      couleur = const Color.fromARGB(255, 255, 243, 210);
    });
  }

  void clickCpt() {
    click++;
  }

  Widget _buildWidget() {
    if (y == -1) {
      return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        initialData: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/afrique/Background_Africa_1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Stack(
              children: [
                Positioned(
                  bottom: MediaQuery.of(context).size.height * (36 / 360),
                  right: MediaQuery.of(context).size.width * (65 / 800),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset(
                        listAnimaux[animal],
                      ),
                      Container(
                        alignment: Alignment(1, y),
                        //color: Colors.black,
                        height: MediaQuery.of(context).size.height,
                        width: 300,
                        child: Image.asset(
                          'assets/images/afrique/cage.png',
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * (67 / 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (38 / 360),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * (32 / 360),
                        width: MediaQuery.of(context).size.width * (210 / 800),
                        decoration: BoxDecoration(
                            color: couleur,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * (6 / 800)),
                            border: Border.all(
                              color: const Color(0xff727271),
                              width: 1,
                            )),
                        child: Center(
                          child: Text(
                            text,
                            style: TextStyle(
                              fontFamily: 'Atma',
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.width *
                                  (14 / 800),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              MediaQuery.of(context).size.height * (6 / 360)),
                      AfricaSquareAnimal(
                        isImage: answer,
                        image: choixImage(),
                      ),
                      SizedBox(
                          height:
                              MediaQuery.of(context).size.height * (15 / 360)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AfricaAnimal(
                            isCorrect: widget.myList[index].isCorrect,
                            name: widget.myList[index].name,
                            image: widget.myList[index].image,
                            callback: mettreAJourEtat,
                            pressed: pressed,
                            callback1: setpressed,
                            width: widget.myList[index].width,
                            click: clickCpt,
                            // answer: answerP,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  (23 / 800)),
                          AfricaAnimal(
                            isCorrect: widget.myList[index + 1].isCorrect,
                            name: widget.myList[index + 1].name,
                            image: widget.myList[index + 1].image,
                            callback: mettreAJourEtat,
                            pressed: pressed,
                            callback1: setpressed,
                            width: widget.myList[index + 1].width,
                            click: clickCpt,
                            // answer: answerP,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  (23 / 800)),
                          AfricaAnimal(
                            isCorrect: widget.myList[index + 2].isCorrect,
                            name: widget.myList[index + 2].name,
                            image: widget.myList[index + 2].image,
                            callback: mettreAJourEtat,
                            pressed: pressed,
                            callback1: setpressed,
                            width: widget.myList[index + 2].width,
                            click: clickCpt,
                            // answer: answerP,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * (27 / 360),
                  right: MediaQuery.of(context).size.width * (27 / 800),
                  child: Visibility(
                    visible: isVisible,
                    child: Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  (62 / 800),
                              height: MediaQuery.of(context).size.width *
                                  (62 / 800),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFE84560),
                                border: Border.all(
                                  color: const Color(0xff752683),
                                  width: 2,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  index = index + 3;
                                  isVisible = false;
                                  text = 'je suis en voie de disparition';
                                  answer = false;
                                  pressed = true;
                                });
                              },
                              icon: const Icon(Icons.arrow_forward),
                              iconSize: MediaQuery.of(context).size.width *
                                  (40 / 800),
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * (30 / 360),
              left: MediaQuery.of(context).size.width * (29 / 800),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * (39 / 800),
                        height: MediaQuery.of(context).size.width * (39 / 800),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE84560),
                          border: Border.all(
                            color: const Color(0xff752683),
                            width: 2,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if(kSound){
                            setState(() {
                              kSound = false;
                              backgroundPlayerAfrique.stopMusic();
                            });
                          }else{
                            setState(() {
                              kSound = true;
                              backgroundPlayerAfrique.playMusic();
                            });
                          }
                        },
                        icon: Icon(iconeTypeFunction()),
                        iconSize:
                            MediaQuery.of(context).size.width * (25 / 800),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (5 / 360),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * (40 / 800),
                        height: MediaQuery.of(context).size.width * (40 / 800),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE84560),
                          border: Border.all(
                            color: const Color(0xff752683),
                            width: 2,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          backgroundPlayerAfrique.stopMusic();
                          backgroundPlayerMap.playMusic();
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close_rounded),
                        iconSize:
                            MediaQuery.of(context).size.width * (30 / 800),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * (32 / 800),
              top: MediaQuery.of(context).size.height * (30 / 360),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    //margin: EdgeInsets.only(bottom: 12.0),
                    width: MediaQuery.of(context).size.width * (40 / 800),
                    height: MediaQuery.of(context).size.width * (40 / 800),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE84560),
                      border: Border.all(
                        color: const Color(0xff752683),
                        width: 2,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => helpPage(
                                    numStation: 2,
                                    background:
                                        'assets/images/afrique/Background_Africa_1.png',
                                  )));
                    },
                    icon: const Icon(Icons.question_mark),
                    iconSize: MediaQuery.of(context).size.width * 0.035,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ],
              ),
            ),
          ],
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AnimalSauve(
              stationProgress,
              gameProgress,
              animal: listAnimaux[animal],
              next: next,
              score: click,
            );
          } else {
            return snapshot.data;
          }
        },
      );
    } else {
      return Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('assets/images/afrique/Background_Africa_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Stack(
            children: [
              Positioned(
                bottom: MediaQuery.of(context).size.height * (36 / 360),
                right: MediaQuery.of(context).size.width * (65 / 800),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      listAnimaux[animal],
                    ),
                    Container(
                      alignment: Alignment(1, y),
                      //color: Colors.black,
                      height: MediaQuery.of(context).size.height,
                      width: 300,
                      child: Image.asset(
                        'assets/images/afrique/cage.png',
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * (67 / 800),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (38 / 360),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * (32 / 360),
                      width: MediaQuery.of(context).size.width * (210 / 800),
                      decoration: BoxDecoration(
                          color: couleur,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * (6 / 800)),
                          border: Border.all(
                            color: const Color(0xff727271),
                            width: 1,
                          )),
                      child: Center(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontFamily: 'Atma',
                            height: 30 / 14,
                            fontWeight: FontWeight.w500,
                            fontSize:
                                MediaQuery.of(context).size.width * (14 / 800),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * (6 / 360)),
                    AfricaSquareAnimal(
                      isImage: answer,
                      image: choixImage(),
                    ),
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (15 / 360)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AfricaAnimal(
                          isCorrect: widget.myList[index].isCorrect,
                          name: widget.myList[index].name,
                          image: widget.myList[index].image,
                          callback: mettreAJourEtat,
                          pressed: pressed,
                          callback1: setpressed,
                          width: widget.myList[index].width,
                          click: clickCpt,
                          // answer: answerP,
                        ),
                        SizedBox(
                            width:
                                MediaQuery.of(context).size.width * (23 / 800)),
                        AfricaAnimal(
                          isCorrect: widget.myList[index + 1].isCorrect,
                          name: widget.myList[index + 1].name,
                          image: widget.myList[index + 1].image,
                          callback: mettreAJourEtat,
                          pressed: pressed,
                          callback1: setpressed,
                          width: widget.myList[index + 1].width,
                          click: clickCpt,
                          // answer: answerP,
                        ),
                        SizedBox(
                            width:
                                MediaQuery.of(context).size.width * (23 / 800)),
                        AfricaAnimal(
                          isCorrect: widget.myList[index + 2].isCorrect,
                          name: widget.myList[index + 2].name,
                          image: widget.myList[index + 2].image,
                          callback: mettreAJourEtat,
                          pressed: pressed,
                          callback1: setpressed,
                          width: widget.myList[index + 2].width,
                          click: clickCpt,
                          // answer: answerP,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * (27 / 360),
                right: MediaQuery.of(context).size.width * (27 / 800),
                child: Visibility(
                  visible: isVisible,
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.width * (62 / 800),
                            height:
                                MediaQuery.of(context).size.width * (62 / 800),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFE84560),
                              border: Border.all(
                                color: const Color(0xff752683),
                                width: 2,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                index = index + 3;
                                isVisible = false;
                                text = 'je suis en voie de disparition';
                                couleur =
                                    const Color.fromARGB(255, 255, 243, 210);
                                answer = false;
                                pressed = true;
                              });
                            },
                            icon: const Icon(Icons.arrow_forward),
                            iconSize:
                                MediaQuery.of(context).size.width * (40 / 800),
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * (30 / 360),
            left: MediaQuery.of(context).size.width * (29 / 800),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * (39 / 800),
                      height: MediaQuery.of(context).size.width * (39 / 800),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE84560),
                        border: Border.all(
                          color: const Color(0xff752683),
                          width: 2,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if(kSound){
                          setState(() {
                            kSound = false;
                            backgroundPlayerAfrique.stopMusic();
                          });
                        }else{
                          setState(() {
                            kSound = true;
                            backgroundPlayerAfrique.playMusic();
                          });
                        }
                      },
                      icon: Icon(iconeTypeFunction()),
                      iconSize: MediaQuery.of(context).size.width * (25 / 800),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (5 / 360),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * (40 / 800),
                      height: MediaQuery.of(context).size.width * (40 / 800),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE84560),
                        border: Border.all(
                          color: const Color(0xff752683),
                          width: 2,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        backgroundPlayerAfrique.stopMusic();
                        backgroundPlayerMap.playMusic();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_rounded),
                      iconSize: MediaQuery.of(context).size.width * (30 / 800),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * (32 / 800),
            top: MediaQuery.of(context).size.height * (30 / 360),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  //margin: EdgeInsets.only(bottom: 12.0),
                  width: MediaQuery.of(context).size.width * (40 / 800),
                  height: MediaQuery.of(context).size.width * (40 / 800),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE84560),
                    border: Border.all(
                      color: const Color(0xff752683),
                      width: 2,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => helpPage(
                                  numStation: 2,
                                  background:
                                      'assets/images/afrique/Background_Africa_1.png',
                                )));
                  },
                  icon: const Icon(Icons.question_mark),
                  iconSize: MediaQuery.of(context).size.width * 0.035,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    backgroundPlayerAfrique.playMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildWidget());
  }
}
