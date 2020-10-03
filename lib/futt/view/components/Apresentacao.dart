import 'package:flutter/material.dart';
import 'package:futt/futt/view/components/Passos.dart';

class Apresentacao {

  Widget getApresentacao(int passo) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/imgHome.jpg"),
              fit: BoxFit.fill
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Image.asset("images/logoFuttRedes.png", height: 60, width: 15),
            ),
            Passos().getPassos(passo),
          ],
        ),
      ),
    );
  }
}