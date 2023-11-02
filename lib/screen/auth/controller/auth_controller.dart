import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  bool userCheck=true;

  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  User ?get currentUser=>firebaseAuth.currentUser;
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();



void usercheckfun(bool valu){
  userCheck=valu;
  update();
}
  Future<void> signin({required String email,required String password})async{
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
    
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } else {
      print('Error: ${e.message}');
    }
  }
}




   
    
    

  

  



}