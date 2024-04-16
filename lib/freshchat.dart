import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:freshchat_sdk/freshchat_user.dart';




class Chat extends StatelessWidget {
  static String route = "/Chat";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freshchat Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xff014E70),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Freshchat Flutter Demo'),
    );
  }
}

void handleFreshchatNotification(Map<String, dynamic> message) async {
  if (await Freshchat.isFreshchatNotification(message)) {
    print("is Freshchat notification");
    Freshchat.handlePushNotification(message);
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print("Inside background handler");
  await Firebase.initializeApp();
  handleFreshchatNotification(message.data);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final GlobalKey<ScaffoldState>? _scaffoldKey = GlobalKey<ScaffoldState>();

  void registerFcmToken() async {
    if (Platform.isAndroid) {
      String? token = await FirebaseMessaging.instance.getToken();
      print("FCM Token is generated $token");
      Freshchat.setPushRegistrationToken(token!);
    }
  }


  void restoreUser(BuildContext context) {
    var externalId, restoreId, obtainedRestoreId;
    var alert = AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: const Text(
        "Identify/Restore User",
        textDirection: TextDirection.ltr,
        style: TextStyle(fontFamily: 'OpenSans-Regular'),
      ),
      content: Form(
        child: Column(
          children: [
            TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "External ID",
                ),
                onChanged: (val) {
                  setState(() {
                    externalId = val;
                  });
                }),
            TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Restore ID",
                ),
                onChanged: (val) {
                  setState(() {
                    restoreId = val;
                  });
                }),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
              elevation: 10.0,
              child: const Text(
                "Identify/Restore",
                textDirection: TextDirection.ltr,
              ),
              onPressed: () {
                setState(
                  () {
                    Freshchat.identifyUser(
                        externalId: externalId, restoreId: restoreId);
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                );
              },
            ),
            MaterialButton(
              elevation: 10.0,
              child: const Text(
                "Cancel",
                textDirection: TextDirection.ltr,
              ),
              onPressed: () {
                setState(() {
                  Navigator.of(context, rootNavigator: true).pop(context);
                });
              },
            ),
          ],
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void notifyRestoreId(var event) async {
    FreshchatUser user = await Freshchat.getUser;
    String? restoreId = user.getRestoreId();
    if (restoreId != null) {
      Clipboard.setData(ClipboardData(text: restoreId));
      // showToast("Restore ID copied: $restoreId");
    }
  }
    void getUserProps(BuildContext context) {
      final userInfoKey = GlobalKey<FormState>();
      String? key, value;
      var alert = AlertDialog(
        scrollable: true,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: const Text(
          "Custom User Properties:",
          textDirection: TextDirection.ltr,
          style: TextStyle(fontFamily: 'OpenSans-Regular'),
        ),
        content: Form(
          key: userInfoKey,
          child: Column(
            children: [
              TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Key",
                  ),
                  onChanged: (val) {
                    setState(() {
                      key = val;
                    });
                  }),
              TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Value",
                  ),
                  onChanged: (val) {
                    setState(() {
                      value = val;
                    });
                  }),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MaterialButton(
                elevation: 10.0,
                child: const Text(
                  "Add Properties",
                  textDirection: TextDirection.ltr,
                ),
                onPressed: () {
                  setState(() {
                    Map map = {key: value};
                    Freshchat.setUserProperties(map);
                  });
                },
              ),
              MaterialButton(
                elevation: 10.0,
                child: const Text(
                  "Cancel",
                  textDirection: TextDirection.ltr,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  });
                },
              ),
            ],
          ),
        ],
      );
      showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    }
    void sendMessageApi(BuildContext context) {
      final userInfoKey = GlobalKey<FormState>();
      String? conversationTag, message;
      var alert = AlertDialog(
        scrollable: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: const Text(
          "Send Message API",
          textDirection: TextDirection.ltr,
          style: TextStyle(fontFamily: 'OpenSans-Regular'),
        ),
        content: Form(
          key: userInfoKey,
          child: Column(
            children: [
              TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Conversation Tag",
                  ),
                  onChanged: (val) {
                    setState(() {
                      conversationTag = val;
                    });
                  }),
              TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Message",
                  ),
                  onChanged: (val) {
                    setState(() {
                      message = val;
                    });
                  }),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MaterialButton(
                elevation: 10.0,
                child: const Text(
                  "Send Message",
                  textDirection: TextDirection.ltr,
                ),
                onPressed: () {
                  setState(
                    () {
                      Freshchat.sendMessage(conversationTag!, message!);
                      Navigator.of(context, rootNavigator: true).pop(context);
                    },
                  );
                },
              ),
              MaterialButton(
                elevation: 10.0,
                child: const Text(
                  "Cancel",
                  textDirection: TextDirection.ltr,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  });
                },
              ),
            ],
          ),
        ],
      );
      showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    }

     String APP_ID = "83a33165-1124-4e35-90f5-947c57f0ada6",
        APP_KEY = "f09bf7f2-bd19-4a81-a5e5-b2cc1f1a621a",
        DOMAIN = "msdk.freshchat.com";
    void initState() {
      super.initState();
      Freshchat.init(APP_ID, APP_KEY, DOMAIN,
          teamMemberInfoVisible:true,
          cameraCaptureEnabled:true,
          gallerySelectionEnabled:true,
          responseExpectationEnabled:true,
          showNotificationBanneriOS:true,
      );
      /**
       * This is the Firebase push notification server key for this sample app.
       * Please save this in your Freshchat account to test push notifications in Sample app.
       *
       * Server key: Please refer support documentation for the server key of this sample app.
       *
       * Note: This is the push notification server key for sample app. You need to use your own server key for testing in your application
       */
      var restoreStream = Freshchat.onRestoreIdGenerated;
      var restoreStreamSubsctiption = restoreStream.listen((event) {
        print("Restore ID Generated: $event");
        notifyRestoreId(event);
      });

      var unreadCountStream = Freshchat.onMessageCountUpdate;
      unreadCountStream.listen((event) {
        print("Have unread messages: $event");
      });

      var userInteractionStream = Freshchat.onUserInteraction;
      userInteractionStream.listen((event) {
        print("User interaction for Freshchat SDK");
      });

      if (Platform.isAndroid) {
        registerFcmToken();
        FirebaseMessaging.instance.onTokenRefresh
            .listen(Freshchat.setPushRegistrationToken);

        Freshchat.setNotificationConfig(notificationInterceptionEnabled: true);
        var notificationInterceptStream = Freshchat.onNotificationIntercept;
        notificationInterceptStream.listen((event) {
          print("Freshchat Notification Intercept detected");
          Freshchat.openFreshchatDeeplink(event["url"]);
        });

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          var data = message.data;
          handleFreshchatNotification(data);
          print("Notification Content: $data");
        });
        FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
      }
    }

    void _incrementCounter() {
      setState(() {
        Freshchat.showConversations();
      });
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Freshchat Flutter Demo'),
        ),
        body: Builder(
          builder: (context) => GridView.count(
            crossAxisCount: 2,
            children: List.generate(6, (index) {
              switch (index) {
                case 0:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "FAQs",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () {
                        Freshchat.showFAQ(
                            showContactUsOnFaqScreens: true,
                            showContactUsOnAppBar: true,
                            showFaqCategoriesAsGrid: true,
                            showContactUsOnFaqNotHelpful: true);
                      });
                  break;
                case 1:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "Unread Count",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () async {
                        var unreadCountStatus =
                            await Freshchat.getUnreadCountAsync;
                        int count = unreadCountStatus['count'];
                        String status = unreadCountStatus['status'];
                        final snackBar = SnackBar(
                          content: Text(
                              "Unread Message Count: $count  Status: $status"),
                        );
                        // showToast(snackBar);
                      });
                  break;
                case 2:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "Reset User",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () {
                        Freshchat.resetUser();
                      });
                  break;
                case 3:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "Restore User",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () {
                        restoreUser(context);
                      });
                  break;
                case 4:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "Set User Properties",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () {
                        getUserProps(context);
                      });
                  break;
                case 5:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "Send Message",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () {
                        sendMessageApi(context);
                      });
                  break;
                default:
                  return Center(
                    child: Text(
                      'Item $index',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  );
                  break;
              }
            }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Chat',
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }
}
