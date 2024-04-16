import 'dart:convert';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../model/model_event_list.dart';
import '../widgets/common_colour.dart';
import '../widgets/event.dart';

class EventCalendarScreen extends StatefulWidget {
  static String route = "/EventCalendarScreen";
  const EventCalendarScreen({Key? key}) : super(key: key);

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  final Repositories repositories = Repositories();
  ModelEventsList modelEventsList = ModelEventsList();

  Map<String, List<EventData>> mySelectedEvents = {};

  getEvents() {
    repositories.getApi(url: ApiUrls.getEventsUrl).then((value) {
      modelEventsList = ModelEventsList.fromJson(jsonDecode(value));
      loadAllEvents();
      setState(() {});
    });
  }

  loadAllEvents() {
    if (modelEventsList.data == null) return;
    mySelectedEvents.clear();
    for (var element in modelEventsList.data!) {
      mySelectedEvents[element.date.toString()] ??= [];
      mySelectedEvents[element.date.toString()]!.add(element);
    }
    for (var element in mySelectedEvents.entries) {
      Set<String> ids = {};
      for (var element1 in element.value) {
        if (ids.contains(element1.id.toString())) {
          element1.remove = true;
        } else {
          ids.add(element1.id.toString());
        }
      }
      element.value.removeWhere((element) => element.remove);
    }
  }

  addEvent({
    required String title,
    required String description,
    required String date,
  }) {
    final map = {
      'title': title,
      'description': description,
      'date': date,
    };
    repositories.postApi(url: ApiUrls.addEventUrl, mapData: map, context: context).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        getEvents();
        Get.back();
      }
    });
  }

  deleteEvent({
    required String id,
  }) {
    final map = {
      'event_id': id,
    };
    repositories.postApi(url: ApiUrls.deleteEventUrl, mapData: map, context: context).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        getEvents();
        setState(() {});
      }
    });
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    getEvents();
    _selectedDate = _focusedDay;
  }

  List<EventData> _listOfDayEvents(DateTime dateTime) {
    if (kDebugMode) {
      print(mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]);
    }
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showAddEventDialog() async {
    final titleController = TextEditingController();
    final descpController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add New Event'.tr,
                    textAlign: TextAlign.center,
                    style: titleStyle,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: titleController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please Enter Title".tr;
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    decoration:  InputDecoration(
                      labelText: 'Title'.tr,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      border: InputBorder.none,
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: descpController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textCapitalization: TextCapitalization.words,
                    maxLines: null,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please Enter Description".tr;
                      }
                      return null;
                    },
                    decoration:  InputDecoration(
                      labelText: 'Description'.tr,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      border: InputBorder.none,
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel'.tr,
                            style: titleStyle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: TextButton(
                          child: Text(
                            'Save'.tr,
                            style: titleStyle,
                          ),
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;

                            addEvent(
                              date: DateFormat("yyyy-MM-dd").format(_selectedDate!),
                              description: descpController.text.trim(),
                              title: titleController.text.trim(),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEBF1F4),
        title: Text(
          AppStrings.calendar.tr,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                AppStrings.createEvent.tr,
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
              calendarFormat: _calendarFormat,
              calendarStyle: const CalendarStyle(outsideDaysVisible: false),
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDate, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
              // eventLoader: _listOfDayEvents,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                AppStrings.myEvent.tr,
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            ..._listOfDayEvents(_selectedDate!).map(
              (myEvents) => Slidable(
                key: ValueKey(myEvents.id.toString()),
                endActionPane: ActionPane(
                  extentRatio: .26,
                  motion: const ScrollMotion(),
                  children: [
                    // const SizedBox(width: 20,),
                    TextButton(
                      onPressed: () {
                        deleteEvent(id: myEvents.id.toString());
                      },
                      child: Text(
                      AppStrings.delete.tr,
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: AppTheme.buttonColor),
                      ),
                    )
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffDCDCDC)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppTheme.buttonColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate!.day.toString(),
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                          Text(
                            DateFormat("MMM").format(_selectedDate!),
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    title: Padding(
                      padding:  const EdgeInsets.only(bottom: 4),
                      child: Text(AppStrings.eventTitle.tr +myEvents.title!),
                    ),
                    subtitle: Text(AppStrings.description.tr +myEvents.description!),
                  ),
                ),
              ),
            ),
            if (_listOfDayEvents(_selectedDate!).isEmpty)
               Center(
                heightFactor: 4,
                child: Text(AppStrings.noEvent.tr),
              ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label:  Text(AppStrings.addEvent.tr),
      ),
    );
  }
}
