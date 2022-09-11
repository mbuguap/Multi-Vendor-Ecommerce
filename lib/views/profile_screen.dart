import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference customer =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder(
      future: customer.doc(_auth.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('something went wrong'));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Center(child: Text('Data does not exists'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 140,
                  flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        opacity: constraints.biggest.height <= 120 ? 1 : 0,
                        duration: Duration(
                          milliseconds: 300,
                        ),
                        child: Text('Account'),
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.cyan, Colors.black26],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      // AssetImage('assets/images/guest.jpg'),
                                      NetworkImage('${data['image']}')),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                '${data['fullName']}',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    25,
                                  ),
                                  bottomLeft: Radius.circular(
                                    25,
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: SizedBox(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Center(
                                    child: Text(
                                      'Cart',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.cyan,
                              child: TextButton(
                                onPressed: () {},
                                child: SizedBox(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Center(
                                    child: Text(
                                      'Order',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    25,
                                  ),
                                  bottomRight: Radius.circular(
                                    25,
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: SizedBox(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Center(
                                    child: Text(
                                      'Wishlist',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RepeatedDivider(title: ' Account Info '),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 280,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          child: Column(
                            children: [
                              RepeatedListTile(
                                title: "Email Address",
                                subtitle: '${data['email']}',
                                leading: Icons.email,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(
                                  color: Colors.cyan,
                                  thickness: 1,
                                ),
                              ),
                              RepeatedListTile(
                                title: "Phone No",
                                subtitle: "+254711613085",
                                leading: Icons.phone,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(
                                  color: Colors.cyan,
                                  thickness: 1,
                                ),
                              ),
                              RepeatedListTile(
                                title: "Address",
                                subtitle: "1234 St",
                                leading: Icons.location_pin,
                              ),
                            ],
                          ),
                        ),
                      ),
                      RepeatedDivider(title: ' Account Settings '),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 280,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          child: Column(
                            children: [
                              RepeatedListTile(
                                title: "Edit Profile",
                                subtitle: '',
                                leading: Icons.edit,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(
                                  color: Colors.cyan,
                                  thickness: 1,
                                ),
                              ),
                              RepeatedListTile(
                                title: "Change Password",
                                subtitle: '',
                                leading: Icons.lock,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(
                                  color: Colors.cyan,
                                  thickness: 1,
                                ),
                              ),
                              RepeatedListTile(
                                title: "Logout",
                                subtitle: '',
                                leading: Icons.logout,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: Colors.cyan,
          ),
        );
      },
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leading;
  const RepeatedListTile({
    required this.title,
    required this.subtitle,
    required this.leading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(
        leading,
        color: Colors.cyan,
      ),
    );
  }
}

class RepeatedDivider extends StatelessWidget {
  final String title;
  const RepeatedDivider({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
