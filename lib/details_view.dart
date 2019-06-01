import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  final questionDetails;

  DetailsView(this.questionDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
            title: Text(
              'Stack Overflow',
            ),
      ),
      body: Container(
      child:Text(questionDetails!=null ? questionDetails : 'lalalalal')
    )
    ) ;
  }
}