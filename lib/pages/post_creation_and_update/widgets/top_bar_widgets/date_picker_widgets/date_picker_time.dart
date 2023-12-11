import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/helpers/extensions/datetime_extension.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/providers/date_picker_provider.dart';
import 'package:hippocamp/providers/post_creation_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum TimeSelection { from, to }

class DatePickerTime extends ConsumerWidget {
  const DatePickerTime({super.key});

  bool isSelectedTimeValid(WidgetRef ref) {
    TimeOfDay timeFrom = ref
        .watch(postCreationProvider.select((value) => value.from))
        .timeOfDayFromString;
    TimeOfDay timeTo = ref
        .watch(postCreationProvider.select((value) => value.to))
        .timeOfDayFromString;

    DateTime timeFromInDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        timeFrom.hour,
        timeFrom.minute);
    DateTime timeToInDateTime = DateTime(DateTime.now().year,
        DateTime.now().month, DateTime.now().day, timeTo.hour, timeTo.minute);

    if (timeToInDateTime.isBefore(timeFromInDateTime) ||
        timeFromInDateTime.isAfter(timeToInDateTime)) {
      return false;
    } else {
      return true;
    }
  }

  void setTimeOfDayForPost(
      TimeSelection timeSelection, BuildContext context, WidgetRef ref) {
    Navigator.of(context).push(
      showPicker(
        themeData: Theme.of(context).copyWith(
          dialogTheme: const DialogTheme(
            surfaceTintColor: CustomColors.lightBackGroundColor,
          ),
        ),
        height: 40.h,
        accentColor: CustomColors.primaryRed,
        is24HrFormat: true,
        context: context,
        value: timeSelection == TimeSelection.to
            ? Time.fromTimeOfDay(
                ref
                    .watch(postCreationProvider.select((value) => value.to))
                    .timeOfDayFromString,
                0)
            : Time.fromTimeOfDay(
                ref
                    .watch(postCreationProvider.select((value) => value.from))
                    .timeOfDayFromString,
                0),
        sunrise: const TimeOfDay(hour: 6, minute: 0),
        // optional
        sunset: const TimeOfDay(hour: 18, minute: 0),
        // optional
        duskSpanInMinutes: 120,
        // optional
        onChange: (time) {
          // if the time is not valid (e.g. from 12:00 to 11:00) then the other value in provider (and therefore the UI) is set to the last time set in either field.
          // Eg. if the user sets 12:00 in the "from" field and then 11:00 in the "to" field, the "from" field will be set to 11:00

          if (timeSelection == TimeSelection.to) {
            ref
                .read(postCreationProvider.notifier)
                .setTimeTo(time.timeToString);
            if (!isSelectedTimeValid(ref)) {
              ref
                  .read(postCreationProvider.notifier)
                  .setTimeFrom(time.timeToString);
            }
          } else {
            ref
                .read(postCreationProvider.notifier)
                .setTimeFrom(time.timeToString);

            if (!isSelectedTimeValid(ref)) {
              ref
                  .read(postCreationProvider.notifier)
                  .setTimeTo(time.timeToString);
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(
          Symbols.line_start_diamond,
          size: 26,
          color: CustomColors.grey66,
        ),
        InkWell(
          // onTapTimeFrom
          onTap: () {
            setTimeOfDayForPost(TimeSelection.from, context, ref);
          },

          child: Container(
            height: 28.sp,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CustomColors.lightBackGroundColor,
              border: Border.all(
                color: const Color.fromRGBO(51, 51, 51, .3),
              ),
            ),
            child: Consumer(
              builder: (context, ref, child) {
                String timeFrom = ref
                    .watch(postCreationProvider.select((value) => value.from));

                return Text(
                  timeFrom,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                );
              },
            ),
          ),
        ),
        const Icon(
          Symbols.check_indeterminate_small,
          size: 26,
          color: CustomColors.grey66,
        ),
        InkWell(
          onTap: () {
            setTimeOfDayForPost(TimeSelection.to, context, ref);
          }, //onTapTimeTo,
          child: Container(
            height: 28.sp,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CustomColors.lightBackGroundColor,
              border: Border.all(
                color: const Color.fromRGBO(51, 51, 51, .3),
              ),
            ),
            child: Consumer(
              builder: (context, ref, child) {
                String timeTo =
                    ref.watch(postCreationProvider.select((value) => value.to));
                return Text(
                  timeTo,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                );
              },
            ),
          ),
        ),
        Transform.flip(
          flipX: true,
          child: const Icon(
            Symbols.line_start_diamond,
            size: 26,
            color: CustomColors.grey66,
          ),
        ),
        SizedBox(width: 2.w),
      ],
    );
  }
}
