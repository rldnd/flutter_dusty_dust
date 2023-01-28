import 'package:dusty_dust/components/card_title.dart';
import 'package:dusty_dust/components/main_card.dart';
import 'package:dusty_dust/components/main_stat.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryCard extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final String region;

  const CategoryCard({
    super.key,
    required this.region,
    required this.darkColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardTitle(
                  title: '종류별 통계',
                  backgroundColor: darkColor,
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: PageScrollPhysics(),
                    children: ItemCode.values
                        .map(
                          (itemCode) => ValueListenableBuilder<Box>(
                            valueListenable:
                                Hive.box<StatModel>(itemCode.name).listenable(),
                            builder: (context, box, widget) {
                              final stat = box.values.last as StatModel;
                              final status = DataUtils.getCurrentStatusFromStat(
                                  value: stat.getLevelFromRegion(region),
                                  itemCode: itemCode);

                              return MainStat(
                                category: DataUtils.getItemCodeKrString(
                                  itemCode: itemCode,
                                ),
                                imgPath: status.imagePath,
                                level: status.label,
                                stat:
                                    '${stat.getLevelFromRegion(region)}${DataUtils.getUnitFromItemCode(itemCode: itemCode)}',
                                width: constraint.maxWidth / 3,
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
