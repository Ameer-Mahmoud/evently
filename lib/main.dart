import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c16/core/resources/AppStyle.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/source/local/PrefsManager.dart';
import 'package:evently_c16/providers/ThemeProvider.dart';
import 'package:evently_c16/providers/userProvider.dart';
import 'package:evently_c16/ui/create/providers/create_event_provider.dart';
import 'package:evently_c16/ui/create/screen/creat_event_screen.dart';
import 'package:evently_c16/ui/create/screen/pick_location_screen.dart';
import 'package:evently_c16/ui/details/event_details_screen.dart';
import 'package:evently_c16/ui/details/provider/event_details_provider.dart';
import 'package:evently_c16/ui/home/home_screen.dart';
import 'package:evently_c16/ui/login/screen/login_screen.dart';
import 'package:evently_c16/ui/register/screen/register_screen.dart';
import 'package:evently_c16/ui/reset/reset_screen.dart';
import 'package:evently_c16/ui/splash/screen/onboarding_screen.dart';
import 'package:evently_c16/ui/splash/screen/splash_screen.dart';
import 'package:evently_c16/ui/start/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/models/event.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PrefsManager.int();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(EasyLocalization(
      supportedLocales: const [
        Locale("en"),
        Locale("ar"),
      ],
      path: 'assets/translations',
      // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      startLocale: const Locale("en"),
      child: ChangeNotifierProvider(
          create: (context) => ThemeProvider()..init(), child: MyApp())));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Evently',
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode: provider.mode,
      initialRoute: RoutesManager.splash,
      debugShowCheckedModeBanner: false,
      routes: {
        RoutesManager.splash: (_) => const SplashScreen(),
        RoutesManager.start: (_) => const StartScreen(),
        RoutesManager.onboarding: (_) => const OnboardingScreen(),
        RoutesManager.login: (_) => LoginScreen(),
        RoutesManager.register: (_) => RegisterScreen(),
        RoutesManager.eventDetailScreen:(context){
          Event event = ModalRoute.of(context)?.settings.arguments as Event;
           return  ChangeNotifierProvider(
             create: (context) => EventDetailsProvider(),
               child: EventDetailsScreen(event:event ,));
        } ,
        RoutesManager.home: (_) =>  ChangeNotifierProvider(
            create: ( context) => UserProvider(),
            child: const HomeScreen()),
        RoutesManager.reset:(_)=> const ResetScreen(),
    RoutesManager.create: (context) {
    Event? event = ModalRoute.of(context)?.settings.arguments as Event?;
    return ChangeNotifierProvider(
    create: (context) => CreateEventProvider(),
    child: CreateEventScreen(event: event),
    );
    },
        RoutesManager.pickLocationScreen: (context) {
          CreateEventProvider provider =
          ModalRoute.of(context)?.settings.arguments as CreateEventProvider;
          return PickLocationScreen(provider: provider);
        },

      },
    );
  }
}
