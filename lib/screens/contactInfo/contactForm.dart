import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/models/user.dart';

TextEditingController _nameController = new TextEditingController();

TextEditingController _numberController = new TextEditingController();

class ContactSave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 40),
                      child: Text(
                        'Add Contact',
                        style: TextStyle(
                          fontFamily: 'Cardo',
                          fontSize: 35,
                          color: Palette.darkBlue,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      //
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, top: 5),
                      child: Text(
                        'Contact Details',
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  //
                  SizedBox(
                    height: 30,
                  ),

                  MyCustomInputBox(
                    label: 'Name',
                    inputHint: 'John',
                  ),
                  //
                  SizedBox(
                    height: 30,
                  ),
                  //
                  MyCustomInputBox(
                    label: 'Phone Number',
                    inputHint: '+917003XXXXXX',
                  ),
                  //
                  SizedBox(
                    height: 30,
                  ),
                  //
                  Text(
                    "Saving a contact means you're okay with\nour Terms of Service and Privacy Policy",
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8f9db5).withOpacity(0.45),
                    ),
                    //
                  ),
                  InkWell(
                    onTap: () => saveContact(context),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: scrWidth * 0.85,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Palette.lightBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Save Contact',
                          style: TextStyle(
                            fontFamily: 'ProductSans',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ClipPath(
                clipper: OuterClippedPart(),
                child: Container(
                  color: Palette.lightBlue,
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
              //
              ClipPath(
                clipper: InnerClippedPart(),
                child: Container(
                  color: Palette.darkBlue,
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveContact(BuildContext context) async {
    KUser user = Provider.of<KUser>(context, listen: false);
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.email)
          .collection("contacts")
          .add(
              {"name": _nameController.text, "number": _numberController.text});
      print("Success!");
      _nameController.text = "";
      _numberController.text = "";
      Navigator.of(context).pop();
    } catch (e) {
      _nameController.text = "";
      _numberController.text = "";
      print(e);
      Navigator.of(context).pop();
    }
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 4);
    //
    path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    //
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.7, 0);

    //
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyCustomInputBox extends StatefulWidget {
  String label;
  String inputHint;

  MyCustomInputBox({this.label, this.inputHint});
  @override
  _MyCustomInputBoxState createState() => _MyCustomInputBoxState();
}

class _MyCustomInputBoxState extends State<MyCustomInputBox> {
  bool isSubmitted = false;
  final checkBoxIcon = 'assets/checkbox.svg';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, bottom: 8),
            child: Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 15,
                color: Color(0xff8f9db5),
              ),
            ),
          ),
        ),
        //
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
          child: TextFormField(
            controller: widget.label == "Phone Number"
                ? _numberController
                : _nameController,
            onChanged: (value) {
              setState(() {
                isSubmitted = true;
              });
            },
            style: TextStyle(
                fontSize: 19,
                color: Color(0xff0962ff),
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: widget.inputHint,
              hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[350],
                  fontWeight: FontWeight.w600),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 27, horizontal: 25),
              focusColor: Color(0xff0962ff),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color(0xff0962ff)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.grey[350],
                ),
              ),
              suffixIcon: isSubmitted == true
                  // will turn the visibility of the 'checkbox' icon
                  // ON or OFF based on the condition we set before
                  ? Visibility(
                      visible: true,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset(
                          checkBoxIcon,
                          height: 0.2,
                        ),
                      ),
                    )
                  : Visibility(
                      visible: false,
                      child: SvgPicture.asset(checkBoxIcon),
                    ),
            ),
          ),
        ),
        //
      ],
    );
  }
}
