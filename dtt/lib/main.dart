import 'package:dtt/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'Provider/house_provider.dart';
import 'screens/homepage.dart';
import 'screens/information_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HouseProvider()..loadHouses(),
          child: const MyApp(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: MediaQuery.of(context).size,
        minTextAdapt: true,
        splitScreenMode: true,
        enableScaleText: () => true,
        enableScaleWH: () => true,
        builder: (_, child) {
          return const MaterialApp(
            home: CustomBottomNavigationBar(),
          );
        });
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  List<Widget> get _widgetOptions =>
      <Widget>[const HomePage(), const InformationPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        backgroundColor: Colors.white70,
        bottomNavigationBar: SizedBox(
          height: 98.h,
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 30.sp), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info, size: 30.sp), label: "")
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.shade500,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            onTap: _onItemTapped,
          ),
        ));
  }
}
