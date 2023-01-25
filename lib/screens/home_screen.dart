import 'package:dusty_dust/components/card_title.dart';
import 'package:dusty_dust/components/category_card.dart';
import 'package:dusty_dust/components/main_app_bar.dart';
import 'package:dusty_dust/components/main_card.dart';
import 'package:dusty_dust/components/main_drawer.dart';
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
                CategoryCard(),
                const SizedBox(height: 16.0),
                MainCard(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CardTitle(title: '시간 별 미세먼지'),
                    Column(
                      children: List.generate(
                        24,
                        (index) {
                          final now = DateTime.now();
                          final hour = now.hour;
                          int currentHour = hour - index;

                          if (currentHour < 0) currentHour += 24;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(child: Text('$currentHour시')),
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/good.png',
                                    height: 20.0,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  '좋음',
                                  textAlign: TextAlign.right,
                                )),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
