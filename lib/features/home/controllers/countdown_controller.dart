// ignore_for_file: avoid_print

import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CountdownController extends GetxController {
  Timer? _timer;
  final Rx<Duration> timeRemaining = Duration.zero.obs;
  final RxBool isMatchStarted = false.obs;
  final RxBool isMatchEnded = false.obs;
  late DateTime matchDateTime;

  void startCountdown(String matchDate, String matchTime) {
    _timer?.cancel();

    try {
      // Parse the date/time string as UTC (true parameter)
      DateTime mymatchDateTime = DateFormat('EEEE dd-MM-yyyy hh:mm a')
          .parse('$matchDate $matchTime', true); // UTC parsing

      // Adjust for Riyadh time (UTC+3)
      // Since we parsed as UTC, and input is in Riyadh time (UTC+3),
      // we need to subtract 3 hours to get correct UTC time
      mymatchDateTime = mymatchDateTime.subtract(const Duration(hours: 4));

      // Convert to local device time
      DateTime localMatchDateTime = mymatchDateTime.toLocal();

      // Store for countdown calculations
      matchDateTime = localMatchDateTime;

      _updateTimer();
      _timer =
          Timer.periodic(const Duration(seconds: 1), (_) => _updateTimer());
    } catch (e) {
      print('Error parsing date/time: $e');
      // Handle error case appropriately
      matchDateTime = DateTime.now().add(const Duration(hours: 1)); // Fallback
      _updateTimer();
    }
  }

  void _updateTimer() {
    final now = DateTime.now();
    final difference = matchDateTime.difference(now);

    timeRemaining.value = difference;
    isMatchStarted.value = difference.isNegative;
    isMatchEnded.value =
        isMatchStarted.value && difference.abs() > const Duration(hours: 2);

    if (isMatchEnded.value) {
      _timer?.cancel();
    }
  }

  String get statusText {
    if (isMatchEnded.value) return 'Match Ended';
    if (isMatchStarted.value) return 'Match in Progress';
    return 'Match Starts in';
  }

  String get formattedTime {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    // Use the absolute value to handle negative durations consistently
    final duration = timeRemaining.value.abs();
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (isMatchEnded.value) {
      return "00:00:00"; // Match has ended
    } else if (isMatchStarted.value) {
      // Match is in progress - show elapsed time
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else if (days > 0) {
      // Match is upcoming and more than 1 day away
      return '${twoDigits(days)}d ${twoDigits(hours)}h';
    } else {
      // Match is upcoming within 24 hours
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
