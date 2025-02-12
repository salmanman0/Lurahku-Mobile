import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/routes/app_pages.dart';
import 'app/template/color_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize(); // flutter_screenutil
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = const Size(414, 895);
    return ScreenUtilInit(
      designSize: screenSize,
      builder: (_, __) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Lurahku",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundScreen,
        //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
        //     selectedItemColor: primary1,
        //     unselectedItemColor: secondary2,
        //     selectedLabelStyle: text500_2(12, primary1)
        //   ),
          inputDecorationTheme: InputDecorationTheme(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: abudebu, width: 1),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: abudebu, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primary1, width: 2),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
          ),
          canvasColor: backgroundScreen
        ),
      ),
    );
  }
}
