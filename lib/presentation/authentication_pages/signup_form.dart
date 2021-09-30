import 'package:cas_finance_management/configuration.dart';
import 'package:cas_finance_management/presentation/widgets/form_validator.dart';
import 'package:cas_finance_management/presentation/widgets/internet_connectivity.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/widgets.dart';
import 'login_form.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  Responsive? _responsive;
  bool _isObscure = true;
  final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  Widget _emailPasswordRegistrationWidget() {
    return Form(
      key: _signupFormKey,
      child: Column(
        children: <Widget>[
          InputFormField(
            controller: _userNameEditingController,
            keyboardType: TextInputType.text,
            validator: (value) =>
                FormValidator.textFieldValidator(value, 'Enter User Name'),
            labelText: 'User Name',
            hintText: 'john Doe',
            inputFormatters: <FilteringTextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
            ],
            icon: const Icon(
              Icons.account_circle_outlined,
              color: ColorSchema.deepSeaBlue,
            ),
            textInputAction: TextInputAction.next,
          ),
          InputFormField(
            controller: _emailEditingController,
            validator: (value) => FormValidator.emailFieldValidator(value),
            labelText: 'Email ID',
            hintText: 'UserName@Gmail.com',
            keyboardType: TextInputType.emailAddress,
            inputFormatters: InputFormat.emailInputFormat,
            icon: const Icon(
              Icons.mail_outline,
              color: ColorSchema.deepSeaBlue,
            ),
            textInputAction: TextInputAction.next,
          ),
          InputFormField(
            controller: _passwordEditingController,
            validator: (value) => FormValidator.passwordFieldValidator(value),
            labelText: 'Password',
            hintText: 'password',
            keyboardType: TextInputType.text,
            obscureText: _isObscure,
            inputFormatters: InputFormat.passwordInputFormat,
            icon: const Icon(
              Icons.lock_outline_rounded,
              color: ColorSchema.deepSeaBlue,
            ),
            suffixWidget: IconButton(
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              icon: Icon(
                _isObscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () async {
        if (_signupFormKey.currentState!.validate()) {
          if (ConnectivityChangeNotifier().isNoInternet) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('No Internet'),
            ));
          } else {
            await userAuth
                .userRegistration(
                    email: _emailEditingController.text,
                    password: _passwordEditingController.text,
                    userName: _userNameEditingController.text)
                .then((value) {
              if (userAuth.isVerificationMailSent) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Check Inbox')));
              }
            });
            if (userAuth.isWeekPassword) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Week Password')));
            } else if (userAuth.isEmailAlreadyUsed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User Already Exist')));
            }
          }
        }
      },
      child: Container(
        width: _responsive!.width! * 0.75,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff635570), Color(0xff1795C2)])),
        child: const Text(
          'Signup Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    _responsive = Responsive(
        aspectRatio: _size.aspectRatio,
        width: _size.width,
        height: _size.height,
        size: _size);
    return Column(
      children: <Widget>[
        SizedBox(height: _responsive!.height! * 0.02),
        _emailPasswordRegistrationWidget(),
        SizedBox(height: _responsive!.height! * 0.02),
        _signUpButton(),
      ],
    );
  }

  @override
  void dispose() {
    _userNameEditingController.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }
}

// End Signup Form

class SignupPage extends StatefulWidget {
  final String? title;
  const SignupPage({Key? key, this.title}) : super(key: key);
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Responsive? _responsive;
  Widget _logo() {
    return SizedBox(
        height: _responsive!.height! * 0.15,
        width: _responsive!.width! * 0.30,
        child: const Image(
          image: AssetImage('assets/images/casLogo.png'),
          fit: BoxFit.cover,
        ));
  }

  Widget _accountExistButton() {
    return InkWell(
      onTap: () {
        /*Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpPage()));*/
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Already have an Account?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: ColorSchema.deepSeaBlue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    _responsive = Responsive(
        aspectRatio: _size.aspectRatio,
        width: _size.width,
        height: _size.height,
        size: _size);

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -_responsive!.height! * .15,
                left: _responsive!.width! * .4,
                child: const BezierContainer()),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: _responsive!.height! * .2),
                  _logo(),
                  const SignupForm(),
                  SizedBox(height: _responsive!.height! * .030),
                  _accountExistButton(),
                ],
              ),
            ),
            //Positioned(top: 40, left: 0, child: backButton()),
          ],
        ),
      )),
    );
  }
}
