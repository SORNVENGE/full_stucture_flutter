import 'package:flutter/material.dart';

class FlightsStepper extends StatefulWidget {
  @override
  _FlightsStepperState createState() => _FlightsStepperState();
}

class _FlightsStepperState extends State<FlightsStepper> {
  int pageNumber = 1;

  @override
  Widget build(BuildContext context) {
    Widget page = CurrentPage(
      pageNumber: pageNumber, 
      onChange: (value) => setState(() => pageNumber = value)
    );

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-bg.png'),
          fit: BoxFit.cover
        )
      ),
      child: Stack(
        children: [
          AsideColor(),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              
              body: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(top: 30),
                child: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      ArrowIcons(),
                      Plane(),
                      Line(),
                      Positioned.fill(
                        left: 32.0 + 8,
                        child: AnimatedSwitcher(
                          child: page,
                          duration: Duration(milliseconds: 250),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentPage extends StatelessWidget{
  final int pageNumber;
  final Function onChange;

  const CurrentPage({Key key, this.pageNumber, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (pageNumber) {
      case 1:
        return Page(
          key: Key('billing'),
          onOptionSelected: () => onChange(2),
          question: 'Do you typically fly for business, personal reasons, or some other reason?',
          answers: <String>['Shipping', 'Review', 'Payment'],
          number: 1,
        );
      case 2:
        return Page(
          key: Key('shipping'),
          onOptionSelected: () => onChange(3),
          question: 'How many hours is your average flight?',
          answers: <String>[
            'Review',
            'Payment'
          ],
          number: 2,
        );
      case 3:
        return Page(
          key: Key('review'),
          onOptionSelected: () => onChange(4),
          question: 'How many hours is your average flight?',
          answers: <String>[
            'Review',
            'Payment'
          ],
          number: 3,
        );
      default:
        return Page(
          key: Key('payment'),
          onOptionSelected: () => onChange(2),
          question: 'Do you typically fly for business, personal reasons, or some other reason?',
          answers: <String>['Business', 'Personal', 'Others'],
          number: 1,
        );
    }
  }
}

class Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 32.0 + 32 + 8,
      top: 40,
      bottom: 0,
      width: 1,
      child: Container(color: Colors.white.withOpacity(0.5)),
    );
  }
}

class Page extends StatefulWidget {
  final int number;
  final String question;
  final List<String> answers;
  final VoidCallback onOptionSelected;

  const Page(
      {Key key,
      @required this.onOptionSelected,
      @required this.number,
      @required this.question,
      @required this.answers})
      : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> 
  with SingleTickerProviderStateMixin {

  List<GlobalKey<_ItemFaderState>> keys;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 32),
        ItemFader(key: keys[0], child: StepNumber(number: widget.number)),
        ItemFader(
          key: keys[1],
          child: StepQuestion(question: widget.question),
        ),
        // Spacer(),
        ...widget.answers.map((String answer) {
          int answerIndex = widget.answers.indexOf(answer);
          int keyIndex = answerIndex + 2;
          return ItemFader(
            key: keys[keyIndex],
            child: OptionItem(
              name: answer,
              onTap: (offset) => onTap(keyIndex, offset),
              showDot: selectedOptionKeyIndex != keyIndex,
            ),
          );
        }),
        SizedBox(height: 64),
      ],
    );
  }

  void onTap(int keyIndex, Offset offset) async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.hide();
      if (keys.indexOf(key) == keyIndex) {
        setState(() => selectedOptionKeyIndex = keyIndex);
        animateDot(offset).then((_) => widget.onOptionSelected());
      }
    }
  }

  void onInit() async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.show();
    }
  }
}

class StepNumber extends StatelessWidget {
  final int number;

  const StepNumber({Key key, @required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = 'Billing';
    switch (number) {
      case 1:
        text = 'Billing';
        break;
      case 2:
        text = 'Shipping';
        break;
      case 3:
        text = 'Review';
        break;
      case 4:
        text = 'Payment';
        break;
      default:
    }

    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 16),
      child: 
      Text(text,
        style: TextStyle(
          fontSize: 25, color: Colors.white, fontFamily: 'Gugi'
        ),
      ),
    );
  }
}

class StepQuestion extends StatelessWidget {
  final String question;

  const StepQuestion({Key key, @required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(left: 45, right: 16),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Color(0xFF303a50),
              Color(0xFF313a50),
              Color(0xFF2e394d),
              Color(0xFF283141),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(-1.5, -1),
              color: Colors.black38.withOpacity(0.2)
            ),
            BoxShadow(
              blurRadius: 2,
              offset: Offset(2, 2),
              color: Colors.white24.withOpacity(.1)
            )
          ]
        ),
        child: Column(
          children: [
            Container(
              child: InputFormField(
                hint: 'First name',
              ),
            ),
            InputFormField(
              hint: 'Middle name',
            ),
            InputFormField(
              hint: 'Last name',
            )
          ],
        ),
      ),
    );
  }
}

class InputFormField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isSecure;
  final IconData icon;

  const InputFormField({Key key, 
    this.hint = '', this.label = '', this.isSecure = false, this.icon = Icons.email_outlined}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: TextFormField(
              obscureText: isSecure,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.white.withOpacity(.6), fontSize: 14),
                // prefixIcon: Icon(icon, color: Colors.white54),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white.withOpacity(.2),
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionItem extends StatefulWidget {
  final String name;
  final void Function(Offset dotOffset) onTap;
  final bool showDot;

  const OptionItem(
      {Key key, @required this.name, @required this.onTap, this.showDot = true})
      : super(key: key);

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RenderBox object = context.findRenderObject();
        Offset globalPosition = object.localToGlobal(Offset.zero);
        widget.onTap(globalPosition);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: <Widget>[
            SizedBox(width: 26),
            Dot(visible: widget.showDot),
            SizedBox(width: 26),
            Expanded(
              child: Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            )
          ],
        ),
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

  void show() {
    setState(() => position = 1);
    _animationController.forward();
  }

  void hide() {
    setState(() => position = -1);
    _animationController.reverse();
  }

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
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class Dot extends StatelessWidget {
  final bool visible;

  const Dot({Key key, this.visible = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: visible ? Colors.white : Colors.transparent,
      ),
    );
  }
}

class ArrowIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 8,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () {},
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              color: Color.fromRGBO(120, 58, 183, 1),
              icon: Icon(Icons.arrow_downward),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class Plane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 50,
      top: 32,
      child: RotatedBox(
        quarterTurns: 2,
        child: Icon(
          Icons.airplanemode_active,
          size: 44, color: Colors.white,
        ),
      ),
    );
  }
}

class AsideColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30)
          ),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
              Color(0xFF3c77dd),
              Color(0xFF3a5bbf),
              Color(0xFF3a4fb6),
              Color(0xFF3a5bbf),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(-1.5, -1),
              color: Colors.black38.withOpacity(0.2)
            ),
            BoxShadow(
              blurRadius: 2,
              offset: Offset(2, 2),
              color: Colors.white24.withOpacity(.1)
            )
          ]
        ),
        width: size.width / 2.2,
        height: size.height / 1.3,
        alignment: Alignment.topRight,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: RotatedBox(
              quarterTurns: 1,
              child: Text('CHECK-OUT', 
                style: TextStyle(color: Colors.white.withOpacity(.2), fontFamily: 'Audiowide', fontSize: 60),)
            ),
          )
        ),
      ),
    );
  }
}
