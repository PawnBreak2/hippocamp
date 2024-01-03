import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/widgets/forms/primary_amount_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrimaryTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String hintText;
  final Color? backgroundColor;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool amountFormat;
  final double borderRadius;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final TextInputAction action;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChange;
  final int maxLines;
  final int maxLength;
  final MaxLengthEnforcement maxLengthEnforcement;
  const PrimaryTextFormField({
    this.focusNode,
    required this.controller,
    required this.hintText,
    this.backgroundColor = CustomColors.lightBackGroundColor,
    this.validator,
    this.borderRadius = 12,
    this.height,
    this.width,
    this.textAlign = TextAlign.left,
    this.obscureText = false,
    this.enabled = true,
    this.amountFormat = false,
    this.padding,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.inputFormatters,
    this.textInputType = TextInputType.text,
    this.action = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.onChange,
    this.maxLines = 1,
    this.maxLength = 50,
    this.maxLengthEnforcement =
        MaxLengthEnforcement.truncateAfterCompositionEnds,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (_, setState) => FocusScope(
        child: Focus(
          child: Stack(
            children: [
              TextFormField(
                focusNode: focusNode,
                controller: controller,
                textInputAction: action,
                obscureText: obscureText,
                validator: validator,
                enabled: enabled,
                textAlign: textAlign,
                keyboardType: textInputType,
                maxLines: maxLines,
                maxLength: maxLength,
                maxLengthEnforcement: maxLengthEnforcement,
                onChanged: onChange,
                inputFormatters: amountFormat
                    ? TextAmountFormat.formatAmountValues()
                    : inputFormatters,
                textCapitalization: textCapitalization,
                decoration: InputDecoration(
                  counterText: '',
                  fillColor: (focusNode?.hasFocus ?? false)
                      ? Colors.white
                      : (backgroundColor ?? CustomColors.primaryLightGreen),
                  filled: true,
                  hintText: hintText,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  contentPadding:
                      padding ?? EdgeInsets.symmetric(horizontal: 12),
                  hintStyle: TextStyle(color: Colors.grey),
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(52, 52, 52, .3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: CustomColors.primaryRed),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
