import 'dart:async';

import 'package:razjo/core/const.dart';
import 'package:razjo/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

class SearchService {
  Db db = Db(MONGO);

  StreamController<List<User>> _searchController = StreamController();
  Stream<List<User>> get resultStream => _searchController.stream;
  Sink<List<User>> get _resultSink => _searchController.sink;


  //TODO: replace placeholder searching
  Future<void> search(String phrase) async {
    await db.open();
    DbCollection collection = db.collection("users");
    List<User> found = [];
    var data = await collection.find(
      where.match("name", "Oli"),
    ).toList();
    data.forEach((element) {
      found.add(User.fromJson(element));
    });
    _resultSink.add(found);
  }

  void dispose(){
    _searchController.close();
  }
}
