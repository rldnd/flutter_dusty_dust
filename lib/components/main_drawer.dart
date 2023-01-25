import 'package:dusty_dust/constants/colors.dart';
import 'package:flutter/material.dart';

const REGIONS = [
  '서울',
  '경기',
  '대구',
  '충남',
  '인천',
  '대전',
  '경북',
  '세종',
  '광주',
  '전북',
  '강원',
  '울산',
  '전남',
  '부산',
  '제주',
  '충북',
  '경남'
];

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

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
              selected: region == '서울',
              onTap: () {},
              title: Text(region),
            ),
          ),
        ],
      ),
    );
  }
}
