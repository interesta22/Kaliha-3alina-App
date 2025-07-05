import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/core/constants/hive_const.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/logic/read_cubit.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/logic/write_cubit.dart';
import 'package:khaliha_3alina/features/home/presentation/views/home_view.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/ride_model.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model_adaptor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(VehicleTypeAdapter());
Hive.registerAdapter(RiderModelAdapter());
Hive.registerAdapter(RideModelAdapter());

  await Hive.openBox(HiveConstants.ridesBox);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WriteCubit()),
        BlocProvider(create: (_) => ReadCubit()),
      ],
      child: ScreenUtilInit(
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
      ),
    );
  }
}
