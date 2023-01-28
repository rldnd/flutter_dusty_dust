import 'package:dusty_dust/components/card_title.dart';
import 'package:dusty_dust/components/main_card.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HourlyCard extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final ItemCode itemCode;
  final String region;

  const HourlyCard({
    super.key,
    required this.darkColor,
    required this.lightColor,
    required this.region,
    required this.itemCode,
  });

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundColor: lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: '시간 별 ${DataUtils.getItemCodeKrString(itemCode: itemCode)}',
            backgroundColor: darkColor,
          ),
          ValueListenableBuilder<Box>(
            valueListenable: Hive.box<StatModel>(itemCode.name).listenable(),
            builder: (context, box, widget) {
              return Column(
                children: box.values
                    .toList()
                    .reversed
                    .map((stat) => renderRow(stat: stat))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget renderRow({required StatModel stat}) {
    final status = DataUtils.getCurrentStatusFromStat(
      value: stat.getLevelFromRegion(region),
      itemCode: stat.itemCode,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Row(
        children: [
          Expanded(child: Text('${stat.dataTime.hour}시')),
          Expanded(
            child: Image.asset(
              status.imagePath,
              height: 20.0,
            ),
          ),
          Expanded(
              child: Text(
            status.label,
            textAlign: TextAlign.right,
          )),
        ],
      ),
    );
  }
}
