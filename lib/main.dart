import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_landing_page/env/env.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:seo/seo.dart';
import 'package:dart_fusion/dart_fusion.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
  options: const FirebaseOptions(
      apiKey:'',
      appId: "1:365023603331:web:bef9697af6f012053549b6",
      messagingSenderId: "365023603331",
      projectId: "document-manager-865ad",
      storageBucket: "document-manager-865ad.firebasestorage.app"));
  setPathUrlStrategy();
  if (kIsWeb) MetaSEO().config();
  runApp(
    Builder(
      builder: (context) {
        return SeoController(
          tree: WidgetTree(context: context),
          child: MaterialApp.router(
            title: 'Автоматизация, которая экономит ваше время!',
            routerConfig: Env.routes,
            theme: Constants.lightTheme,
            debugShowCheckedModeBanner: false,
            scrollBehavior: const DBehavior(),
          ),
        );
      },
    ),
  );
}
