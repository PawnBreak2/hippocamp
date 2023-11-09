//import 'package:flutter/material.dart';
//import 'package:ippocapp/auth/login.dart';
//import 'package:ippocapp/providers/user_provider.dart';
//import 'package:ippocapp/style/styles/colors.dart';
//import 'package:ippocapp/style/widgets/buttons/button_go_on.dart';
//import 'package:provider/provider.dart';

/*

class SidebarUser extends StatelessWidget {
  const SidebarUser({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Icon(
            Icons.account_circle_rounded,
            size: 160,
            color: CustomColors.primaryBlue,
          ),
          Text(
            "kstel30@gmail.com",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 24),
          ButtonGoOn(
            iconLeft: Icons.people_outline,
            title: "Invite new user",
            onPressed: () {},
          ),
          SizedBox(height: 8),
          ButtonGoOn(
            iconLeft: Icons.key,
            title: "Change password",
            onPressed: () {},
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginPage(),
                ),
                (route) => false,
              );
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                Colors.red.withOpacity(.1),
              ),
            ),
            child: Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 */
