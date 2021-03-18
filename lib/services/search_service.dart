import 'dart:async';
import '../core/const.dart';
import '../models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

class SearchService {
  Db db = Db(MONGO);

  StreamController<List<User>> _searchController = StreamController.broadcast();
  Stream<List<User>> get resultStream => _searchController.stream;
  Sink<List<User>> get _resultSink => _searchController.sink;

  Future<void> search(String phrase, String role) async {
    await db.open();
    DbCollection collection = db.collection("users");
    List<User> found = [];

    //TODO: exclude arrays from the results
    //TODO: repair searching
    var data = await collection.find(where.match("role", role)).toList();

    data.forEach((element) {
      found.add(User.fromJson(element));
      print(element);
    });
    _resultSink.add(found);
  }

  void dispose() {
    _searchController.close();
  }
}
