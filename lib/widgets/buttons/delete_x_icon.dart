import 'package:flutter/material.dart';

class DeleteXIcon extends StatelessWidget {
  final Alignment alignment;
  final VoidCallback onTap;

  const DeleteXIcon({required this.alignment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.black54),
            ),
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(4),
            child: Icon(
              Icons.clear,
              size: 16,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
