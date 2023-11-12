import 'package:flutter/material.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateMemoPage extends StatefulWidget {
  const CreateMemoPage({super.key});

  @override
  State<CreateMemoPage> createState() => _CreateMemoPageState();
}

class _CreateMemoPageState extends State<CreateMemoPage> {
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _titleController = TextEditingController();
  bool _titleHasFocus = false;

  final QuillEditorController _contentController = QuillEditorController();
  bool _contentHasFocus = false;

  bool _thereIsSomethingToSave = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
  }

  void _onFocusChange() {
    _titleHasFocus = _focusNode.hasFocus;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryYellow,
        title: TextFormField(
          focusNode: _focusNode,
          controller: _titleController,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          decoration: InputDecoration(
            hintText: "Titolo",
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: _thereIsSomethingToSave
                  ? () {
                      Navigator.pop(context);
                    }
                  : null,
              icon: Icon(
                Icons.save,
                color: _thereIsSomethingToSave ? Colors.white : Colors.white54,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: QuillHtmlEditor(
              hintText: '',
              controller: _contentController,
              isEnabled: true,
              minHeight: 80.h,
              textStyle: TextStyle(fontSize: 14),
              hintTextStyle: TextStyle(fontSize: 14),
              hintTextAlign: TextAlign.start,
              padding: EdgeInsets.only(left: 8, top: 8),
              backgroundColor: Colors.white,
              onFocusChanged: (v) {
                _contentHasFocus = v;
                setState(() {});

                if (!v) print("SAVE");
              },
            ),
          ),
          if (!_titleHasFocus && _contentHasFocus)
            ToolBar.scroll(
              toolBarColor: Color.fromRGBO(77, 77, 77, 1),
              padding: const EdgeInsets.all(8),
              iconSize: 25,
              iconColor: Colors.white,
              activeIconColor: Color.fromRGBO(31, 31, 30, 1),
              controller: _contentController,
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: Axis.horizontal,
            ),
        ],
      ),
    );
  }
}
