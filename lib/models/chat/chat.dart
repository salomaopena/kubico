import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kubico/models/users/user_model.dart';

class Chat {
  String? id;
  String? message;
  Timestamp? time;
  String? userId;
  String? token;

  Chat({this.id, this.message, this.time, this.userId});

  Chat.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    message = snapshot.get('message') as String;
    time = snapshot.get('time') as Timestamp;
    userId = snapshot.get('user') as String;
    token = snapshot.get('token') as String;
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc("chat/$userId");

  CollectionReference get chatReference => firestoreRef.collection("messages");

  Future<void> send(UserModel user) async {
    token = await FirebaseMessaging.instance.getToken();
    userId = user.id;
    String time = Timestamp.now().toDate().toString();
    chatReference.doc(time).set({
      'message': message,
      'time': Timestamp.now(),
      'user': userId,
      'token': token,
    });
  }

  String get dateText => getTimeAgoSinceDate(time!.toDate().toString());

  static String getTimeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} anos atrás';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 ano atrás' : 'ano anterior';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} meses atrás';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 mês atrás' : 'último mês';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} semanas atrás';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 semana atrás' : 'última semana';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} dias atrás';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 dia atrás' : 'ontem';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} horas atrás';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hora atrás' : 'Uma hora atrás';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutos atrás';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minuto atrás' : 'Um minuto atrás';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} segundos atrás';
    } else {
      return 'Agora';
    }
  }

  @override
  String toString() {
    return 'Chat{user: $id, message: $message, time: $time, user: $userId}';
  }
}
