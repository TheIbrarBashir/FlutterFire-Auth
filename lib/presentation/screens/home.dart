import 'package:cas_finance_management/repository/firebase/firebase_auth/firebase_auth_services.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserAuthentication userAuth = UserAuthentication();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 200,
                        width: 200,
                        child: Column(
                          children: [
                            InputFormField(
                              labelText: 'Email',
                              hintText: 'john@gmail.com',
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              controller: _emailController,
                            ),
                            formButton(
                                child: const Center(child: Text('send email')),
                                onPress: () {
                                  userAuth.userRegistration();
                                })
                          ],
                        ),
                      );
                    });
              },
              child: const SizedBox(
                height: 100,
                width: 50,
                child: Center(child: Text('Add user')),
              ))),
    );
  }
}
