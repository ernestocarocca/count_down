import 'package:shared_preferences/shared_preferences.dart';

class TimePrefereces {
  static SharedPreferences? _preferences;
  static const _keysetTimeStoped = 'savedTime';
  static Future init() async => {
        _preferences = await SharedPreferences.getInstance(),
      };
    static Future setTime(Duration duration) async {
    final setTimeStop = duration.inSeconds.toString(); // Spara som sekunder för enkelhet
    print('Saving time: $setTimeStop');
    await _preferences?.setString(_keysetTimeStoped, setTimeStop);
  }

  static List<Duration> getTimeStopped() {
    final List<String>? timeStrings =
        _preferences?.getStringList(_keysetTimeStoped);
    if (timeStrings != null) {
      final List<Duration> durations = timeStrings.map((timeString) {
        final intSeconds = int.tryParse(timeString);
        if (intSeconds != null) {
          return Duration(seconds: intSeconds);
        }
        return Duration.zero;
      }).toList();

      print('Retrieved time strings: $timeStrings');
      print('Created durations: $durations');

      return durations;
    }
    return []; // Return an empty list if no time values are found
  }
}
