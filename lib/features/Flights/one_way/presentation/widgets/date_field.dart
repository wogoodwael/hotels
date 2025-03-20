import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../search_flight/presentation/search_flight_taps.dart';

class DateField extends StatefulWidget {
  final String title;
  final String date;
  final bool showReturn;
  final VoidCallback? onAddReturn;

  const DateField({
    super.key,
    required this.title,
    required this.date,
    this.showReturn = true,
    this.onAddReturn,
  });

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  late TextEditingController _dateController;
  late TextEditingController _returnDateController;
  bool _isReturnAdded = false;
  final _flightBox = Hive.box('flightData');

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: widget.date);
    _returnDateController = TextEditingController();

    final savedDepartureDate = _flightBox.get('departureDate');
    final savedReturnDate = _flightBox.get('returnDate');

    if (savedDepartureDate != null) {
      _dateController.text = _formatDate(DateTime.parse(savedDepartureDate));
    }
    if (savedReturnDate != null) {
      _returnDateController.text = _formatDate(DateTime.parse(savedReturnDate));
      _isReturnAdded = true;
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate({bool isReturn = false}) async {
    final DateTime now = DateTime.now();
    final TextEditingController controller =
        isReturn ? _returnDateController : _dateController;
    final DateTime parsedDate =
        controller.text.isEmpty ? now : _parseDate(controller.text);

    final DateTime initialDate = parsedDate.isBefore(now) ? now : parsedDate;

    final DateTime? picked = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DatePickerPage(
          selectedDate: initialDate,
          isReturn: isReturn,
        ),
      ),
    );

    if (picked != null) {
      setState(() {
        controller.text = _formatDate(picked);

        if (isReturn) {
          _flightBox.put('returnDate', picked.toIso8601String());
        } else {
          _flightBox.put('departureDate', picked.toIso8601String());
        }
      });
    }
  }

  DateTime _parseDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      final parts = date.split(' ');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = _getMonthNumber(parts[1].replaceAll(',', ''));
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }

      return DateTime.now();
    }
  }

  int _getMonthNumber(String month) {
    const months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12
    };
    return months[month] ?? 1;
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString();
    final month = _getMonthName(date.month);
    final year = date.year.toString();
    return '$day $month, $year';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: .9 * MediaQuery.of(context).size.width,
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Row(
              children: [
                SizedBox(
                  width: .45 * MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _selectDate(isReturn: false),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 5),
                      labelText:
                          _isReturnAdded ? 'Departure Date' : widget.title,
                      hintText: widget.date,
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                widget.showReturn && !_isReturnAdded
                    ? const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.teal,
                      )
                    : const SizedBox(),
                widget.showReturn && !_isReturnAdded
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _isReturnAdded = true;
                          });
                          _selectDate(isReturn: true);
                        },
                        child: Text(
                          _returnDateController.text.isNotEmpty
                              ? _returnDateController.text
                              : "Add return ? ".tr,
                          style: const TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        ),
                      )
                    : const SizedBox(),
                widget.showReturn && !_isReturnAdded
                    ? const Icon(
                        Icons.add_circle_rounded,
                        color: Colors.teal,
                      )
                    : const SizedBox()
              ],
            ),
            if (_isReturnAdded)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: .4 * MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _returnDateController,
                        readOnly: true,
                        onTap: () => _selectDate(isReturn: true),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5),
                          labelText: 'Return Date',
                          hintText: 'Select return date',
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DatePickerPage extends StatelessWidget {
  final DateTime selectedDate;
  final bool isReturn;

  const DatePickerPage(
      {super.key, required this.selectedDate, required this.isReturn});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title:  Text('Select Date'.tr),
        backgroundColor: Colors.teal,
      ),
      body: CalendarDatePicker(
        initialDate: selectedDate.isBefore(now) ? now : selectedDate,
        firstDate: now,
        lastDate: DateTime.now().add(const Duration(days: 365)),
        onDateChanged: (DateTime date) {
          if (isReturn) {
            Navigator.pop(context, date);
          } else {
            Navigator.pop(context, date);
          }
        },
      ),
    );
  }
}
