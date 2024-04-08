import 'dart:convert';
import 'package:assignment1/model/feature_model.dart';
import 'package:assignment1/model/popular_model.dart';
import 'package:assignment1/model/top_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://stagingauth.desidime.com/v4/home/';

  static const Map<String, String> headers = {
    'X-Desidime-Client': '08b4260e5585f282d1bd9d085e743fd9',
  };

  static Future<List<Deal>> fetchTopDeals(
      {int page = 1, int perPage = 10}) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/new?per_page=$perPage&page=$page&fields=id,created_at,created_at_in_millis,image_medium,comments_count,store{name}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        if (parsed != null &&
            parsed is Map<String, dynamic> &&
            parsed.containsKey('deals')) {
          List<Deal> fetchedDeals = [];
          for (var deal in parsed['deals']) {
            fetchedDeals.add(Deal.fromJson(deal ?? {}));
          }
          return fetchedDeals;
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      throw Exception('Error fetching data: $e');
    }
  }

  Future<List<PopularDeal>> fetchPopularDeal(
      {int perPage = 10, int page = 1}) async {
    final String url =
        '$baseUrl/discussed?per_page=$perPage&page=$page&fields=id.created_at.created_at_in_millis,image_medium,comments_count,store{name}';

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final welcomePopular = WelcomePopular.fromJson(jsonData);
      return welcomePopular.deals;
    } else {
      throw Exception('Failed to load deals');
    }
  }

  Future<List<FeatureDeal>> fetchFeatureDeals(
      {int perPage = 10, int page = 1}) async {
    final String url =
        '$baseUrl/discussed?per_page=$perPage&page=$page&fields=id.created_at.created_at_in_millis,image_medium,comments_count,store{name}';

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final welcomeFeature = WelcomeFeature.fromJson(jsonData);
      return welcomeFeature.deals;
    } else {
      throw Exception('Failed to load feature deals');
    }
  }
}
