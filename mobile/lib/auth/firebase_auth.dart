import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> SignUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some errors occured");
    }
    return null;
  }

// Future<void> _saveUserData(User? user) async {
//   if (user != null) {
//     // Using Firestore as an example
//     await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//       'firstName': _firstName,
//       'lastName': _lastName,
//       'email': user.email,
//       'gender': _gender,
//       // Add other user info you want to save
//     });
//   }
// }
}
