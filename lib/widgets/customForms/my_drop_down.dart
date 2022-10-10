import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myDropDown extends StatefulWidget {
  myDropDown(
      {required this.dropItems,
        required this.chosenValue,
        required this.choosingValue,
        Key? key})
      : super(key: key);

  List<String> dropItems;
  String chosenValue;
  void Function(String) choosingValue;

  @override
  State<myDropDown> createState() => myDropDownState();
}
class myDropDownState extends State<myDropDown> {
  String? newValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(left: 34, right: 34, top: 4, bottom: 42),
      padding: EdgeInsets.symmetric(vertical: 17, horizontal:  MediaQuery.of(context).size.width*0.05 ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blue.shade300,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              dropdownColor: Colors.blue.shade200,
              value: newValue??widget.chosenValue,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.white,
              //Lo siguiente pasea por todos los dropItems
              //y crea un DropdownMenuItem por cada uno
              //A lo ultimo el .toList() Asegunra que se crea una List<DropdownMenuItem>,
              //otra forma de llenarlo es items:[DropwdownMenuItem(...),DropwdownMenuItem(...),DropwdownMenuItem(...),]
              //Pero si tenemos q pasear cada dropItem para armar ese list, asi me resulta mas corto pq ahorro un for
              items: widget.dropItems
                  .map((String item) => DropdownMenuItem<String>(
                child: Text(
                  item,
                  style: TextStyle(
                      color:  Colors.white,
                      fontSize: 19,
                      fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
                ),
                value: item,
              ))
                  .toList(),
              hint: Text(
                "Please choose one",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (String? value) {
                widget.choosingValue(value!);
                setState((){
                  newValue = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}


