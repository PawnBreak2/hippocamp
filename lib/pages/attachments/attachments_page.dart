import 'package:flutter/material.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/buttons/button_go_on.dart';

class AttachmentsPage extends StatefulWidget {
  const AttachmentsPage({super.key});

  @override
  State<AttachmentsPage> createState() => _AttachmentsPageState();
}

class _AttachmentsPageState extends State<AttachmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: CustomColors.primaryBlue,
        title: Text(
          "File and Attachments",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(height: 8),
          ButtonGoOn(
            iconLeft: Icons.edit_document,
            title: "Documents Timeline",
            onPressed: () {},
          ),
          Divider(),
          ButtonGoOn(
            iconLeft: Icons.edit_document,
            title: "Bollette utenze",
            onPressed: () {},
          ),
          Divider(),
          ButtonGoOn(
            iconLeft: Icons.edit_document,
            title: "Liste movimenti",
            onPressed: () {},
          ),
          Divider(),
          ButtonGoOn(
            iconLeft: Icons.edit_document,
            title: "Garanzie",
            onPressed: () {},
          ),
          Divider(),
          ButtonGoOn(
            iconLeft: Icons.edit_document,
            title: "Avvisi di pagamento",
            onPressed: () {},
          ),
          Divider(),
          ButtonGoOn(
            iconLeft: Icons.edit_document,
            title: "Ricetta medica",
            onPressed: () {},
          ),
          Divider(),
          ButtonGoOn(
            iconLeft: Icons.edit_document,
            title: "Fatture passive",
            onPressed: () {},
          ),
          Divider(),
          ButtonGoOn(
            iconLeft: Icons.edit_document,
            title: "Scontrini",
            onPressed: () {},
          ),
          Divider(),
          ButtonGoOn(
            iconLeft: Icons.edit_document,
            title: "Fotografie",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
