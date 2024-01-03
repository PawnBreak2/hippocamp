import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/helpers/extensions/int_extensions.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/responses/posts_response_model.dart';
import 'package:hippocapp/providers/posts_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/widgets/components/timeline/time_event_item.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CalendarPage extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const CalendarPage({
    required this.scrollController,
  });

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  bool _loading = true;

  final EventController _eventController = EventController();
  DateTime? _daySelected;
  DateTime _dateTimeSelected = DateTime.now();

  Map<DateTime, List<Post>> postsPerCalendar = {};

  @override
  void initState() {
    super.initState();

    addCalendarPosts();
  }

  Future<void> addCalendarPosts() async {
    final postsProviderNotifier = ref.read(postListProvider.notifier);

    final resp = await postsProviderNotifier.getCalendarPosts(
      date:
          "${_dateTimeSelected.year}-${_dateTimeSelected.month.toString().padLeft(2, "0")}",
    );

    if (resp != null) {
      postsPerCalendar[_dateTimeSelected] = resp;

      Future.delayed(Duration(microseconds: 1)).whenComplete(
        () {
          for (var i in resp) {
            final event = CalendarEventData(
              date: i.dateTimeFromString,
              color: i.category.domainBackgroundColorHex.colorFromHex,
              endDate: i.dateTimeFromString,
              startTime: i.dateTimeFromString,
              endTime: i.dateTimeFromString,
              event: i.description,
              title: i.title,
            );
            _eventController.add(event);
          }
        },
      );
    }

    _loading = false;
    setState(() {});
  }

  int lengthCalendars(List es) {
    if (_daySelected != null) return es.isEmpty ? 0 : 1;

    return es.length > 3 ? 3 : es.length;
  }

  List<Post> get postsCalendarPerDay {
    final r = postsPerCalendar[_dateTimeSelected]
        ?.where((e) => e.dateTimeFromString.day == _daySelected?.day);

    if (r == null || r.isEmpty) return [];

    return r.toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading)
      return Scaffold(
        backgroundColor: Color.fromRGBO(227, 218, 210, 1),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );

    final psPerDay = postsCalendarPerDay;

    return Scaffold(
      backgroundColor: CustomColors.primaryLightBlue,
      body: SingleChildScrollView(
        controller: widget.scrollController,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            // Calendar
            Container(
              height: _daySelected == null ? 88.h : 70.h,
              color: CustomColors.primaryLightBlue,
              child: MonthView(
                controller: _eventController,
                onPageChange: (d, _) {
                  _dateTimeSelected = d;
                  _daySelected = null;
                  addCalendarPosts();

                  setState(() {});
                },
                cellAspectRatio: _daySelected == null ? .432 : .564,
                onCellTap: (events, d) {
                  _daySelected = d;
                  setState(() {});
                },
                headerBuilder: (d) => Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(227, 218, 210, 1),
                    border: Border(
                      bottom: BorderSide(color: Colors.black26),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${d.month.monthFromInt} - ${d.year}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                weekDayBuilder: (i) => Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: Text(
                    (i + 1).dayFromInt.toUpperCase().substring(0, 3),
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                borderSize: 0,
                showBorder: false,
                cellBuilder: (d, es, isToday, isInMonth) => Container(
                  decoration: BoxDecoration(
                    color: isInMonth
                        ? CustomColors.primaryLightGreen
                        : CustomColors.primaryLightGreen.withOpacity(.5),
                    border: Border.all(
                      width: 2,
                      color: _daySelected == d
                          ? CustomColors.primaryRed
                          : Colors.transparent,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: isToday
                              ? CustomColors.primaryRed
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          d.day.toString(),
                          style: TextStyle(
                            color: isToday
                                ? Colors.white
                                : Colors.black.withOpacity(.5),
                            fontWeight:
                                isInMonth ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      for (var i = 0; i < lengthCalendars(es); i++)
                        Container(
                          decoration: BoxDecoration(
                            color: es[i].color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          margin: EdgeInsets.only(left: 2, right: 2, top: 2),
                          padding: EdgeInsets.all(4),
                          child: Text(
                            es[i].title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      if (es.length > 3)
                        Text(
                          "...",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Events
            if (_daySelected != null)
              Container(
                child: psPerDay.isEmpty
                    ? Column(
                        children: [
                          Text(
                            "Non sono presenti post",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, i) => TimeEventItem(
                          post: psPerDay[i],
                        ),
                        itemCount: psPerDay.length,
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
