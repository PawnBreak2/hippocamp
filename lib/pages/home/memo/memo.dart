import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  // Outer list
  List<DragAndDropItem> _contents = [];

  @override
  void initState() {
    super.initState();

    // Generate a list
    _contents = [
      DragAndDropItem(
        child: _itemNote(
          key: Key("0"),
          title: "Misure del terrazzo 0",
          content: "Perimetro interno terrazzo (senza muretto) 8.90 x 6.30",
        ),
      ),
      DragAndDropItem(
        child: _itemNote(
          key: Key("1"),
          title: "Misure del terrazzo 1",
          content: "Perimetro interno terrazzo (senza muretto) 8.90 x 6.30",
        ),
      ),
      DragAndDropItem(
        child: _itemNote(
          key: Key("2"),
          title: "Misure del terrazzo 2",
          content:
              "Perimetro interno terrazzo (senza muretto) 8.90 x 6.30. Perimetro interno terrazzo (senza muretto) 8.90 x 6.30. Perimetro interno terrazzo (senza muretto) 8.90 x 6.30. Perimetro interno terrazzo (senza muretto) 8.90 x 6.30",
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 218, 210, 1),
      body: DragAndDropLists(
        children: [
          DragAndDropList(children: _contents),
        ],
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
      ),
    );
  }

  Widget _itemNote({
    required Key key,
    required String title,
    required String content,
  }) {
    return Slidable(
      key: key,
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          GestureDetector(
            onTap: () {
              // DELETE
              _contents.removeWhere((e) => e.child.key == key);
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: 100.w,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            margin: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    var movedItem = _contents.removeAt(oldItemIndex);
    _contents.insert(newItemIndex, movedItem);
    setState(() {});
  }

  void _onListReorder(int oldListIndex, int newListIndex) {
    var movedList = _contents.removeAt(oldListIndex);
    _contents.insert(newListIndex, movedList);
    setState(() {});
  }
}
