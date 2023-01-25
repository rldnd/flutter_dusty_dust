import 'package:dusty_dust/components/main_app_bar.dart';
import 'package:dusty_dust/components/main_drawer.dart';
import 'package:dusty_dust/components/main_stat.dart';
import 'package:dusty_dust/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          const MainAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  color: LIGHT_COLOR,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: DARK_COLOR,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '종류별 통계',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          MainStat(
                            category: '미세먼지',
                            imgPath: 'assets/images/best.png',
                            level: '최고',
                            stat: '0㎍/㎥',
                          ),
                          MainStat(
                            category: '미세먼지',
                            imgPath: 'assets/images/best.png',
                            level: '최고',
                            stat: '0㎍/㎥',
                          ),
                          MainStat(
                            category: '미세먼지',
                            imgPath: 'assets/images/best.png',
                            level: '최고',
                            stat: '0㎍/㎥',
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
