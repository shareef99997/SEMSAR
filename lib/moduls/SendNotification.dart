import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class SendNotification {
  final String title;
  final String body;
  final String userID;

  SendNotification({this.body, this.title, this.userID});

  Future <bool> getTokens(BuildContext context) async {
    bool isNotificationSent;
    await FirebaseFirestore.instance.collection('UsersAccount').doc(userID).get().then((value) async{
      await addNotification(userID);
      await sendNotification(context,value.data()['FBNotificationToken']);
      print('/////////////////////////////Notification sent✅');
      isNotificationSent=true;
    });
    return isNotificationSent;
  }

  addNotification(String uid)async{
    await FirebaseFirestore.instance.collection('Notifications').add({
      'Title':title,
      'Body':body,
      'Seen':false,
      'SeenAt':null,
      'SendAt':DateTime.now(),
      'UserID':uid
    });
  }

  Future<bool> sendNotification(BuildContext context, String tokenNo) async {
    bool isNotificationSent;
    final data = {
      'notification': {
        'body': '$body',
        'title': '$title',
        'sound': 'default',
        'badge': '1',
      },
      'priority': 'high',
      'to': '$tokenNo'
    };
    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=AAAAgqvrrJI:APA91bEfU4wNoDiq3z5loN8DUMjP4hPYhlb8X0D50Z0i5-7dEdev_dKmjs4wclDxUEaa6wLg8p6qCW7WI9zyrOg6tqH6olCYRIxXsyYnsbEcWNnKpk63Zm1SNEyjGUFwhg-EAUl7-GFi'
    };
    BaseOptions options = BaseOptions(
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
      headers: headers,
    );
    try {
      final response = await Dio(options).post('https://fcm.googleapis.com/fcm/send', data: data);
      if (response.statusCode == 200) {
        print('///////////////////////////////////////////////////////✅');
        isNotificationSent = true;
      } else {
        isNotificationSent = false;
        print('///////////////////////////////////////////////////////❌');
      }
    }
    catch (e) {
      isNotificationSent = false;
      print('///////////////////////////////////////////////////////❌exception $e');
    }
    return isNotificationSent;
  }
}