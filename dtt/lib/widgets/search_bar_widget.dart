import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Provider/house_provider.dart';

///Custom searchBar with X option when there is a search string print
///This can be used as clear all button in search string .
///Uses house provider to filter the housing list as per user search query
class CustomSearchBar extends StatefulWidget {
  final HouseProvider houseProvider;

  const CustomSearchBar({super.key, required this.houseProvider});

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search for a home',
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  _searchController.clear();
                  widget.houseProvider.filterHouses('');
                },
              )
            : const Icon(Icons.search, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[350],
      ),
      onChanged: (value) {
        widget.houseProvider.filterHouses(value);
      },
    );
  }
}
