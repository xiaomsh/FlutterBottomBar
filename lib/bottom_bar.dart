library bottombar;

import 'package:flutter/material.dart';

import 'painter/wave_painter.dart';

/// type of the [WaveBottomBar]
enum WaveBottomBarType {
  /// default type of the [WaveBottomBar], the wave can move
  normal,

  /// wave can't move, and it is always at middle
  fixed,
}

/// direction of the [WaveBottomBar]
enum WaveBottomBarDirection {
  /// default direction of the wave, the wave direction is up
  up,

  /// the wave direction is down, this required Scaffold extendBody is true
  down,
}

/// control the current index
class WaveBarController {
  /// the widget state [_WaveBottomBarState]
  /// can use this to control index
  _WaveBottomBarState? _state;

  /// auto bind, no need to call
  void _bindState(_WaveBottomBarState state) {
    _state = state;
  }

  /// need to call when the stateful page is disposed
  void dispose() {
    _state = null;
  }

  /// call this to change the current index
  void animateToIndex(int index) {
    _state!.animToIndex(index);
  }
}

/// A bottom widget that like a wave can smoothly move to the active position
/// and provide much attrs to config the widget
class WaveBottomBar extends StatefulWidget {
  /// height of the [WaveBottomBar]
  final double height;

  /// amplitude or height of the [WavePainter]
  /// If the value is 0, the wave is gone
  final double amplitude;

  /// length of the [WavePainter]
  /// If the value is 0, the wave is gone
  final double waveLength;

  /// whole widget background color
  final Color? backgroundColor;

  /// shadow of the [WavePainter]
  final double? elevation;

  /// shadow color of the [WavePainter]
  final Color? shadowColor;

  /// the initial active index of the [WaveBottomBar]
  final int initialIndex;

  /// widget list of the [WaveBottomBar]
  /// contains normal icon, active icon and text
  final List<BottomNavigationBarItem> items;

  /// widget inside wave only can be configured when [type] is fixed
  final Widget? fixedWidget;

  /// type of the [WaveBottomBar]
  /// See [WaveBottomBarType] for more information
  final WaveBottomBarType type;

  /// direction of the [WaveBottomBar]
  /// See [WaveBottomBarDirection] for more information
  final WaveBottomBarDirection direction;

  /// this is used to update the current index
  final WaveBarController? controller;

  /// the distance of the parent
  final EdgeInsets margin;

  /// the margin between active label and icon
  final double selectedLabelMargin;

  /// the margin between normal label and icon
  final double unselectedLabelMargin;

  /// the margin between the active item and top of the wave
  final double activeTopMargin;

  /// corner radius of the [WaveBottomBar]
  final BorderRadius corner;

  /// the wave move anim duration
  final Duration duration;

  /// the wave move anim curve
  final Curve curve;

  /// active item text style
  final TextStyle selectedLabelStyle;

  /// normal item text style
  final TextStyle unselectedLabelStyle;

  /// whether the labels are shown for the selected [BottomNavigationBarItem].
  final bool showSelectedLabel;

  /// whether the labels are shown for the unselected [BottomNavigationBarItem]s.
  final bool showUnselectedLabel;

  /// called when one of the [items] is tapped.
  final Function(int index) onTap;

  WaveBottomBar({
    Key? key,
    this.height = 56.0,
    this.amplitude = 25,
    this.waveLength = 100,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.initialIndex = 0,
    required this.items,
    this.fixedWidget,
    this.type = WaveBottomBarType.normal,
    this.direction = WaveBottomBarDirection.up,
    this.controller,
    this.margin = const EdgeInsets.all(0),
    this.selectedLabelMargin = 7.5,
    this.unselectedLabelMargin = 3,
    this.activeTopMargin = -20,
    this.corner = const BorderRadius.all(Radius.zero),
    this.duration = const Duration(milliseconds: 50),
    this.curve = Curves.linear,
    this.selectedLabelStyle = const TextStyle(
      fontSize: 12,
      color: Colors.blue,
    ),
    this.unselectedLabelStyle = const TextStyle(
      fontSize: 12,
      color: Colors.grey,
    ),
    this.showSelectedLabel = true,
    this.showUnselectedLabel = true,
    required this.onTap,
  }) : super(key: key) {
    if (type == WaveBottomBarType.fixed) {
      assert(items.length % 2 != 0);
    }
  }

  @override
  State<StatefulWidget> createState() => _WaveBottomBarState();
}

