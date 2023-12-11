import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hippocamp/pages/post_creation_and_update/widgets/top_bar_widgets/date_picker_widgets/date_picker_time.dart';
import 'package:hippocamp/providers/post_creation_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/styles/icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DateSelectionSection extends ConsumerWidget {
  final TextEditingController controllerDate;
  final void Function(String)? setChange;
  final bool allDaySelected;
  final void Function()? onTapDateSelection;
  final void Function(String)? onTapTimeSelection;
  final TextEditingController timeFrom;
  final void Function()? onTapTimeFrom;
  final TextEditingController timeTo;
  final void Function()? onTapTimeTo;

  const DateSelectionSection({
    required this.controllerDate,
    required this.setChange,
    required this.allDaySelected,
    required this.onTapDateSelection,
    required this.onTapTimeSelection,
    required this.timeFrom,
    required this.onTapTimeFrom,
    required this.timeTo,
    required this.onTapTimeTo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        InkWell(
          onTap: onTapDateSelection,
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
            child: Text(
              ///TODO: change this
              controllerDate.text,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),

        // All day / Time
        Expanded(
          flex: 2,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Consumer(
              builder: (context, ref, child) {
                bool isWholeDay = ref.watch(
                    postCreationProvider.select((value) => value.wholeDay));
                if (isWholeDay) {
                  return Text('Tutto il giorno');
                } else
                  return DatePickerTime();
              },
            ),
          ),
        ),
        Container(
          width: 11.w,
          height: 11.w,
          child: SpeedDial(
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
                  ref.read(postCreationProvider.notifier).setWholeDay(true);
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
                  ref.read(postCreationProvider.notifier).setWholeDay(false);
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

  Widget _timeWidget() {
    if (allDaySelected)
      return Row(
        children: [
          Text(
            "Tutto il giorno",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(width: 4),
          PopupMenuButton(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 32,
            ),
            onSelected: onTapTimeSelection,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: "0",
                child: Text("Tutto il giorno"),
              ),
              PopupMenuItem(
                value: "1",
                child: Text("Dalle ____ alle ____"),
              ),
            ],
          ),
        ],
      );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Dalle"),
        SizedBox(width: 4),
        InkWell(
          onTap: onTapTimeFrom,
          child: Container(
            height: 28.sp,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CustomColors.lightBackGroundColor,
              border: Border.all(
                color: Color.fromRGBO(51, 51, 51, .3),
              ),
            ),
            child: Text(
              timeFrom.text,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(width: 4),
        Text("alle"),
        SizedBox(width: 4),
        InkWell(
          onTap: onTapTimeTo,
          child: Container(
            height: 28.sp,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CustomColors.lightBackGroundColor,
              border: Border.all(
                color: Color.fromRGBO(51, 51, 51, .3),
              ),
            ),
            child: Text(
              timeTo.text,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        SpeedDial(
          activeBackgroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          overlayColor: Colors.black12,
          direction: SpeedDialDirection.down,
          children: [
            SpeedDialChild(
              shape: const CircleBorder(),
              child: Icon(
                CustomMaterialIcons.attributes,
                size: 20,
                color: Colors.white,
              ),
              backgroundColor: CustomColors.primaryRed,
              label: "Attributi del post",
              labelStyle: TextStyle(
                fontSize: 14,
                color: CustomColors.darkGrey,
              ),
              onTap: () {},
            ),
            SpeedDialChild(
              shape: CircleBorder(),
              child: Icon(
                Icons.save,
                size: 20,
                color: Colors.white,
              ),
              backgroundColor: CustomColors.primaryRed,
              label: "Salva come predefinito",
              labelStyle: TextStyle(
                fontSize: 14,
                color: CustomColors.darkGrey,
              ),
              onTap: () {},
            ),
          ],
          child: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ),

        /*PopupMenuButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
            size: 32,
          ),
          onSelected: onTapTimeSelection,
          itemBuilder: (_) => [
            PopupMenuItem(
              value: "0",
              child: Text("Tutto il giorno"),
            ),
            PopupMenuItem(
              value: "1",
              child: Text("Dalle ____ alle ____"),
            ),
          ],
        ),*/
      ],
    );
  }
}
