import 'package:flutter/material.dart';

class UploadProgress extends StatefulWidget {
  final double width;
  final double Function() progressCallback;
  const UploadProgress(
      {super.key, required this.width, required this.progressCallback});

  @override
  State<UploadProgress> createState() => _UploadProgressState();
}

class _UploadProgressState extends State<UploadProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(width: widget.width, child: LinearProgressIndicator());
  }
}
