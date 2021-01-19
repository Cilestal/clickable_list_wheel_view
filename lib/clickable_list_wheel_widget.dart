import 'package:flutter/cupertino.dart';

import 'measure_size.dart';

class ClickableListWheelScrollView extends StatefulWidget {
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 600);

  final ListWheelScrollView child;
  final ScrollController scrollController;
  final double listHeight;
  final double itemHeight;
  final int itemCount;
  final bool scrollOnTap;
  final OnItemTapCallback onItemTapCallback;
  final Duration animationDuration;

  const ClickableListWheelScrollView({
    Key key,
    @required this.scrollController,
    this.listHeight,
    @required this.child,
    @required this.itemHeight,
    this.scrollOnTap = true,
    this.onItemTapCallback,
    @required this.itemCount,
    this.animationDuration = _defaultAnimationDuration,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClickableListWheelScrollViewState();
}

class _ClickableListWheelScrollViewState extends State<ClickableListWheelScrollView> {
  double _listHeight;
  Offset _tapUpDetails;

  @override
  void initState() {
    _listHeight = widget.listHeight ?? 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_listHeight == .0) {
      return MeasureSize(
        child: Container(
          child: widget.child,
        ),
        onChange: (value) {
          setState(() {
            _listHeight = value.height;
          });
        },
      );
    }

    return GestureDetector(
      onTap: _onTap,
      onTapUp: (tapUpDetails) {
        _tapUpDetails = tapUpDetails?.localPosition;
      },
      child: widget.child,
    );
  }

  double _getClickedOffset() {
    if (_tapUpDetails == null) {
      return 0;
    }
    return _tapUpDetails.dy - (_listHeight / 2.0);
  }

  int _getClickedIndex() {
    final currentIndex = widget.scrollController.offset ~/ widget.itemHeight;
    final clickOffset = _getClickedOffset();
    final indexOffset = (clickOffset / widget.itemHeight).round();
    final newIndex = currentIndex + indexOffset;

    if (newIndex < 0 || newIndex >= widget.itemCount) {
      return -1;
    }

    return newIndex;
  }

  Future<void> _onTap() async {
    if (widget.scrollController is FixedExtentScrollController) {
      await _onFixedExtentScrollControllerTaped();
    } else {
      await _onScrollControllerTaped();
    }
  }

  Future<void> _onScrollControllerTaped() async {
    final offset = _getClickedOffset();
    final scrollOffset = widget.scrollController.offset + offset;

    final index = (scrollOffset / widget.itemHeight).round();
    widget.onItemTapCallback?.call(index);

    if (widget.scrollOnTap) {
      await widget.scrollController
          .animateTo(index * widget.itemHeight, duration: widget.animationDuration, curve: Curves.ease);
    }
  }

  Future<void> _onFixedExtentScrollControllerTaped() async {
    final index = _getClickedIndex();

    if (index < 0) {
      return;
    }

    widget.onItemTapCallback?.call(index);

    if (widget.scrollOnTap) {
      (widget.scrollController as FixedExtentScrollController)
          .animateToItem(index, duration: widget.animationDuration, curve: Curves.ease);
    }
  }
}

typedef OnItemTapCallback = Function(int index);
