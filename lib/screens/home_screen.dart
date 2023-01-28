import 'package:dusty_dust/components/category_card.dart';
import 'package:dusty_dust/components/hourly_card.dart';
import 'package:dusty_dust/components/main_app_bar.dart';
import 'package:dusty_dust/components/main_drawer.dart';
import 'package:dusty_dust/constants/colors.dart';
import 'package:dusty_dust/constants/regions.dart';
import 'package:dusty_dust/models/stat_and_status_model.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:dusty_dust/repositorires/stat_repository.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = REGIONS[0];

  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};
    List<Future> futures = [];

    for (final itemCode in ItemCode.values) {
      futures.add(StatRepository.getStats(itemCode: itemCode));
    }

    final results = await Future.wait(futures);

    for (int i = 0; i < results.length; i++) {
      final ItemCode key = ItemCode.values[i];
      final List<StatModel> value = results[i];
      stats.addAll({key: value});
    }

    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      drawer: MainDrawer(
        selectedRegion: region,
        onRegionTap: (region) {
          setState(() => this.region = region);
          Navigator.of(context).pop();
        },
      ),
      body: FutureBuilder<Map<ItemCode, List<StatModel>>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('에러가 있습니다.'));
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            Map<ItemCode, List<StatModel>> stats = snapshot.data!;
            StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

            final status = DataUtils.getCurrentStatusFromStat(
                value: pm10RecentStat.seoul, itemCode: ItemCode.PM10);

            final ssModel = stats.keys.map((key) {
              final value = stats[key]!;
              final stat = value[0];

              return StatAndStatusModel(
                itemCode: key,
                status: DataUtils.getCurrentStatusFromStat(
                  value: stat.getLevelFromRegion(region),
                  itemCode: key,
                ),
                stat: stat,
              );
            }).toList();

            return CustomScrollView(
              slivers: [
                MainAppBar(
                  region: region,
                  stat: pm10RecentStat,
                  status: status,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(
                        region: region,
                        models: ssModel,
                      ),
                      const SizedBox(height: 16.0),
                      const HourlyCard(),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
