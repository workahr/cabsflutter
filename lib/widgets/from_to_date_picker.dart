import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';

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
  late TextEditingController _fromDateController;
  late TextEditingController _toDateController;

  Future<void> _selectFromDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: DateTime.now(),
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

    print(selectedDate);

    if (selectedDate != null) {
      setState(() {
        _fromDateController.text =
            DateFormat('dd-MM-yyyy').format(selectedDate);
        _fromDate = selectedDate;
        _toDate = null;
        _toDateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
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
        _toDateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
        widget.onDatesSelected(_fromDate, _toDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fromDate = DateTime.now();
    _toDate = _fromDate; // or _fromDate!.add(const Duration(days: 1));

    _fromDateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(_fromDate!),
    );

    _toDateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(_toDate!),
    );
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
              labelStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
              suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
            // controller: TextEditingController(
            //   text: _fromDate != null
            //       ? "${_fromDate!.toLocal()}".split(' ')[0]
            //       : '',
            // ),
            controller: _fromDateController,
            // controller: TextEditingController(
            //   text: _fromDate != null
            //       ? DateFormat('dd-MM-yyyy').format(_fromDate!)
            //       : '',
            // ),
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
              labelStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
              suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
            // controller: TextEditingController(
            //   text:
            //       _toDate != null ? "${_toDate!.toLocal()}".split(' ')[0] : '',
            // ),
            controller: _toDateController,
            // controller: TextEditingController(
            //   text: _toDate != null
            //       ? DateFormat('dd-MM-yyyy').format(_toDate!)
            //       : '',
            // ),
          ),
        ),
      ],
    );
  }
}
