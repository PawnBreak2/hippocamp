import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/helpers/validators/validators_form_field.dart';
import 'package:hippocapp/providers/auth/auth_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/widgets/buttons/primary_button.dart';
import 'package:hippocapp/widgets/dialogs/flash_dialog.dart';
import 'package:hippocapp/widgets/forms/primary_text_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _controllerOldPassword = TextEditingController();
  bool _showPassword = false;
  final TextEditingController _controllerPassword = TextEditingController();
  bool _showPassword2 = false;
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  bool _showPassword3 = false;

  bool _loading = false;

  Widget _suffixIcon(int i, bool showPass) {
    return InkWell(
      onTap: () {
        switch (i) {
          case 0:
            _showPassword = !_showPassword;
            break;
          case 1:
            _showPassword2 = !_showPassword2;
            break;
          case 2:
            _showPassword3 = !_showPassword3;
            break;
        }
        setState(() {});
      },
      child: Icon(showPass ? Icons.visibility : Icons.visibility_off),
    );
  }

  Future<void> _continue() async {
    if (_loading) return;

    if ((_key.currentState?.validate() ?? false)) {
      final authProviderNotifier = ref.read(authProvider.notifier);
      _loading = true;
      setState(() {});

      final resp = await authProviderNotifier.changePassword(
        oldPass: _controllerOldPassword.text,
        confirmNewPass: _controllerConfirmPassword.text,
        newPass: _controllerConfirmPassword.text,
      );

      if (resp == null) {
        FlashCustomDialog.showPopUp(
          context: context,
          text: "Nuova password salvata",
          isError: false,
        );

        Navigator.pop(context);
      } else
        FlashCustomDialog.showPopUp(
          context: context,
          text: resp,
          isError: true,
        );
    }

    _loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pinkWhiteDeep,
      appBar: PreferredSize(
        preferredSize: Size(100.w, 60),
        child: SafeArea(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey, width: 1),
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: .1,
                  blurRadius: 10,
                  color: Colors.black.withOpacity(.1),
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 14),
                  Text(
                    "Cambio password",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                spreadRadius: .1,
                blurRadius: 10,
                color: Colors.black26,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: SvgPicture.asset(
                      "logo-hippocapp".svgPath,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                PrimaryTextFormField(
                  controller: _controllerOldPassword,
                  height: 70,
                  hintText: "vecchia password",
                  validator: ValidatorsFormField.validateEmptyText,
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: _suffixIcon(0, _showPassword),
                  obscureText: !_showPassword,
                  backgroundColor: Colors.white,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 8),
                PrimaryTextFormField(
                  controller: _controllerPassword,
                  height: 70,
                  hintText: "nuova password",
                  validator: ValidatorsFormField.validateStrongPassword,
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: _suffixIcon(1, _showPassword2),
                  obscureText: !_showPassword2,
                  backgroundColor: Colors.white,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 8),
                PrimaryTextFormField(
                  height: 70,
                  controller: _controllerConfirmPassword,
                  hintText: "conferma password",
                  validator: (v) => ValidatorsFormField.validatePasswordEqual(
                    v,
                    _controllerPassword.text,
                  ),
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: _suffixIcon(2, _showPassword3),
                  obscureText: !_showPassword3,
                  backgroundColor: Colors.white,
                  action: TextInputAction.done,
                ),
                PrimaryButton(
                  onPressed: _continue,
                  title: "Salva nuova password",
                  child: _loading
                      ? SizedBox(
                          height: 19,
                          width: 19,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
