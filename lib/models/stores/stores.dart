//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kubico/models/users/user_address.dart';
import 'package:kubico/utils/extensions.dart';

enum StoreStatus { open, closing, closed }

class Stores {
  String id;
  String name;
  String image;
  String phone;
  UserAddress address;
  Map<String, Map<String, TimeOfDay>> opening;
  StoreStatus status;

  Stores.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc.get('name') as String;
    image = doc.get('image') as String;
    phone = doc.get('phone') as String;
    address = UserAddress.fromMap(doc.get('address') as Map<String, dynamic>);
    opening = (doc.get('opening') as Map<String, dynamic>).map((key, value) {
      final timeString = value as String;
      if (timeString != null && timeString.isNotEmpty) {
        final splited = timeString.split(RegExp(r'[:-]'));
        return MapEntry(key, {
          'from': TimeOfDay(
              hour: int.parse(splited[0]), minute: int.parse(splited[1])),
          'to': TimeOfDay(
              hour: int.parse(splited[2]), minute: int.parse(splited[3]))
        });
      } else {
        return MapEntry(key, null);
      }
    });
    updateStatus();
  }

  String get addressText =>
      '${address.street}, ${address.district}, '
          ' ${address.city}/${address.province} - ${address.country}';

  String get openingText {
    return 'Seg - Sex: ${formatedPeriod(opening['mondayfriday'])}\n'
        'Sáb: ${formatedPeriod(opening['saturday'])}\n'
        'Dom: ${formatedPeriod(opening['sunday'])}';
  }

  String get cleanPhone => phone.replaceAll(RegExp(r'[^\d]'), '');

  String formatedPeriod(Map<String, TimeOfDay> period) {
    if (period == null) {
      return 'Fechada';
    }
    return '${period['from'].formatedTime()} - ${period['to'].formatedTime()}';
  }

  void updateStatus() {
    final weekDay = DateTime.now().weekday;

    Map<String, TimeOfDay> period;
    if (weekDay >= 1 && weekDay <= 5) {
      period = opening['mondayfriday'];
    } else if (weekDay == 6) {
      period = opening['saturday'];
    } else {
      period = opening['sunday'];
    }

    final now = TimeOfDay.now();

    if (period == null) {
      status = StoreStatus.closed;
    } else if ((period['from'].toMinutes() < now.toMinutes()) &&
        (period['to'].toMinutes() - 15 > now.toMinutes())) {
      status = StoreStatus.open;
    } else if ((period['from'].toMinutes() < now.toMinutes()) &&
        (period['to'].toMinutes() > now.toMinutes())) {
      status = StoreStatus.closing;
    } else {
      status = StoreStatus.closed;
    }
  }

  String get statusText {
    switch (status) {
      case StoreStatus.open:
        return ' Aberta';
        break;
      case StoreStatus.closing:
        return ' A fechar';
        break;
      case StoreStatus.closed:
        return ' Fechada';
        break;
      default:
        return '';
        break;
    }
  }
}