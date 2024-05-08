import 'package:shared_preferences/shared_preferences.dart';

class GameData {
  Future<void> saveGameData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    String? existingData = prefs.getString(key);
    List<String> dataList = existingData != null ? existingData.split(',') : [];
    if (!dataList.contains(value)) {
      dataList.add(value);
      //dataList.sort((a, b) => a.compareTo(b)); //order list

      String updatedData = dataList.join(',');
      prefs.setString(key, updatedData);
    }
  }

  Future<List<String>> getGameData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key);
    return data != null ? data.split(',') : [];
  }
}
