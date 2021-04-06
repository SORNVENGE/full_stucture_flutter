
import 'package:flutter/material.dart';
import 'package:rare_pair/components/wave_slider.dart';

class AppWave extends StatefulWidget {
  @override
  _AppWaveState createState() => _AppWaveState();
}

class _AppWaveState extends State<AppWave> {
  int _age = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select Size',
                style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'Exo',
                ),
              ),
              WaveSlider(
                color: Colors.green,
                onChanged: (double val) {
                  setState(() {
                    _age = (val * 100).round();
                  });
                },
                onChangeEnd: (double value){

                },
                onChangeStart: (double value) {

                },
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(width: 20.0),
                  Text(
                    _age.toString(),
                    style: TextStyle(fontSize: 45.0),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    'YEARS',
                    style: TextStyle(fontFamily: 'TextMeOne', fontSize: 20.0),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
