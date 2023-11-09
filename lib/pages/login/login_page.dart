import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/helpers/ui/pop_ups.dart';
import 'package:hippocamp/helpers/validators/validators_form_field.dart';
import 'package:hippocamp/providers/auth_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/buttons/primary_button.dart';
import 'package:hippocamp/widgets/forms/primary_text_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';

import '../../providers/isLoading_provider.dart';
import '../../widgets/dialogs/flash_dialog.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  Widget _suffixIcon() {
    return InkWell(
      onTap: () {
        setState(() {
          _showPassword = !_showPassword;
        });
      },
      child: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
    );
  }

  Future<void> _continue() async {
    final isLoading = ref.watch(isLoadingProvider);
    print(isLoading);
    if (isLoading) return;

    if ((_key.currentState?.validate() ?? false)) {
      ref.read(isLoadingProvider.notifier).state = true;

      final auth = ref.read(authProvider.notifier);

      await auth.loginUser(
          e: _controllerEmail.text, p: _controllerPassword.text);

      SchedulerBinding.instance!.addPostFrameCallback((_) {
        ref.read(isLoadingProvider.notifier).state = false;
      });

      SchedulerBinding.instance!.addPostFrameCallback((_) {
        context.goNamed(routeMap[routeNames.splashScreen]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
      backgroundColor: CustomColors.primaryBlue,
      body: Center(
        child: Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                Spacer(),
                PrimaryTextFormField(
                  controller: _controllerEmail,
                  hintText: "email",
                  height: 70,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r' ')),
                  ],
                  validator: ValidatorsFormField.validateEmptyText,
                  prefixIcon: Icon(Icons.email),
                  backgroundColor: Colors.white,
                ),
                PrimaryTextFormField(
                  controller: _controllerPassword,
                  hintText: "password",
                  height: 70,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r' ')),
                  ],
                  validator: ValidatorsFormField.validateEmptyText,
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: _suffixIcon(),
                  obscureText: !_showPassword,
                  backgroundColor: Colors.white,
                  action: TextInputAction.done,
                ),
                SizedBox(height: 16),
                PrimaryButton(
                  onPressed: _continue,
                  title: "Login",
                  child: isLoading
                      ? SizedBox(
                          height: 19,
                          width: 19,
                          child: Consumer(
                            builder: (context, ref, child) {
                              final AsyncValue auth = ref.watch(authProvider);

                              return auth.when(
                                data: (data) {
                                  return const SizedBox();
                                },
                                error: (error, stack) {
                                  print('error');
                                  PopUps.showFlashErrorDialog(
                                      context: context,
                                      text: '${(error as AsyncError).error}');
                                  _controllerEmail.clear();
                                  _controllerPassword.clear();

                                  final auth = ref.read(authProvider.notifier);
                                  auth.reset();
                                  SchedulerBinding.instance!
                                      .addPostFrameCallback((_) {
                                    ref.read(isLoadingProvider.notifier).state =
                                        false;
                                  });

                                  return const SizedBox();
                                },
                                loading: () => const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              );
                            },
                          ),
                        )
                      : null,
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
