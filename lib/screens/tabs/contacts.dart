import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/models/user.dart';
import 'package:women_safety/screens/contactInfo/contactForm.dart';
import 'package:women_safety/widgets/background_painter.dart';

class ContactsTab extends StatefulWidget {
  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _controller;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    KUser user = Provider.of<KUser>(context, listen: false);

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
                Lottie.asset("assets/contact.json"),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.email)
                          .collection("contacts")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text('loading....');
                        return ListView.builder(
                          itemExtent: 80.0,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => _buildListItem(
                              context, snapshot.data.documents[index], user),
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

  Widget _buildListItem(BuildContext context, DocumentSnapshot document, user) {
    final uuid = Uuid().v4();
    return Dismissible(
      key: Key(uuid),
      onDismissed: (direction) async {
        await FirebaseFirestore.instance
          ..collection('users')
              .doc(user.email)
              .collection("contacts")
              .doc(document.id)
              .delete();
        Get.snackbar("Successful!", "Contact Successfully Removed",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Palette.darkBlue,
            colorText: Colors.white);
      },
      child: ListTile(
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
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
