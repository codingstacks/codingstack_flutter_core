library gap_widget;

import 'package:flutter/cupertino.dart';

/// Created by Syed Hussain Mehdi at 15-05-2020

class VerticalGap extends StatelessWidget {
  final double gap;

  VerticalGap({this.gap = 8});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: gap,
    );
  }

  static VerticalGap get v12 => VerticalGap(gap: 12);

  static VerticalGap get v14 => VerticalGap(gap: 14);

  static VerticalGap get v16 => VerticalGap(gap: 16);

  static VerticalGap get v18 => VerticalGap(gap: 18);

  static VerticalGap get v20 => VerticalGap(gap: 20);

  static VerticalGap get v22 => VerticalGap(gap: 22);

  static VerticalGap get v24 => VerticalGap(gap: 24);

  static VerticalGap get v26 => VerticalGap(gap: 26);

  static VerticalGap get v28 => VerticalGap(gap: 28);

  static VerticalGap get v30 => VerticalGap(gap: 30);
}

class HorizontalGap extends StatelessWidget {
  final double gap;

  HorizontalGap({this.gap = 8});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: gap,
    );
  }

  static HorizontalGap get h12 => HorizontalGap(gap: 12);

  static HorizontalGap get h14 => HorizontalGap(gap: 14);

  static HorizontalGap get h16 => HorizontalGap(gap: 16);

  static HorizontalGap get h18 => HorizontalGap(gap: 18);

  static HorizontalGap get h20 => HorizontalGap(gap: 20);

  static HorizontalGap get h22 => HorizontalGap(gap: 22);

  static HorizontalGap get h24 => HorizontalGap(gap: 24);

  static HorizontalGap get h26 => HorizontalGap(gap: 26);

  static HorizontalGap get h28 => HorizontalGap(gap: 28);

  static HorizontalGap get h30 => HorizontalGap(gap: 30);
}

