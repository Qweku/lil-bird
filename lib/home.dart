import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lil_bird/barrier.dart';
import 'package:flutter/material.dart';

import 'bird.dart';

const int maxFailedLoadAttempts = 3;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  final jumpAudio = AssetsAudioPlayer();
  InterstitialAd? interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  BannerAd? bottomAd;
  bool isLoaded = false;
  static double vAxis = 0;
  double height = 0;
  double time = 0;
  double initHeight = vAxis;
  double birdHeight = 0.15;
  double birdWidth = 0.12;
  double speed = 0.007;
  int score = 0;
  int highScore = 0;
  bool isStarted = false;

  static List<double> barX = [2, 2 + 1.5];
  static double barWidth = 0.5;
  List<List<double>> barY = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  void bounce() {
    jumpAudio.open(Audio('assets/audios/jump.mp3'));
    setState(() {
      time = 0;
      initHeight = vAxis;
    });
  }

  void reset() {
    Navigator.pop(context);
    setState(() {
      vAxis = 0;
      isStarted = false;
      time = 0;
      initHeight = vAxis;
      barX = [2, 2 + 1.5];
      barY = [
        [0.6, 0.4],
        [0.4, 0.6]
      ];
      score = 0;
    });
  }

  void gameStart() {
    assetsAudioPlayer.open(Audio('assets/audios/game-music.mp3'),
        loopMode: LoopMode.playlist);
    isStarted = true;
    initHeight = vAxis;
    startScore();
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      time += 0.01;
      height = -4.9 * time * time + 3.0 * time;
      setState(() {
        vAxis = initHeight - height;
        print(vAxis);
      });

      moveMap();
      if (isDead()) {
        assetsAudioPlayer.open(Audio('assets/audios/game-over.mp3'));
        timer.cancel();
        isStarted = false;
        _showDialog();
      }
    });
  }

  void moveMap() {
    for (int i = 0; i < barX.length; i++) {
      setState(() {
        barX[i] -= speed;
      });
      if (barX[i] < -1.5) {
        barX[i] += 3;
      }
    }
  }

  void startScore() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      score += 1;
      if (score < 10) {
        speed = 0.007;
      } else if (10 % score == 0) {
        setState(() {
          speed += 0.002;
        });
      }

      if (isDead()) {
        timer.cancel();
      }
    });
  }

  bool isDead() {
    if (vAxis >= 1 || vAxis <= -1) {
      return true;
    }
    for (int i = 0; i < barX.length; i++) {
      if (barX[i] <= birdWidth &&
          barX[i] + barWidth >= -birdWidth &&
          (vAxis + birdHeight >= 1 - barY[i][1] || vAxis <= -1 + barY[i][0])) {
        return true;
      }
    }
    return false;
  }

  void _showDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          final theme = Theme.of(context);
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide(color: Color.fromARGB(255, 255, 7, 7), width: 5)),
            backgroundColor: Colors.grey[900],
            title: Text('G A M E  O V E R',
                textAlign: TextAlign.center,
                style: theme.textTheme.headline4!.copyWith(
                    color: Color.fromARGB(255, 255, 7, 7), fontWeight: FontWeight.bold)),
            content: Text(
              'SCORE: ' + '$score',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText2,
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () {
                    if (score > highScore) {
                      highScore = score;
                    }
                    reset();
                    showInterstitialAd();
                  },
                  child: Text(
                    "PLAY AGAIN",
                    style: theme.textTheme.button,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    createInterstitialAd();

    BannerAd(
            size: AdSize.banner,
            adUnitId: bottomAd == null
                ? 'ca-app-pub-3940256099942544/6300978111'
                : 'ca-app-pub-1282975341841237/4045218180',
            listener: BannerAdListener(onAdLoaded: (ad) {
              setState(() {
                isLoaded = true;
                bottomAd = ad as BannerAd;
              });
            }, onAdFailedToLoad: (ad, error) {
              ad.dispose();
            }),
            request: AdRequest())
        .load();
  }

  @override
  void dispose() {
    super.dispose();
    interstitialAd!.dispose();

    bottomAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (isStarted) {
                bounce();
              } else {
                gameStart();
              }
            },
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: theme.primaryColor,
                        child: Stack(
                          children: [
                            Bird(
                              birdY: vAxis,
                              birdHeight: birdHeight,
                              birdWidth: birdWidth,
                            ),
                            Container(
                              alignment: Alignment(0, -0.3),
                              child: isStarted
                                  ? Text('')
                                  : Text(
                                      " T A P  T O  P L A Y",
                                      style: theme.textTheme.headline4,
                                    ),
                            ),
                            Barrier(
                              barX: barX[0],
                              barWidth: barWidth,
                              barY: barY[0][0],
                              isBottom: false,
                            ),
                            Barrier(
                              barX: barX[0],
                              barWidth: barWidth,
                              barY: barY[0][1],
                              isBottom: true,
                            ),
                            Barrier(
                              barX: barX[1],
                              barWidth: barWidth,
                              barY: barY[1][0],
                              isBottom: false,
                            ),
                            Barrier(
                              barX: barX[1],
                              barWidth: barWidth,
                              barY: barY[1][1],
                              isBottom: true,
                            )
                          ],
                        ),
                      )),
                  Container(height: 15, color: theme.accentColor),
                  Expanded(
                      child: Container(
                    color: Colors.brown,
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.amber, width: 5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(1, 2),
                                blurRadius: 5,
                                //spreadRadius: 1
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("SCORE", style: theme.textTheme.headline4),
                                SizedBox(height: 15),
                                Text("$score",
                                    style: theme.textTheme.headline4!
                                        .copyWith(fontSize: 25))
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("BEST", style: theme.textTheme.headline4),
                                SizedBox(height: 15),
                                Text("$highScore",
                                    style: theme.textTheme.headline4!
                                        .copyWith(fontSize: 25))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: isLoaded ? bottomAd!.size.height.toDouble() : 0,
                width: isLoaded ? bottomAd!.size.width.toDouble() : 0,
                color: isLoaded ? Colors.white : Colors.transparent,
                child: isLoaded ? AdWidget(ad: bottomAd!) : SizedBox(),
              ))
        ],
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    var theme=Theme.of(context);
    return (await (showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide(color: Color.fromARGB(255, 255, 7, 7), width: 5)),
            backgroundColor: Colors.grey[900],
                  title: Center(
                      child: Text(
                    "W A R N I N G", style: theme.textTheme.headline4!.copyWith(
                    color: Color.fromARGB(255, 255, 7, 7), fontWeight: FontWeight.bold)
                  )),
                  content: Text(
                    "Do you really want to quit?",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: Text(
                          "Yes",
                        )),
                    TextButton(
                        onPressed: () => Navigator.pop(c, false),
                        child: Text(
                          "No",
                        ))
                  ],
                )) as FutureOr<bool>?)) ??
        false;
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: interstitialAd == null
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-1282975341841237/3786197880',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }
}
