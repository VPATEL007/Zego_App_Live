import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/app_theme.dart';
import 'package:socialv/language/app_localizations.dart';
import 'package:socialv/language/languages.dart';
import 'package:socialv/models/common_models.dart';
import 'package:socialv/screens/splash_screen.dart';
import 'package:socialv/screens/video_call/demo_video_call.dart';
import 'package:socialv/store/app_store.dart';
import 'package:socialv/store/lms_store.dart';
import 'package:socialv/utils/app_constants.dart';
import 'dart:io';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

AppStore appStore = AppStore();
LmsStore lmsStore = LmsStore();

late BaseLanguage language;

String currentPackageName = '';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final navigatorKey = GlobalKey<NavigatorState>();

  ZegoUIKit().initLog().then((value) {
    runApp(MyApp(
      navigatorKey: navigatorKey,
    ));
  });
  HttpOverrides.global = MyHttpOverrides();
  await initialize(aLocaleLanguageList: languageList());

  Firebase.initializeApp().then((value) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    MobileAds.instance.initialize();
  }).catchError((e) {
    log('Error: ${e.toString()}');
  });

  defaultRadius = 32.0;
  defaultAppButtonRadius = 12;

  initializeOneSignal();

  exitFullScreen();

  runApp(MyApp(
    navigatorKey: navigatorKey,
  ));
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    afterBuildCreated(() async {
      int themeModeIndex = getIntAsync(SharePreferencesKey.APP_THEME,
          defaultValue: AppThemeMode.ThemeModeSystem);

      if (themeModeIndex == AppThemeMode.ThemeModeLight) {
        appStore.toggleDarkMode(value: false, isFromMain: true);
      } else {
        appStore.toggleDarkMode(value: true, isFromMain: true);
      }

      await appStore
          .setLoggedIn(getBoolAsync(SharePreferencesKey.IS_LOGGED_IN));
      if (appStore.isLoggedIn) {
        appStore.setToken(getStringAsync(SharePreferencesKey.TOKEN));
        appStore.setVerificationStatus(
            getStringAsync(SharePreferencesKey.VERIFICATION_STATUS));
        appStore.setNonce(getStringAsync(SharePreferencesKey.NONCE));
        appStore.setLoginEmail(getStringAsync(SharePreferencesKey.LOGIN_EMAIL));
        appStore.setLoginName(
            getStringAsync(SharePreferencesKey.LOGIN_DISPLAY_NAME));
        appStore.setLoginFullName(
            getStringAsync(SharePreferencesKey.LOGIN_FULL_NAME));
        appStore
            .setLoginUserId(getStringAsync(SharePreferencesKey.LOGIN_USER_ID));
        appStore.setLoginAvatarUrl(
            getStringAsync(SharePreferencesKey.LOGIN_AVATAR_URL));
      }

      if (getMemberListPref().isNotEmpty)
        appStore.recentMemberSearchList.addAll(getMemberListPref());
      if (getGroupListPref().isNotEmpty)
        appStore.recentGroupsSearchList.addAll(getGroupListPref());

      if (getLmsQuizListPref().isNotEmpty) {
        lmsStore.quizList.addAll(getLmsQuizListPref());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        navigatorKey: navigatorKey,
        title: APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: VideoHomePage(),
        //SplashScreen(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localizationsDelegates: [
          AppLocalizations(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(appStore.selectedLanguage
            .validate(value: Constants.defaultLanguage)),
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              child!,

              /// support minimizing
              ZegoUIKitPrebuiltLiveStreamingMiniOverlayPage(
                contextQuery: () {
                  return widget.navigatorKey.currentState!.context;
                },
              ),
            ],
          );
        },
        onGenerateRoute: (settings) {
          String pathComponents = settings.name!.split('/').last;

          if (pathComponents.isInt) {
            return MaterialPageRoute(
              builder: (context) {
                return SplashScreen(activityId: pathComponents.toInt());
              },
            );
          } else {
            return MaterialPageRoute(builder: (_) => SplashScreen());
          }
        },
      ),
    );
  }
}
