import 'package:dusty_dust/components/category_card.dart';
import 'package:dusty_dust/components/hourly_card.dart';
import 'package:dusty_dust/components/main_app_bar.dart';
import 'package:dusty_dust/components/main_drawer.dart';
import 'package:dusty_dust/constants/colors.dart';
import 'package:dusty_dust/repositorires/stat_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    final statModels = await StatRepository.getStats();
    print(statModels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      drawer: const MainDrawer(),
      body: CustomScrollView(
        slivers: [
          const MainAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                CategoryCard(),
                SizedBox(height: 16.0),
                HourlyCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
