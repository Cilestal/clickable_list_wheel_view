[![pub package](https://img.shields.io/pub/v/clickable_list_wheel_view.svg)](https://pub.dartlang.org/packages/clickable_list_wheel_view)


# clickable_list_wheel_view

Simple wrapper for ListWheelScrollView that allows children to respond on gesture (onTap) events

<img src="https://raw.githubusercontent.com/cilestal/clickable_list_wheel_view/master/example/example.gif" height = "350" alt="Animated">

# Installation
In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
dependencies:
    clickable_list_wheel_view: last_version
```

# Usage

### Basic

You can get started really simple, just add

<img src="https://raw.githubusercontent.com/Cilestal/Flutter-simple-tooltip/master/example/example.png" align = "right" height = "440" alt="Basic">


```dart

ClickableListWheelScrollView(
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
)

```

## Full Api

```dart
  ///  Required. The [child] which the wrapper will target to
  final ListWheelScrollView child;

  /// Required. Must be the same for list and wrapper
  final ScrollController scrollController;

  /// Optional. ListWheelScrollView height
  final double listHeight;

  /// Required. Height of one child in ListWheelScrollView
  final double itemHeight;

  /// Required. Number of items in ListWheelScrollView
  final int itemCount;

  /// If true the list will scroll on click
  final bool scrollOnTap;

  /// Set a handler for listening to a `tap` event
  final OnItemTapCallback onItemTapCallback;

  /// sets the duration of the scroll  animation
  final Duration animationDuration;

```


