import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:khaliha_3alina/features/home/presentation/views/home_view.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/object_box.dart';

late final ObjectBox objectBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> initFuture;

  @override
  void initState() {
    super.initState();
    initFuture = initApp();
  }

  Future<void> initApp() async {
    objectBox = await ObjectBox.create();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initFuture,
      builder: (context, snapshot) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              locale: const Locale('ar'),
              supportedLocales: const [Locale('ar'), Locale('en')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              title: 'خليها علينا',
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.background,
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
              ),
              home: child,
            );
          },
          child: HomeView(),
        );
      },
    );
  }
}
