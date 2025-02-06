import 'package:flutter/material.dart';

class FromAndToDatePickerField extends StatefulWidget {
  final Function(DateTime?, DateTime?) onDatesSelected;

  const FromAndToDatePickerField({
    super.key,
    required this.onDatesSelected,
  });

  @override
  State<FromAndToDatePickerField> createState() =>
      _FromAndToDatePickerFieldState();
}

class _FromAndToDatePickerFieldState extends State<FromAndToDatePickerField> {
  DateTime? _fromDate;
  DateTime? _toDate;

  Future<void> _selectFromDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _fromDate = selectedDate;
        _toDate = null;
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    if (_fromDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select the From Date first")),
      );
      return;
    }

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _toDate ?? _fromDate!.add(const Duration(days: 1)),
      firstDate: _fromDate!.add(const Duration(days: 1)),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _toDate = selectedDate;
        widget.onDatesSelected(_fromDate, _toDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // From Date Picker
        Expanded(
          child: TextField(
            readOnly: true,
            onTap: () => _selectFromDate(context),
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(
                color: Colors.black,
              ),
              labelText: "From Date",
              suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
            ),
            controller: TextEditingController(
              text: _fromDate != null
                  ? "${_fromDate!.toLocal()}".split(' ')[0]
                  : '',
            ),
          ),
        ),
        const SizedBox(width: 16),

        // To Date Picker
        Expanded(
          child: TextField(
            readOnly: true,
            onTap: () => _selectToDate(context),
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(
                color: Colors.black,
              ),
              labelText: "To Date",
              suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
            ),
            controller: TextEditingController(
              text:
                  _toDate != null ? "${_toDate!.toLocal()}".split(' ')[0] : '',
            ),
          ),
        ),
      ],
    );
  }
}
