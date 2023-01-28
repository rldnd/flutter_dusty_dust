import 'package:dusty_dust/constants/colors.dart';
import 'package:dusty_dust/constants/regions.dart';
import 'package:flutter/material.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final OnRegionTap onRegionTap;
  final String selectedRegion;

  const MainDrawer(
      {super.key, required this.onRegionTap, required this.selectedRegion});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: DARK_COLOR,
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              '지역 선택',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          ...REGIONS.map(
            (region) => ListTile(
              tileColor: Colors.white,
              selectedTileColor: LIGHT_COLOR,
              selectedColor: Colors.black,
              selected: region == selectedRegion,
              onTap: () => onRegionTap(region),
              title: Text(region),
            ),
          ),
        ],
      ),
    );
  }
}
