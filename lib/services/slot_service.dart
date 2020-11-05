import 'package:etutor/data/slot_model.dart';
import 'package:etutor/services/http_service.dart';
import 'package:flutter/material.dart';

abstract class SlotService {
  static List<DayItem> currentListDayItem;
  static Map<String, Map<String, String>> selectedClasshour;
  static String local = 'http://10.0.0.2:8080/ETutor/api';
  static void toggleSlot(String slotId, DateTime date) {
    if (selectedClasshour == null) {
      selectedClasshour = Map();
    }
    slotId = slotId.toUpperCase();
    if (selectedClasshour.containsKey(slotId)) {
      if (selectedClasshour[slotId]
          .containsKey('${date.toString().split(' ').join('T')}Z')) {
        selectedClasshour[slotId]
            .remove('${date.toString().split(' ').join('T')}Z');
        if (selectedClasshour[slotId].isEmpty) {
          selectedClasshour.remove(slotId);
          if (selectedClasshour.isEmpty) {
            selectedClasshour = null;
          }
        }
      } else {
        selectedClasshour[slotId].addAll({
          '${date.toString().split(' ').join('T')}Z':
              '${date.millisecondsSinceEpoch}'
        });
      }
    } else {
      selectedClasshour[slotId] = Map();
      selectedClasshour[slotId].addAll({
        '${date.toString().split(' ').join('T')}Z':
            '${date.millisecondsSinceEpoch}'
      });
    }
  }

  static Future<List<DayItem>> getSlotList(BuildContext context) async {
    return HttpService.getWithAuth(
      context,
      '$local/slot',
    ).then((response) {
      currentListDayItem =
          response.map<DayItem>((e) => DayItem.fromJson(e)).toList();
      return currentListDayItem;
    });
  }
}
