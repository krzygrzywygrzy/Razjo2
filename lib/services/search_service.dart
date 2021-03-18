import 'dart:async';
import 'dart:math';
import '../core/const.dart';
import '../models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

class SearchService {
  Db db = Db(MONGO);

  StreamController<List<User>> _searchController = StreamController.broadcast();
  Stream<List<User>> get resultStream => _searchController.stream;
  Sink<List<User>> get _resultSink => _searchController.sink;

  Future<void> search(String phrase) async {
    await db.open();
    DbCollection collection = db.collection("users");
    List<User> found = [];

    //TODO: check agregation pipeline

    //TODO: exclude arrays from the results
    var data = await collection.find(
        // {
        //   '\$text': {'\$search': phrase}
        // },
        {
          "name": phrase,
        }).toList();

    data.forEach((element) {
      found.add(User.fromJson(element));
    });
    _resultSink.add(found);
  }

  void dispose() {
    _searchController.close();
  }
}
