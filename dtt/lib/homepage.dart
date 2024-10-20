import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Provider/houseProvider.dart';
import 'houseDetailPage.dart';
import 'widgets/houseWidget.dart';
import 'widgets/noResultsWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        title: Text(
          "DTT REAL ESTATE",
          style: TextStyle(
              fontFamily: 'GothamSSM',
              fontWeight: FontWeight.w400,
              fontSize: 16.sp),
        ),
        centerTitle: false,
      ),
      body: Consumer<HouseProvider>(
        builder: (context, houseProvider, child) {
          if (!houseProvider.hasConnection) {
            return noInternetWidget();
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for a home',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    suffixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[350],
                  ),
                  onChanged: (value) {
                    houseProvider.filterHouses(value);
                  },
                ),
              ),
              Expanded(
                child: houseProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : houseProvider.filteredHouses.isEmpty
                        ? const NoResultsWidget()
                        : ListView.builder(
                            itemCount: houseProvider.filteredHouses.length,
                            itemBuilder: (context, index) {
                              final house = houseProvider.filteredHouses[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HouseDetailsPage(house: house),
                                    ),
                                  );
                                },
                                child: HouseWidget(house: house),
                              );
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }

  // No internet widget
  Widget noInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
          SizedBox(height: 20.h),
          const Text(
            'No Internet Connection',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: () {
              Provider.of<HouseProvider>(context, listen: false).hasConnection;
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
