import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hippocamp/providers/date_picker_provider.dart';
import 'package:hippocamp/providers/ui_state_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/styles/icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DatePickerTime extends ConsumerWidget {
  const DatePickerTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool allDaySelected = ref.watch(
        uiStateProvider.select((value) => value.isAllDaySelectedInTimePicker));
    if (allDaySelected) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
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
            onSelected: null, //onTapTimeSelection,
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
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Dalle"),
        SizedBox(width: 4),
        InkWell(
          onTap: null, //onTapTimeFrom,
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
            child: Consumer(
              builder: (context, ref, child) {
                DateTime? timeFrom = ref.watch(
                    datePickerProvider.select((value) => value.timeFrom));
                return Text(
                  timeFrom.toString(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(width: 4),
        Text("alle"),
        SizedBox(width: 4),
        InkWell(
          onTap: null, //onTapTimeTo,
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
            child: Consumer(
              builder: (context, ref, child) {
                DateTime? timeTo = ref
                    .watch(datePickerProvider.select((value) => value.timeTo));
                return Text(
                  timeTo.toString(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                );
              },
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
