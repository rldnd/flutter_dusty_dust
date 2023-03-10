import 'package:hive_flutter/hive_flutter.dart';
part 'stat_model.g.dart';

@HiveType(typeId: 2)
enum ItemCode {
  @HiveField(0)
  PM10,
  @HiveField(1)
  PM25,
  @HiveField(2)
  NO2,
  @HiveField(3)
  O3,
  @HiveField(4)
  CO,
  @HiveField(5)
  SO2
}

@HiveType(typeId: 1)
class StatModel {
  @HiveField(0)
  final double daegu;
  @HiveField(1)
  final double chungnam;
  @HiveField(2)
  final double incheon;
  @HiveField(3)
  final double daejeon;
  @HiveField(4)
  final double gyeongbuk;
  @HiveField(5)
  final double sejong;
  @HiveField(6)
  final double gwangju;
  @HiveField(7)
  final double jeonbuk;
  @HiveField(8)
  final double gangwon;
  @HiveField(9)
  final double ulsan;
  @HiveField(10)
  final double jeonnam;
  @HiveField(11)
  final double seoul;
  @HiveField(12)
  final double busan;
  @HiveField(13)
  final double jeju;
  @HiveField(14)
  final double chungbuk;
  @HiveField(15)
  final double gyeongnam;
  @HiveField(16)
  final double gyeonggi;
  @HiveField(17)
  final DateTime dataTime;
  @HiveField(18)
  final ItemCode itemCode;

  StatModel({
    required this.busan,
    required this.chungbuk,
    required this.chungnam,
    required this.daegu,
    required this.daejeon,
    required this.dataTime,
    required this.gangwon,
    required this.gwangju,
    required this.gyeongbuk,
    required this.gyeonggi,
    required this.gyeongnam,
    required this.incheon,
    required this.itemCode,
    required this.jeju,
    required this.jeonbuk,
    required this.jeonnam,
    required this.sejong,
    required this.seoul,
    required this.ulsan,
  });

  StatModel.fromJson({required Map<String, dynamic> json})
      : daegu = double.parse(json['daegu'] ?? '0'),
        chungnam = double.parse(json['chungnam'] ?? '0'),
        incheon = double.parse(json['incheon'] ?? '0'),
        daejeon = double.parse(json['daejeon'] ?? '0'),
        gyeongbuk = double.parse(json['gyeongbuk'] ?? '0'),
        sejong = double.parse(json['sejong'] ?? '0'),
        gwangju = double.parse(json['gwangju'] ?? '0'),
        jeonbuk = double.parse(json['jeonbuk'] ?? '0'),
        gangwon = double.parse(json['gangwon'] ?? '0'),
        ulsan = double.parse(json['ulsan'] ?? '0'),
        jeonnam = double.parse(json['jeonnam'] ?? '0'),
        seoul = double.parse(json['seoul'] ?? '0'),
        busan = double.parse(json['busan'] ?? '0'),
        jeju = double.parse(json['jeju'] ?? '0'),
        chungbuk = double.parse(json['chungbuk'] ?? '0'),
        gyeongnam = double.parse(json['gyeongnam'] ?? '0'),
        gyeonggi = double.parse(json['gyeonggi'] ?? '0'),
        dataTime = DateTime.parse(json['dataTime']),
        itemCode = parseItemCode(json['itemCode']);

  static ItemCode parseItemCode(String raw) {
    if (raw == 'PM2.5') return ItemCode.PM25;

    return ItemCode.values.firstWhere((value) => value.name == raw);
  }

  double getLevelFromRegion(String region) {
    if (region == '??????') {
      return seoul;
    } else if (region == '??????') {
      return gyeonggi;
    } else if (region == '??????') {
      return daegu;
    } else if (region == '??????') {
      return chungnam;
    } else if (region == '??????') {
      return incheon;
    } else if (region == '??????') {
      return daejeon;
    } else if (region == '??????') {
      return gyeongbuk;
    } else if (region == '??????') {
      return sejong;
    } else if (region == '??????') {
      return gwangju;
    } else if (region == '??????') {
      return jeonbuk;
    } else if (region == '??????') {
      return gangwon;
    } else if (region == '??????') {
      return ulsan;
    } else if (region == '??????') {
      return jeonnam;
    } else if (region == '??????') {
      return busan;
    } else if (region == '??????') {
      return jeju;
    } else if (region == '??????') {
      return chungbuk;
    } else if (region == '??????') {
      return gyeongnam;
    } else {
      throw Exception('??? ??? ?????? ???????????????.');
    }
  }
}
