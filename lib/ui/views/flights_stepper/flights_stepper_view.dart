import 'package:flutter/material.dart';
import 'package:flutterstacked/logger.dart';
import 'package:flutterstacked/ui/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'flights_stepper_viewmodel.dart';

final log = getLogger('FlightsStepperView');
bool _isButtonTapped = false;

class FlightsStepperView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FlightsStepperViewModel>.reactive(
      builder: (context, model, child) {
        model.parseData();
        return _FlightsStepperStatefulWidget(viewModel: model);
      },
      viewModelBuilder: () => FlightsStepperViewModel(),
    );
  }
}

class _FlightsStepperStatefulWidget extends StatefulWidget {
  final FlightsStepperViewModel viewModel;

  const _FlightsStepperStatefulWidget({Key key, @required this.viewModel})
      : super(key: key);

  @override
  _FlightsStepperStatefulWidgetState createState() =>
      _FlightsStepperStatefulWidgetState();
}

class _FlightsStepperStatefulWidgetState
    extends State<_FlightsStepperStatefulWidget> {
  int pageNumber = 1;

  @override
  Widget build(BuildContext context) {
    Widget page = pageNumber == 1
        ? _Page(
            key: Key('page1'),
            onOptionSelected: () => setState(() => pageNumber = 2),
            question: widget.viewModel.flightsStepperModelList[0].question,
            answers: widget.viewModel.flightsStepperModelList[0].answers,
            number: widget.viewModel.flightsStepperModelList[0].number,
          )
        : _Page(
            key: Key('page2'),
            onOptionSelected: () => setState(() => pageNumber = 1),
            question: widget.viewModel.flightsStepperModelList[1].question,
            answers: widget.viewModel.flightsStepperModelList[1].answers,
            number: widget.viewModel.flightsStepperModelList[1].number,
          );

    return Scaffold(
      body: Container(
        decoration: backgroundDecoration,
        child: SafeArea(
          child: Theme(
            data: ThemeData(brightness: Brightness.dark),
            child: Stack(
              children: <Widget>[
                _ArrowIcons(),
                _Plane(),
                _Line(),
                page,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArrowIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 8,
        bottom: 8,
        child: Column(
          children: <Widget>[
            IconUp(),
            IconDown(),
          ],
        ));
  }
}

class IconUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.arrow_upward,
      ),
    );
  }
}

class IconDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.arrow_downward,
        color: Color.fromRGBO(120, 58, 183, 1),
      ),
    );
  }
}

class _Plane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 32.0 + 8,
      top: 32,
      child: RotatedBox(
        quarterTurns: 2,
        child: Icon(
          Icons.airplanemode_active,
          size: 64,
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 40.0 + 33,
      top: 45,
      bottom: 0,
      width: 1,
      child: Container(
        color: Colors.white.withOpacity(0.5),
      ),
    );
  }
}

class _Page extends StatefulWidget {
  final String number;
  final String question;
  final List<String> answers;
  final VoidCallback onOptionSelected;

  const _Page({
    Key key,
    @required this.onOptionSelected,
    @required this.number,
    @required this.question,
    @required this.answers,
  }) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> with SingleTickerProviderStateMixin {
  List<GlobalKey<_ItemFaderState>> keys;
  var itemIndex = 0;
  int selectedOptionKeyIndex;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    keys = List.generate(
      2 + widget.answers.length,
      (_) => GlobalKey<_ItemFaderState>(),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    onInit();
  }

  void onInit() async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.show();
    }
    _isButtonTapped = false;
  }

  void onTap(int keyIndex, Offset offset) async {
    if (_isButtonTapped) return;
    _isButtonTapped = true;
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.hide();
      if (keys.indexOf(key) == keyIndex) {
        setState(() => selectedOptionKeyIndex = keyIndex);
        animateDot(offset).then((_) => widget.onOptionSelected());
      }
    }
  }

  Future<void> animateDot(Offset startOffset) async {
    OverlayEntry entry = OverlayEntry(
      builder: (context) {
        double minTop = MediaQuery.of(context).padding.top + 52;
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Positioned(
              left: 26.0 + 32 + 8,
              top: minTop +
                  (startOffset.dy - minTop) * (1 - _animationController.value),
              child: child,
            );
          },
          child: Dot(),
        );
      },
    );
    Overlay.of(context).insert(entry);
    await _animationController.forward(from: 0);
    entry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          ItemFader(
            key: keys[0],
            child: StepNumber(number: widget.number),
          ),
          ItemFader(
            key: keys[1],
            child: StepQuestion(question: widget.question),
          ),
          Spacer(),
          ...widget.answers.map((String answer) {
            int answerIndex = widget.answers.indexOf(answer);
            int keyIndex = answerIndex + 2;
            return ItemFader(
              key: keys[keyIndex],
              child: _OptionItem(
                name: answer,
                onTap: (offset) => onTap(keyIndex, offset),
                showDot: selectedOptionKeyIndex != keyIndex,
              ),
            );
          }),
          UIHelper.verticalSpaceLarge,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class StepNumber extends StatelessWidget {
  final String number;

  const StepNumber({
    Key key,
    @required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 70),
      child: Text(
        number,
        style: TextStyle(
          fontSize: 70,
          color: Colors.white.withOpacity(0.7),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class StepQuestion extends StatelessWidget {
  final String question;

  const StepQuestion({
    Key key,
    @required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 70),
      child: Text(
        question,
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _OptionItem extends StatefulWidget {
  final String name;
  final Function onTap;
  final bool showDot;

  const _OptionItem({
    Key key,
    @required this.name,
    @required this.onTap,
    this.showDot = true,
  }) : super(key: key);

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<_OptionItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RenderBox object = context.findRenderObject();
        Offset globalPosition = object.localToGlobal(Offset.zero);
        widget.onTap(globalPosition);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: <Widget>[
            UIHelper.horizontalSpaceMedium,
            Dot(visible: widget.showDot),
            UIHelper.horizontalSpaceMedium,
            Expanded(
              child: Text(
                widget.name,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final bool visible;

  const Dot({Key key, this.visible = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13,
      width: 13,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: visible ? Colors.white : Colors.transparent,
      ),
    );
  }
}

class ItemFader extends StatefulWidget {
  final Widget child;

  const ItemFader({Key key, @required this.child}) : super(key: key);

  @override
  _ItemFaderState createState() => _ItemFaderState();
}

class _ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  //1 means its below, -1 means its above
  int position = 1;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 64 * position * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: widget.child,
          ),
        );
      },
    );
  }

  void show() {
    setState(() => position = 1);
    _animationController.forward();
  }

  void hide() {
    setState(() => position = -1);
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

const backgroundDecoration = const BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(76, 61, 243, 1),
      Color.fromRGBO(120, 58, 183, 1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);
