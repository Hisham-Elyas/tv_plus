import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/localization/language_controller.dart';
import '../data/models/fixtures_model.dart';
import '../data/repos/fixtures_repo.dart';

// enum StatusRequest { none, loading, success, serverFailure }

class FixturesController extends GetxController {
  final FixturesRepoImpHttp repo = Get.find();

  var fixtures = <League>[].obs;
  var selectedDate = DateTime.now().obs;
  var isLoading = false.obs;
  Rx<StatusRequest> statusReq = StatusRequest.loading.obs;
  var selectedLeagues = <int>[].obs; // optional for filters
  final Map<String, List<League>> _cachedFixtures = {};

  var currentTime = Rxn<DateTime>();
  var fixtureTimezone = Rxn<String>();
  static const String selectedLeaguesKey = 'selected_leagues';

  Future<void> saveSelectedLeagues() async {
    await SharedPrefHelper.setData(
      selectedLeaguesKey,
      jsonEncode(selectedLeagues),
    );
  }

  Future<void> loadSelectedLeagues() async {
    final leaguesString = await SharedPrefHelper.getString(selectedLeaguesKey);
    if (leaguesString.isNotEmpty) {
      final List<dynamic> ids = jsonDecode(leaguesString);
      selectedLeagues.assignAll(ids.cast<int>());
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await loadSelectedLeagues();
    await Future.delayed(
      Duration.zero,
      () async {
        // final timeZone = await getDeviceTimeZone();
        final location = tz.getLocation('Asia/Riyadh');
        // print('========== $location');
        // print('========== ${tz.TZDateTime.now(location)}');
        final timeNOw = tz.TZDateTime.now(location);
        fixtureTimezone.value = 'Asia/Riyadh'; // or use timeZone if needed
        selectedDate.value = timeNOw;
        currentTime.value = timeNOw;
      },
    );
    getAllTodayMatches();
  }

  Future<String> getDeviceTimeZone() async {
    try {
      final timeZone = await FlutterTimezone.getLocalTimezone();
      // print(timeZone);
      return timeZone;
    } catch (e) {
      return 'Asia/Riyadh';
    }
  }

  /// Public method used in UI
  Future<void> getAllTodayMatches({bool isRefresh = false}) async {
    await _fetchFixtures(
        date: formatDate(selectedDate.value), isRefresh: isRefresh);
  }

  /// Internal fetch with error handling
  Future<void> _fetchFixtures(
      {required String date, bool isRefresh = false}) async {
    try {
      if (isRefresh == false) {
        // ✅ Check if already cached
        if (_cachedFixtures.containsKey(date)) {
          fixtures.assignAll(_cachedFixtures[date]!);
          statusReq.value = StatusRequest.success;
          return;
        }
      }

      isLoading(true);
      statusReq.value = StatusRequest.loading;

      final response = await repo.getAllTodayMatches(date: date);
      response.fold(
        (error) {
          statusReq.value = error;
        },
        (data) {
          fixtures.assignAll(data.data);

          fixtureTimezone.value = data.timezone; // <— get from API or model
          if (fixtureTimezone.value != null) {
            final location = tz.getLocation(fixtureTimezone.value!);
            currentTime.value = tz.TZDateTime.now(location);
          }

          // ✅ Save to cache
          _cachedFixtures[date] = data.data;

          statusReq.value = StatusRequest.success;
        },
      );
    } catch (e) {
      statusReq.value = StatusRequest.serverFailure;
      // Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void toggleLeagueFilter(int leagueId) {
    if (selectedLeagues.contains(leagueId)) {
      selectedLeagues.remove(leagueId); // this triggers update
    } else {
      selectedLeagues.add(leagueId); // this triggers update
    }
    saveSelectedLeagues();
    update();
  }

  bool isSelected(League league) {
    return selectedLeagues.contains(league.id);
  }

  void clearFilters() {
    selectedLeagues.clear();
    saveSelectedLeagues();
    update();
  }

  List<League> get filteredFixtures {
    if (statusReq.value == StatusRequest.loading) {
      return dummyLeaguesList;
    }

    if (selectedLeagues.isEmpty) {
      return fixtures;
    }

    return fixtures
        .where((league) => selectedLeagues.contains(league.id))
        .toList();
  }

  /// Opens calendar to pick a date
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      selectedDate.value = picked;
      await _fetchFixtures(date: formatDate(picked));
    }
  }

  /// Optional: Go to previous day
  void previousDay() {
    selectedDate.value = selectedDate.value.subtract(const Duration(days: 1));
    getAllTodayMatches();
  }

  /// Optional: Go to next day
  void nextDay() {
    selectedDate.value = selectedDate.value.add(const Duration(days: 1));
    getAllTodayMatches();
  }

  /// Format date for API call (yyyy-MM-dd)
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Format date for UI display (dd/MM/yyyy)
  String formatDateDisplay(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Format full display date (e.g., Monday, 15/07/2025)
  final String locale = Get.find<LanguageController>().appLocale.languageCode;
  String get formattedDisplayDate =>
      "${dayOfWeek(selectedDate.value)}, ${formatDateDisplay(selectedDate.value)}";

  /// Format time with AM/PM (e.g., 08:30 AM)
  String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime); // 'a' adds AM/PM
  }

  /// Format full date and time (e.g., 15/07/2025 - 08:30 AM)
  String formatDateTime(DateTime dateTime) {
    return "${formatDateDisplay(dateTime)} - ${formatTime(dateTime)}";
  }

  /// Get day of the week (e.g., Monday)
  String dayOfWeek(DateTime date) {
    // const days = [
    //   "Sunday",
    //   "Monday",
    //   "Tuesday",
    //   "Wednesday",
    //   "Thursday",
    //   "Friday",
    //   "Saturday"
    // ];
    // return days[date.weekday % 7];
    return DateFormat('EEEE', locale).format(date);
  }
}
