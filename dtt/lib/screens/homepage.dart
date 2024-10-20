import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Provider/houseProvider.dart';
import '../widgets/houseWidget.dart';
import '../widgets/noResultsWidget.dart';
import 'houseDetailPage.dart';

/// HomePage displays the main screen for listing real estate houses.
/// It allows users to search for houses, view filtered results, and navigate to house details.
/// The page includes a search bar and a list of filtered houses.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Builds the HomePage UI, which includes:
  /// - A search bar for filtering homes.
  /// - A list of homes, or an indicator if no results are found.
  /// - Navigation to the house detail page when a house is selected.
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

      /// Uses Consumer to listen to HouseProvider and update UI based on internet connection status and house data.
      body: Consumer<HouseProvider>(
        builder: (context, houseProvider, child) {
          /// Displays a message if there is no internet connection.
          if (!houseProvider.hasConnection) {
            return noInternetWidget();
          }

          /// Displays the house search bar and a list of filtered homes.
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),

                /// Search bar allows users to filter houses by text input.
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

              /// Displays a loading indicator while house data is being fetched.
              /// If no houses match the search, a NoResultsWidget is shown.
              Expanded(
                child: houseProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : houseProvider.filteredHouses.isEmpty
                        ? const NoResultsWidget()

                        /// Displays a list of filtered houses. Each house navigates to HouseDetailsPage when tapped.

                        : ListView.builder(
                            itemCount: houseProvider.filteredHouses.length,
                            itemBuilder: (context, index) {
                              final house = houseProvider.filteredHouses[index];
                              return GestureDetector(
                                onTap: () {
                                  /// Navigates to HouseDetailsPage when a house is selected.

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
