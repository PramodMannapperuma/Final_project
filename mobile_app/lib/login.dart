// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_form_builder/flutter_form_builder.dart';
// //
// // class LoginForm extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Login'),
// //       ),
// //       body: BlocProvider(
// //         create: (_) => LoginBloc(), // Implement LoginBloc
// //         child: LoginFormBody(),
// //       ),
// //     );
// //   }
// // }
// //
// // class LoginFormBody extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final loginBloc = BlocProvider.of<LoginBloc>(context);
// //
// //     return Padding(
// //       padding: EdgeInsets.all(16.0),
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           FormBuilder(
// //             key: loginBloc.formKey,
// //             autovalidateMode: AutovalidateMode.always,
// //             child: Column(children: [
// //               FormBuilderTextField(
// //                 name: 'email',
// //                 decoration: InputDecoration(labelText: 'Email'),
// //               )
// //             ]),
// //           ),
// //           FormBuilderTextField(
// //             name: 'password',
// //             decoration: InputDecoration(labelText: 'Password'),
// //             obscureText: true,
// //           ),
// //           SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: () {
// //               if (loginBloc.formKey.currentState!.saveAndValidate()) {
// //                 final email = loginBloc
// //                     .formKey.currentState!.fields['email']!.value
// //                     .toString();
// //                 final password = loginBloc
// //                     .formKey.currentState!.fields['password']!.value
// //                     .toString();
// //                 // Add login logic here
// //                 loginBloc
// //                     .add(LoginButtonPressed(email: email, password: password));
// //               }
// //             },
// //             child: Text('Login'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class LoginBloc extends Bloc<LoginEvent, LoginState> {
// //   final formKey = GlobalKey<FormBuilderState>();
// //
// //   LoginBloc() : super(LoginInitial());
// //
// //   @override
// //   Stream<LoginState> mapEventToState(LoginEvent event) async* {
// //     if (event is LoginButtonPressed) {
// //       // Implement login logic here
// //       yield LoginLoading();
// //
// //       // Simulating login process with delay
// //       await Future.delayed(Duration(seconds: 2));
// //
// //       // Simulated success or failure
// //       if (event.email == 'user@example.com' && event.password == 'password') {
// //         yield LoginSuccess();
// //       } else {
// //         yield LoginFailure(error: 'Invalid credentials');
// //       }
// //     }
// //   }
// // }
// //
// // abstract class LoginEvent {}
// //
// // class LoginButtonPressed extends LoginEvent {
// //   final String email;
// //   final String password;
// //
// //   LoginButtonPressed({required this.email, required this.password});
// // }
// //
// // abstract class LoginState {}
// //
// // class LoginInitial extends LoginState {}
// //
// // class LoginLoading extends LoginState {}
// //
// // class LoginSuccess extends LoginState {}
// //
// // class LoginFailure extends LoginState {
// //   final String error;
// //
// //   LoginFailure({required this.error});
// // }
//
// currentStep: _currentStep,
// onStepContinue: () {
// setState(() {
// if (_currentStep < 2) {
// _currentStep++;
// }
// });
// },
// onStepCancel: () {
// setState(() {
// if (_currentStep > 0) {
// _currentStep--;
// }
// });
// },
//
// import 'package:flutter/material.dart';
//
// class SignupScreen extends StatefulWidget {
// const SignupScreen({super.key});
//
// @override
// _SignupScreenState createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// int _currentStep = 0;
// String _firstName = '';
// String _lastName = '';
// String _email = '';
// String _password = '';
// String? _gender;
//
// // Define variables to hold references to form fields
// final TextEditingController _firstNameController = TextEditingController();
// final TextEditingController _lastNameController = TextEditingController();
// final TextEditingController _emailController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();
//
// @override
// Widget build(BuildContext context) {
// return Scaffold(
// appBar: AppBar(
// title: const Text('Signup'),
// ),
// body: Padding(
// padding: const EdgeInsets.all(16.0),
// child: Form(
// key: _formKey,
// child: Stepper(
// currentStep: _currentStep,
// onStepContinue: () {
// setState(() {
// if (_currentStep < 2) {
// _currentStep++;
// }
// });
// },
// onStepCancel: () {
// setState(() {
// if (_currentStep > 0) {
// _currentStep--;
// }
// });
// },
// steps: [
// Step(
// title: const Text('Personal Information'),
// content: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// TextFormField(
// controller: _firstNameController,
// decoration: const InputDecoration(labelText: 'First Name'),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your first name';
// }
// return null;
// },
// onSaved: (value) {
// _firstName = value!;
// },
// ),
// TextFormField(
// controller: _lastNameController,
// decoration: const InputDecoration(labelText: 'Last Name'),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your last name';
// }
// return null;
// },
// onSaved: (value) {
// _lastName = value!;
// },
// ),
// ],
// ),
// ),
// Step(
// title: const Text('Account Information'),
// content: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// TextFormField(
// controller: _emailController,
// decoration: const InputDecoration(labelText: 'Email'),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your email';
// }
// return null;
// },
// onSaved: (value) {
// _email = value!;
// },
// ),
// TextFormField(
// controller: _passwordController,
// decoration: const InputDecoration(labelText: 'Password'),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your password';
// }
// return null;
// },
// onSaved: (value) {
// _password = value!;
// },
// obscureText: true,
// ),
// ],
// ),
// ),
// Step(
// title: const Text('Additional Information'),
// content: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// DropdownButtonFormField<String>(
// decoration: const InputDecoration(labelText: 'Gender'),
// value: _gender,
// items: const [
// DropdownMenuItem(
// value: 'Male',
// child: Text('Male'),
// ),
// DropdownMenuItem(
// value: 'Female',
// child: Text('Female'),
// ),
// DropdownMenuItem(
// value: 'Other',
// child: Text('Other'),
// ),
// ],
// onChanged: (value) {
// setState(() {
// _gender = value;
// });
// },
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please select your gender';
// }
// return null;
// },
// ),
// ],
// ),
// ),
// ],
// controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) {
// return Row(
// children: [
// ElevatedButton(
// onPressed: () {
// if (_validateCurrentStep()) {
// controlsDetails.onStepContinue!();
// }
// },
// child: Text(_currentStep == 2 ? 'Finish' : 'Next'),
// ),
// const SizedBox(width: 16),
// if (_currentStep > 0)
// TextButton(
// onPressed: controlsDetails.onStepCancel,
// child: const Text('Back'),
// ),
// ],
// );
// },
// ),
// ),
// ),
// );
// }
//
// // bool _validateCurrentStep() {
// // switch (_currentStep) {
// // case 0:
// // // Validate fields in the first step
// // if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
// // return false;
// // }
// // break;
// // case 1:
// // // Validate fields in the second step
// // if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
// // return false;
// // }
// // break;
// // case 2:
// // // Validate fields in the third step
// // if (_gender == null) {
// // return false;
// // }
// // break;
// // }
// // return true;
// // }
// // }
//
//
// // void _submitForm() {
// //     if (_formKey.currentState!.validate()) {
// //       _formKey.currentState!.save();
// //       // Perform form submission
// //       print('First Name: $_firstName');
// //       print('Last Name: $_lastName');
// //       print('Email: $_email');
// //       print('Password: $_password');
// //       print('Gender: $_gender');
// //       // You can perform any additional actions here, such as submitting the data to a server
// //     }
// //   }
// // }
