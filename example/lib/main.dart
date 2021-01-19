import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Material(
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _scrollController = FixedExtentScrollController();

  static const double _itemHeight = 60;
  static const int _itemCount = 100;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ClickableListWheelScrollView(
          scrollController: _scrollController,
          itemHeight: _itemHeight,
          itemCount: _itemCount,
          onItemTapCallback: (index) {
            print("onItemTapCallback index: $index");
          },
          child: ListWheelScrollView.useDelegate(
            controller: _scrollController,
            itemExtent: _itemHeight,
            physics: FixedExtentScrollPhysics(),
            overAndUnderCenterOpacity: 0.5,
            perspective: 0.002,
            onSelectedItemChanged: (index) {
              print("onSelectedItemChanged index: $index");
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) => _child(index),
              childCount: _itemCount,
            ),
          ),
        ),
      ),
    );
  }

  Widget _child(int index) {
    return SizedBox(
      height: _itemHeight,
      child: ListTile(
        leading: Icon(IconData(int.parse("0xe${index + 200}"), fontFamily: 'MaterialIcons'), size: 50),
        title: Text('Heart Shaker'),
        subtitle: Text('Description here'),
      ),
    );
  }
}
