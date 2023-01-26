import 'package:dio/dio.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StatRepository {
  static Future<List<StatModel>> getStats() async {
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': dotenv.env['SERVICE_KEY'],
        'returnType': 'json',
        'numberOfRows': 30,
        'pageNo': 1,
        'itemCode': 'PM10',
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    return response.data['response']['body']['items']
        .map<StatModel>((item) => StatModel.fromJson(json: item))
        .toList();
  }
}
