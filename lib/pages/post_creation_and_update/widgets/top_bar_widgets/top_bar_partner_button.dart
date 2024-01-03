import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocapp/models/posts-creation/partner_model.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/styles/icons.dart';

class TopBarPartnerButton extends StatelessWidget {
  const TopBarPartnerButton({
    super.key,
    required this.partnerModel,
  });

  final PartnerModel? partnerModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: partnerModel == null
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 1),
                    Color.fromRGBO(221, 221, 221, 1),
                  ],
                ),
                border: Border.all(
                  color: Colors.black26,
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CustomMaterialIcons.partner,
                    color: CustomColors.grey121,
                    size: 20,
                  ),
                  Text(
                    "Partner",
                    style: TextStyle(fontSize: 8, color: CustomColors.grey121),
                  ),
                ],
              ),
            )
          : SvgPicture.network(
              partnerModel!.iconUrl,
              fit: BoxFit.contain,
            ),
    );
  }
}
