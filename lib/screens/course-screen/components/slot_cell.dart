import 'package:etutor/data/slot_model.dart';
import 'package:etutor/services/slot_service.dart';
import 'package:flutter/material.dart';

class SlotCell extends StatefulWidget {
  final DateTime date;
  final SlotItem slot;

  SlotCell({
    Key key,
    @required this.date,
    @required this.slot,
  }) : super(key: key);

  _SlotCellState createState() => _SlotCellState(date, slot);
}

class _SlotCellState extends State<SlotCell> {
  final DateTime _date;
  final SlotItem _slot;

  bool disabled;
  bool selected;

  _SlotCellState(this._date, this._slot);

  @override
  void initState() {
    disabled = _date.isBefore(DateTime.now());
    selected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!disabled) {
          setState(() {
            selected = !selected;
            SlotService.toggleSlot(_slot.id.value, _date);
          });
        }
      },
      child: Stack(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: disabled ? 16 : 3),
                            child: Center(
                              child: Text(
                                _slot.name.value ?? 'SOMEDAY_00',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: disabled ? Colors.grey : (selected ? Colors.red : Colors.black),
                                  fontSize: 11,
                                  fontWeight: selected ? FontWeight.w500 : FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                          disabled ?
                          Container() :
                          Center(
                            child: Text(
                              _slot.timeInSlot.value ?? '(0:0 - 0:0)',
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
          ),
          selected ?
          Positioned(
            bottom: 1,
            left: 0,
            width: 109,
            child: Container(
              height: 59,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 1,
                ),
                color: Colors.red.withOpacity(0.15),
              ),
            ),
          ) :
          Container(),
        ],
      ),
    );
  }
}