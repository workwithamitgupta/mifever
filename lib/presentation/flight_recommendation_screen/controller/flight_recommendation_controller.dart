import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/flight_recommendation_screen/models/flight_recommendation_model.dart';

import '../../flight_recommendation_one_screen/models/fliter_model.dart';
import '../../flight_recommendation_one_screen/models/suggestion_model.dart';

class FlightRecommendationController extends GetxController {
  Rx<FlightRecommendationModel> flightRecommendationModelObj =
      FlightRecommendationModel().obs;

  final pickLocationController = TextEditingController();

  final dropLocationToController = TextEditingController();

  Rx<DateTime> initialDateTime = DateTime.now().obs;

  var selectedDate = 'Select date'.obs;

  var pickLocationEntityId = ''.obs;

  var dropLocationEntityId = ''.obs;

  var pickLocationSkyId = ''.obs;

  var dropLocationSkyId = ''.obs;

  List<Suggestions> suggestions = <Suggestions>[].obs;

  List<FliteModel> fliteModel = <FliteModel>[].obs;

  Future<List<Suggestions>> showFlightSuggestion(String query) async {
    try {
      var _dio = Dio();
      var response = await _dio.get(
          'https://sky-scrapper.p.rapidapi.com/api/v1/flights/searchAirport',
          queryParameters: {
            'query': query,
          },
          options: Options(headers: {
            'X-RapidAPI-Key':
                '1c94f30592mshd4f39cb8415eefep1e7128jsn487b6d691b03',
            'X-RapidAPI-Host': 'sky-scrapper.p.rapidapi.com'
          }));
      if (response.statusCode == 200) {
        print(response.data);
        suggestions.clear();
        SuggestionModel suggestionModel =
            SuggestionModel.fromJson(response.data);
        suggestions.assignAll(suggestionModel.suggestions);
        return suggestionModel.suggestions;
      }
      return <Suggestions>[];
    } catch (e) {
      log('Error during show flite', error: e);
      return <Suggestions>[];
    }
  }

  Future<void> getFlight() async {
    log('object');
    try {
      var _dio = Dio();
      log('try');
      log(selectedDate.value);
      var response = await _dio.get(
          'https://sky-scrapper.p.rapidapi.com/api/v2/flights/searchFlights',
          queryParameters: {
            'originSkyId': pickLocationSkyId.value,
            'destinationSkyId': dropLocationSkyId.value,
            'originEntityId': pickLocationEntityId.value,
            'destinationEntityId': dropLocationEntityId.value,
            'date': '2024-03-22',
            // selectedDate.value,
            'adults': 1,
            'currency': 'USD',
            'market': 'en-US',
            'countryCode': 'US',
          },
          options: Options(headers: {
            'X-RapidAPI-Key':
                '1c94f30592mshd4f39cb8415eefep1e7128jsn487b6d691b03',
            'X-RapidAPI-Host': 'sky-scrapper.p.rapidapi.com'
          }));

      if (response.statusCode == 200) {
        List dataList = response.data['data']['itineraries'];
        log(dataList.toString());
        fliteModel.clear();
        for (var data in dataList) {
          FliteModel model = FliteModel.fromJson(data);
          fliteModel.add(model);
        }
      }
    } catch (e) {
      log('Error during get flite', error: e);
    }
  }
}
