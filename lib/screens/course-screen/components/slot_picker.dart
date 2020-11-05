import 'package:etutor/data/slot_model.dart';
import 'package:etutor/screens/course-screen/components/slot_cell.dart';
import 'package:etutor/services/slot_service.dart';
import 'package:flutter/material.dart';

class SlotPicker extends StatefulWidget {

  SlotPicker({Key key}) : super(key: key);

  _SlotPickerState createState() => _SlotPickerState();
}

class _SlotPickerState extends State<SlotPicker> {
  Future<List<DayItem>> listDayItemFuture;

  DateTime firstMonday;
  DateTime currentMonday;
  DateTime currentWeekDay;
  Key _tableKey;

  @override
  void initState() {
    _tableKey = Key('__${DateTime.now().millisecondsSinceEpoch}_TABLE__');
    currentWeekDay = DateTime.now();
    firstMonday = currentWeekDay.add(Duration(days: DateTime.monday - currentWeekDay.weekday));
    currentMonday = firstMonday;
    listDayItemFuture = SlotService.currentListDayItem != null ?
      Future.delayed(Duration(seconds: 1), () => SlotService.currentListDayItem) :
      SlotService.getSlotList(context);
    SlotService.selectedClasshour = null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned(
                width: MediaQuery.of(context).size.width,
                top: 20,
                child: Center(
                  child: Text(
                    'Pick Your Available Slot',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                top: 60,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Week: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        TextSpan(
                          text: '${currentMonday.day}/${currentMonday.month} - ${currentMonday.add(Duration(days: 6)).day}/${currentMonday.add(Duration(days: 6)).month}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 52,
                left: 15,
                child: GestureDetector(
                  onTap: prevWeek,
                  child: Icon(
                    Icons.navigate_before,
                    size: 40,
                    color: currentMonday.add(Duration(days: -1)).isAfter(firstMonday) ? Colors.black : Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              Positioned(
                top: 52,
                right: 15,
                child: GestureDetector(
                  onTap: nextWeek,
                  child: Icon(Icons.navigate_next, size: 40),
                ),
              ),
              FutureBuilder(
                key: _tableKey,
                future: listDayItemFuture,
                builder: (BuildContext context, AsyncSnapshot<List<DayItem>> snapshot) {
                  if (snapshot.hasData) {
                    List<DayItem> listDayItem = snapshot.data;
                    return Container(
                      padding: const EdgeInsets.only(top: 100, bottom: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(color: Colors.grey.withOpacity(0.3), width: 0.5),
                                  right: BorderSide(color: Colors.grey.withOpacity(0.3), width: 0.5),
                                ),
                              ),
                              height: 1009,
                              child: ListView.builder(
                                addAutomaticKeepAlives: true,
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemCount: listDayItem.length,
                                itemBuilder: (_, index) {
                                  DateTime curDay = currentMonday.add(Duration(days: index));
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 110,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
                                          left: BorderSide(color: Colors.grey.withOpacity(0.3), width: 0.5),
                                          right: BorderSide(color: Colors.grey.withOpacity(0.3), width: 0.5),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              children: <Widget>[
                                                _buildDayItemHeader(listDayItem[index].dayInWeek.value, '${curDay.day}/${curDay.month}'),
                                                Column(
                                                  children: listDayItem[index].slotDTOList.value
                                                    .map((e) => SlotCell(
                                                      key: Key('__${index}_${e.name.value}__'),
                                                      date: curDay,
                                                      slot: e,
                                                    )).toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 400),
                    child: Container(
                      padding: const EdgeInsets.only(top: 100, bottom: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 250,
                              child: Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void nextWeek() {
    setState(() {
      currentWeekDay = currentWeekDay.add(Duration(days: 7));
      currentMonday = currentWeekDay.add(Duration(days: DateTime.monday - currentWeekDay.weekday));
      _tableKey = Key('__${DateTime.now().millisecondsSinceEpoch}_TABLE__');
    });
  }

  void prevWeek() {
    if (currentMonday.add(Duration(days: -1)).isAfter(firstMonday)) {
      setState(() {
        currentWeekDay = currentWeekDay.add(Duration(days: -7));
        currentMonday = currentWeekDay.add(Duration(days: DateTime.monday - currentWeekDay.weekday));
        _tableKey = Key('__${DateTime.now().millisecondsSinceEpoch}_TABLE__');
      });
    }
  }

  Widget _buildDayItemHeader(String dayInWeek, String date) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Center(
                        child: Text(
                          dayInWeek ?? 'SOMEDAY',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        date ?? '21/08',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}