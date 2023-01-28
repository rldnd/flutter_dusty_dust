import 'package:dio/dio.dart';
import 'package:dusty_dust/components/main_app_bar.dart';
import 'package:dusty_dust/components/main_drawer.dart';
import 'package:dusty_dust/constants/regions.dart';
import 'package:dusty_dust/container/category_card.dart';
import 'package:dusty_dust/container/hourly_card.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:dusty_dust/repositorires/stat_repository.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = REGIONS[0];
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    fetchData();
  }

  @override
  dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final now = DateTime.now();
      final fetchTime = DateTime(now.year, now.month, now.day, now.hour);

      final box = Hive.box<StatModel>(ItemCode.PM10.name);
      final recent = box.values.last;

      if (recent.dataTime.isAtSameMomentAs(fetchTime)) return;

      List<Future> futures = [];

      for (final itemCode in ItemCode.values) {
        futures.add(StatRepository.getStats(itemCode: itemCode));
      }

      final results = await Future.wait(futures);

      for (int i = 0; i < results.length; i++) {
        final ItemCode key = ItemCode.values[i];
        final List<StatModel> value = results[i];

        final box = Hive.box<StatModel>(key.name);
        for (StatModel stat in value) {
          box.put(stat.dataTime.toString(), stat);
        }

        final allKeys = box.keys.toList();
        if (allKeys.length > 24) {
          final deleteKeys = allKeys.sublist(0, allKeys.length - 24);
          box.deleteAll(deleteKeys);
        }
      }
    } on DioError catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('인터넷 연결이 원활하지 않습니다.'),
      ));
    }
  }

  scrollListener() {
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;
    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (context, box, widget) {
        final recentStat = box.values.toList().last as StatModel;

        final status = DataUtils.getCurrentStatusFromStat(
          value: recentStat.getLevelFromRegion(region),
          itemCode: ItemCode.PM10,
        );

        return Scaffold(
          drawer: MainDrawer(
            darkColor: status.darkColor,
            lightColor: status.lightColor,
            selectedRegion: region,
            onRegionTap: (region) {
              setState(() => this.region = region);
              Navigator.of(context).pop();
            },
          ),
          body: Container(
            color: status.primaryColor,
            child: RefreshIndicator(
              onRefresh: () async {
                await fetchData();
              },
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  MainAppBar(
                    region: region,
                    stat: recentStat,
                    status: status,
                    dateTime: recentStat.dataTime,
                    isExpanded: isExpanded,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CategoryCard(
                          region: region,
                          darkColor: status.darkColor,
                          lightColor: status.lightColor,
                        ),
                        const SizedBox(height: 16.0),
                        ...ItemCode.values.map(
                          (itemCode) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: HourlyCard(
                                darkColor: status.darkColor,
                                lightColor: status.lightColor,
                                itemCode: itemCode,
                                region: region,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
