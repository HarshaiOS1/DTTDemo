import 'package:dtt/widgets/houseWidget.dart';
import 'package:dtt/widgets/noResultsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'Provider/houseProvider.dart';
import 'houseDetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HouseProvider>(context, listen: false).loadHouses();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle featureTextStyle = TextStyle(
        fontSize: 10.sp,
        fontFamily: 'GothamSSM',
        fontWeight: FontWeight.w400,
        color: Colors.grey);

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "DTT REAL ESTATE",
          style: TextStyle(
              fontFamily: 'GothamSSM',
              fontWeight: FontWeight.w400,
              fontSize: 16.sp),
        ),
        centerTitle: false,
      ),
      body: Column(children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for a home',
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onChanged: (value) {
              Provider.of<HouseProvider>(context, listen: false)
                  .filterHouses(value);
            },
          ),
        ),
        Expanded(
          child:
              Consumer<HouseProvider>(builder: (context, houseProvider, child) {
            if (houseProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            List<dynamic> housesToDisplay = houseProvider.filteredHouses;

            if (housesToDisplay.isEmpty) {
              return const NoResultsWidget(); // Use the new NoResultsWidget
            }

            return ListView.builder(
              itemCount: housesToDisplay.length,
              itemBuilder: (context, index) {
                final house = housesToDisplay[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HouseDetailsPage(house: house),
                      ),
                    );
                  },
                  child: HouseWidget(house: house),
                );
              },
            );
          }),
        ),
      ]),
    );
  }
}
