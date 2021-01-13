import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/screens/contactInfo/contactForm.dart';
import 'package:women_safety/widgets/background_painter.dart';
import 'package:women_safety/widgets/title.dart';

class ContactsTab extends StatefulWidget {
  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.darkBlue,
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ContactSave(),
        )),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                LoginTitle(title: "Contacts"),
                Lottie.asset("assets/contact.json"),
                SizedBox(
                  height: 200,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('contacts')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text('loading....');
                        return ListView.builder(
                          itemExtent: 80.0,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => _buildListItem(
                              context, snapshot.data.documents[index]),
                        );
                      }

// This trailing comma makes auto-formatting nicer for build methods.
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                document['name'],
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xffdd),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                document['number'],
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
