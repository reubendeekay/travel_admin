import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_admin/constants.dart';

class AddAmmenities extends StatefulWidget {
  final Function(List<String> ammenities) onComplete;
  AddAmmenities({this.onComplete});
  @override
  _AddAmmenitiesState createState() => _AddAmmenitiesState();
}

class _AddAmmenitiesState extends State<AddAmmenities> {
  int ammenitiesLength = 1;
  List<String> ammenities = [];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              child: Text(
                'Ammenities/Top Features',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...List.generate(
              ammenitiesLength,
              (index) => Container(
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300]),
                        child: TextFormField(
                            maxLines: null,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Feature should  not be blank';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                labelText: 'Enter feature',
                                helperStyle: TextStyle(color: kPrimary),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: kPrimary, width: 1)),
                                border: InputBorder.none),
                            onSaved: (text) => {ammenities.add(text)}),
                      ),
                    ),
                    if (index == ammenitiesLength - 1)
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              if (ammenitiesLength > 1) ammenitiesLength--;
                            });
                          },
                          child: Icon(Icons.remove)),
                    if (index == ammenitiesLength - 1)
                      SizedBox(
                        width: 10,
                      )
                  ],
                ),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    ammenitiesLength++;
                  });
                },
              ),
            ),
            Container(
              height: 45,
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    widget.onComplete(ammenities);

                    Navigator.of(context).pop();
                  }
                },
                color: kPrimary,
                child: Text(
                  'Add Features',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
