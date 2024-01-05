import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hippocapp/helpers/extensions/int_extensions.dart';
import 'package:hippocapp/pages/post_creation_and_update/widgets/top_bar_widgets/date_picker_widgets/date_picker_time.dart';
import 'package:hippocapp/providers/services/date_picker_provider.dart';
import 'package:hippocapp/providers/posts_management/creation/post_creation_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/styles/icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DateSelectionSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        InkWell(
          onTap: () async {
            final selectedDate = ref
                .read(datePickerProvider.select((value) => value.selectedDate));
            final selectedDateTimeFromPicker = await showDatePicker(
              context: context,
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      surfaceTint: CustomColors.white243,
                      primary: CustomColors.primaryRed,
                      onPrimary: Colors.white,
                      surface: CustomColors.white243,
                      onSurface: CustomColors.darkGrey,
                    ),
                    dialogBackgroundColor: CustomColors.lightBackGroundColor,
                  ),
                  child: child!,
                );
              },
              locale: const Locale("it", "IT"),
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2050),
            );
            ref
                .read(datePickerProvider.notifier)
                .setSelectedDate(selectedDateTimeFromPicker ?? selectedDate);
          },
          child: Container(
            height: 28.sp,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CustomColors.lightBackGroundColor,
              border: Border.all(
                color: Color.fromRGBO(51, 51, 51, .3),
              ),
            ),
            child: Consumer(
              builder: (context, ref, child) {
                final selectedDateTime = ref.watch(
                    datePickerProvider.select((value) => value.selectedDate));

                return Text(
                  "${selectedDateTime.day} ${selectedDateTime.month.monthFromInt.substring(0, 3).toLowerCase()} ${selectedDateTime.year}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(width: 8),

        // All day / Time
        Expanded(
          flex: 2,
          child: Consumer(
            builder: (context, ref, child) {
              bool isWholeDay = ref
                  .watch(postCreationProvider.select((value) => value.allDay));
              if (isWholeDay) {
                return const FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.scaleDown,
                    child: Text('Tutto il giorno'));
              } else
                return FittedBox(
                    alignment: Alignment.centerLeft, child: DatePickerTime());
            },
          ),
        ),
        Container(
          width: 11.w,
          height: 11.w,
          child: SpeedDial(
            buttonSize: Size(8.w, 8.w),
            activeBackgroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0,
            overlayColor: Colors.black12,
            direction: SpeedDialDirection.down,
            children: [
              SpeedDialChild(
                shape: const CircleBorder(),
                child: Icon(
                  CustomMaterialIcons.allDay,
                  size: 20,
                  color: Colors.white,
                ),
                backgroundColor: CustomColors.primaryRed,
                label: "Tutto il giorno",
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: CustomColors.darkGrey,
                ),
                onTap: () {
                  ref.read(postCreationProvider.notifier).setAllDay(true);
                },
              ),
              SpeedDialChild(
                shape: CircleBorder(),
                child: Icon(
                  CustomMaterialIcons.hoursInterval,
                  size: 20,
                  color: Colors.white,
                ),
                backgroundColor: CustomColors.primaryRed,
                label: "Intervallo orario",
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: CustomColors.darkGrey,
                ),
                onTap: () {
                  ref.read(postCreationProvider.notifier).setAllDay(false);
                },
              ),
            ],
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(pi / 2),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 30,
                color: CustomColors.grey66,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
