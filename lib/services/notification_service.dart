import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/models/invitation.dart' as model;

class NotificationService {
  Db db = Db(MONGO);

  Future<void> sendNotification(
      String collection, model.Notification invitation) async {
    //TODO: error handling
    print(collection);

    await db.open();
    DbCollection coll = db.collection(collection);
    coll.insertOne(invitation.toJson());
    await db.close();
  }
}