class _WaveBottomBarState extends State<WaveBottomBar>
    with SingleTickerProviderStateMixin {
  /// the active item index
  int _currentIndex = 0;
  late AnimationController _animCon;

  @override
  void initState() {
    super.initState();

    widget.controller?._bindState(this);

    _animCon = AnimationController(vsync: this)
      ..addListener(() {
        setState(() {});
      });

    animToIndex(widget.initialIndex);
  }

  @override
  void didUpdateWidget(covariant WaveBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null &&
        oldWidget.controller != widget.controller) {
      widget.controller?._bindState(this);
    }
  }

  @override
  void dispose() {
    _animCon.dispose();
    super.dispose();
  }

  /// the normal widget list of bottom items, contains icon and text
  List<Widget> createNormalItem() {
    final childItem = <Widget>[];
    for (var i = 0; i < widget.items.length; i++) {
      if (_currentIndex == i) {
        childItem.add(const Expanded(child: SizedBox()));
        continue;
      }
      double height;
      double margin;
      bool hasFixed;
      if (widget.type == WaveBottomBarType.fixed &&
          i == widget.items.length ~/ 2) {
        height = widget.height + widget.amplitude;
        margin = widget.selectedLabelMargin;
        hasFixed = true;
      } else {
        height = widget.height;
        margin = widget.unselectedLabelMargin;
        hasFixed = false;
      }
      Widget child = Expanded(
        child: GestureDetector(
          onTap: () {
            widget.onTap(i);
            animToIndex(i);
          },
          child: Container(
            height: height,
            color: Colors.red,
            child: hasFixed && widget.fixedWidget != null
                ? Column(children: [widget.fixedWidget!])
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.items[i].icon,
                      if (widget.direction == WaveBottomBarDirection.up &&
                          widget.showUnselectedLabel) ...[
                        SizedBox(height: margin),
                        Text(
                          "${widget.items[i].label}",
                          style: widget.unselectedLabelStyle,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      );
      childItem.add(child);
    }
    return childItem;
  }

  /// the active item
  Widget createActiveItem(double perWidth) {
    double height;
    double margin;
    bool hasFixed;
    bool hasPosition;
    bool isCenter;
    if (widget.type == WaveBottomBarType.fixed) {
      if (_currentIndex == widget.items.length ~/ 2) {
        height = widget.height + widget.amplitude;
        margin = widget.selectedLabelMargin;
        hasFixed = true;
        hasPosition = true;
        isCenter = false;
      } else {
        height = widget.height;
        margin = widget.unselectedLabelMargin;
        hasFixed = false;
        hasPosition = true;
        isCenter = true;
      }
    } else {
      height = widget.height + widget.amplitude;
      margin = widget.selectedLabelMargin;
      hasFixed = true;
      hasPosition = true;
      isCenter = true;
    }

    Widget child = GestureDetector(
      onTap: () {
        widget.onTap(_currentIndex);
      },
      child: Container(
        width: perWidth,
        height: height,
        color: Colors.yellow,
        child: hasFixed && widget.fixedWidget != null
            ? Column(children: [widget.fixedWidget!])
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: isCenter
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  widget.items[_currentIndex].activeIcon,
                  if (widget.direction == WaveBottomBarDirection.up &&
                      widget.showSelectedLabel) ...[
                    SizedBox(height: margin),
                    Text(
                      "${widget.items[_currentIndex].label}",
                      style: widget.selectedLabelStyle,
                    ),
                  ],
                ],
              ),
      ),
    );
    final dx = _currentIndex * perWidth;
    final offset = FractionalOffset(dx, 0);
    if (hasPosition) {
      return FractionallySizedBox(
        widthFactor: 1 / widget.items.length,
        alignment: offset,
        child: child,
      );
    } else {
      return child;
    }
  }

  /// start anim to active item, pass the percentage to the wave
  void animToIndex(int index) {
    _currentIndex = index;
    setState(() {});
    if (widget.type == WaveBottomBarType.fixed) {
      final middle = (widget.items.length ~/ 2) / widget.items.length;
      _animCon.value = middle;
      return;
    }
    _animCon.animateTo(
      _currentIndex / widget.items.length,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width -
        widget.margin.left -
        widget.margin.right;
    final perWidth = width / widget.items.length;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: width,
          height: widget.height,
          child: CustomPaint(
            painter: WavePainter(
              amplitude: widget.amplitude,
              waveLength: widget.waveLength,
              backgroundColor: widget.backgroundColor ?? Colors.white,
              elevation: widget.elevation ?? 0,
              shadowColor: widget.shadowColor ?? Colors.grey.shade300,
              direction: widget.direction,
              corner: widget.corner,
              barCount: widget.items.length,
              percentage: _animCon.value,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: createNormalItem(),
        ),
        createActiveItem(perWidth),
      ],
    );
  }
}
