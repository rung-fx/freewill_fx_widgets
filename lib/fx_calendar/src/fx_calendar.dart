import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FXCustomCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final Color? selectedColor;
  final Color? rangeSelectedColor;
  final String? confirmText;

  const FXCustomCalendar({
    Key? key,
    required this.selectedDate,
    this.selectedColor,
    this.rangeSelectedColor,
    this.confirmText,
  }) : super(key: key);

  @override
  State<FXCustomCalendar> createState() => _FXCustomCalendarState();
}

class _FXCustomCalendarState extends State<FXCustomCalendar> {
  final DateRangePickerController _controller = DateRangePickerController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _prepareData();
  }

  _prepareData() {
    _selectedDate = widget.selectedDate;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      contentPadding: const EdgeInsets.all(marginX2),
      buttonPadding: EdgeInsets.zero,
      content: SizedBox(
        height: Get.height / 2,
        width: Get.width,
        child: Column(
          children: [
            Expanded(
              child: _calendar(),
            ),
            _submitButton(),
          ],
        ),
      ),
    );
  }

  _calendar() {
    return SfDateRangePicker(
      controller: _controller,
      view: DateRangePickerView.month,
      headerHeight: 50.0,
      headerStyle: const DateRangePickerHeaderStyle(
        textAlign: TextAlign.center,
        textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          fontFamily: 'SukhumvitSet',
        ),
      ),
      rangeTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'SukhumvitSet',
      ),
      monthViewSettings: const DateRangePickerMonthViewSettings(
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'SukhumvitSet',
          ),
        ),
      ),
      monthCellStyle: const DateRangePickerMonthCellStyle(
        textStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'SukhumvitSet',
        ),
        todayTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'SukhumvitSet',
        ),
      ),
      yearCellStyle: const DateRangePickerYearCellStyle(
        textStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'SukhumvitSet',
        ),
        disabledDatesTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'SukhumvitSet',
        ),
        todayTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'SukhumvitSet',
        ),
        leadingDatesTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'SukhumvitSet',
        ),
      ),
      selectionTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        fontFamily: 'SukhumvitSet',
      ),
      onSelectionChanged: selectionChanged,
      todayHighlightColor: widget.selectedColor,
      selectionColor: widget.selectedColor,
      startRangeSelectionColor: widget.selectedColor,
      endRangeSelectionColor: widget.selectedColor,
      rangeSelectionColor: widget.rangeSelectedColor,
      selectionMode: DateRangePickerSelectionMode.single,
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    DateTime date = args.value;
    _selectedDate = DateTime(
      date.year,
      date.month,
      date.day,
    );

    setState(() {});
  }

  _submitButton() {
    return FXSubmitButton(
      buttonHeight: 40.0,
      borderRadius: 20.0,
      buttonPadding: EdgeInsets.zero,
      onTap: () {
        Get.back(result: _selectedDate);
      },
      title: widget.confirmText ?? 'ยืนยัน',
    );
  }
}
