import 'package:chart/config/db.dart';
import 'package:chart/model/model/therapist/therapist_name_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TherapistNameDatasource {
  Future<String> getTherapistName() async {
    final db = await DatabaseHelper.instance.database;
    final prefs = await SharedPreferences.getInstance();
    final savedEamil = prefs.getString('loggedEmail');
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [savedEamil],
    );

    if (result.isNotEmpty) {
      final therapistName = TherapistNameModel.fromMap(result.first);
      print('therapistname: ${therapistName.name}');
      return therapistName.name;
    } else {
      throw Exception('no name');
    }
  }
}
