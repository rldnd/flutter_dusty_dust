import 'package:dusty_dust/components/category_card.dart';
import 'package:dusty_dust/components/hourly_card.dart';
import 'package:dusty_dust/components/main_app_bar.dart';
import 'package:dusty_dust/components/main_drawer.dart';
import 'package:dusty_dust/constants/colors.dart';
import 'package:dusty_dust/constants/status_level.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:dusty_dust/repositorires/stat_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<StatModel>> fetchData() async {
    final statModels = await StatRepository.getStats();
    return statModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      drawer: const MainDrawer(),
      body: FutureBuilder<List<StatModel>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('에러가 있습니다.'));
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            List<StatModel> stats = snapshot.data!;
            StatModel recentStat = stats[0];

            final status = statusLevel
                .where((level) => level.minFineDust < recentStat.seoul)
                .last;

            return CustomScrollView(
              slivers: [
                MainAppBar(
                  stat: recentStat,
                  status: status,
                ),
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
            );
          }),
    );
  }
}
