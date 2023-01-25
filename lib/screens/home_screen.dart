import 'package:dusty_dust/components/category_card.dart';
import 'package:dusty_dust/components/main_app_bar.dart';
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
