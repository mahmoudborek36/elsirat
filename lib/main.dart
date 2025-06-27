import 'package:elsirat/core/model/date_model.dart';
import 'package:elsirat/core/services%20copy/dio_provider.dart';
import 'package:elsirat/core/services%20copy/local.dart';
import 'package:elsirat/core/services/local.dart';
import 'package:elsirat/core/services/notification/notification_services.dart';
import 'package:elsirat/core/utils/themes.dart';
import 'package:elsirat/fearture/auth/presentaion/cubit/auth_cubit.dart';
import 'package:elsirat/fearture/intro/splach_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'firebase_options.dart';








void initializeTimeZone() {
  tz.initializeTimeZones();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalStorageshared.init();
  await Permission.notification.request();

  initializeTimeZone();
  DioProvider.init();
  await Hive.initFlutter();
  Hive.registerAdapter(DateModelAdapter());
  await Hive.openBox<DateModel>('taskbox');
  await AppLocalStorege.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(360, 800), // Use the size of your design (Figma/XD)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AuthCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            home: const SplachScreen(),
          ),
        );
      },
    );
  }
}
