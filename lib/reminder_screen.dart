import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  String _selectedDay = 'Senin';
  String _selectedActivity = 'Kuliah';
  TimeOfDay _selectedTime = const TimeOfDay(hour: 00, minute: 00);
  DateTime now = DateTime.now();
//Show timepicker
  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _selectedTime = value!;
      });
    });
  }

//schedule remainder
  void _scheduleReminder() {
    DateTime now = DateTime.now();
    DateTime selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final difference = selectedDateTime.difference(now);

    Future.delayed(difference, () {
      final player = AudioCache();
      player.play('wind-chimes-bells-115747.mp3');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('CollegeReminder'),
          content: Text(
              'Time for ${_selectedActivity.toLowerCase()} on $_selectedDay at ${_selectedTime.format(context)}'),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(
          'CollegeReminder App',
          style: TextStyle(fontSize: 20),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[100],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  // Day DropDown
                  Container(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 80, right: 80),
                    decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(16)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 18,
                          ),
                          dropdownColor: Colors.grey[700],
                          value: _selectedDay,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedDay = newValue.toString();
                            });
                          },
                          items: <String>[
                            'Senin',
                            'Selasa',
                            'Rabu',
                            'Kamis',
                            'Jumat',
                            'Sabtu',
                            'Minggu',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: Colors.grey[100], fontSize: 20),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Divider(
                      indent: 15,
                      endIndent: 15,
                      thickness: 0.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  //User Activity DropDown
                  Container(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 77, right: 77),
                    decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(16)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 18,
                        ),
                        dropdownColor: Colors.grey[700],
                        value: _selectedActivity,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedActivity = newValue.toString();
                          });
                        },
                        items: <String>[
                          'Kuliah',
                          'Deadline Tugas',
                          'Liburan',
                          'Tanggal Merah',
                          'Kerja',
                          'Mabar',
                          'Jogging',
                          'Me Time',
                          'Istirahat',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Colors.grey[100], fontSize: 20),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 0.0,
                  color: Colors.grey[700],
                ),
              ),
              //ShowTimePicker Widget, When the user clicks the alarm icons it will show the clock widget for set the time
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 46.0),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey[700]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey[600]),
                          child: Text(
                            _selectedTime.format(context).toString(),
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[100]),
                          )),
                      Column(
                        children: [
                          Text(
                            'Click',
                            style: TextStyle(
                                color: Colors.blue[100],
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          GestureDetector(
                            onTap: _showTimePicker,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.alarm_add_rounded,
                                size: 22,
                                color: Colors.blue[200],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 0.0,
                  color: Colors.grey[700],
                ),
              ),
              // ScheduleReminder
              GestureDetector(
                onTap: _scheduleReminder,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(14)),
                  child: const Text(
                    'Set Reminder',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
