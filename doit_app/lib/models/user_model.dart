
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'dart:async';

class UserModel  extends Model {

  //usuário logado

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  static UserModel of(BuildContext context) => ScopedModel.of<UserModel>(context);


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  //{} torna os argumentos opcionais e ignora ordem; @required exige os argumentos
  void signUp({@required Map <String, dynamic> userData, @required String password,
    @required VoidCallback onSuccess, @required VoidCallback onFail}){

    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: password
    //await -> async
    ).then((user) async{
      firebaseUser = user;

      onSuccess();
      isLoading = false;
      notifyListeners();

      await _saveUserData(userData);

    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  //await -> async
  //{} torna os argumentos opcionais e ignora ordem; @required exige os argumentos
  void signIn({@required String email, @required String password,
    @required VoidCallback onSuccess, @required VoidCallback onFail}) async {

    isLoading = true;
    notifyListeners();

    //await -> async
    _auth.signInWithEmailAndPassword(email: email, password: password).then(
        (user) async{
          firebaseUser = user;
          await _loadCurrentUser();

          onSuccess();
          isLoading = false;
          notifyListeners();

    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }

  //await -> async
  void signOut() async{
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPassword(String email){
    //método do firebase
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  //await -> async
  Future<Null> _saveUserData(Map<String, dynamic> userData) async{
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null)
      firebaseUser = await _auth.currentUser();

    if(firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot snapshot = await Firestore.instance.collection("users")
            .document(firebaseUser.uid).get();
        userData = snapshot.data;
      }
    }
    notifyListeners();
  }
}