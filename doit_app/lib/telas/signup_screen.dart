import 'package:doit_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC1DDCC),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading)
            return Center(child: CircularProgressIndicator());
          else
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(20.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameCtrl,
                    // ignore: missing_return
                    validator: (text){
                      if(text.isEmpty)
                        return "O nome não pode ficar em branco";
                    },
                    decoration: InputDecoration(
                      hintText: "Insira seu nome",
                    ),
                  ),
                  SizedBox(height: 18.0,),
                  TextFormField(
                    controller: _addressCtrl,
                    // ignore: missing_return
                    validator: (text){
                      if (text.isEmpty)
                        return "O endereço não pode ficar em branco!";
                    },
                    decoration: InputDecoration(
                      hintText: "Insira seu endereço",
                    ),
                  ),
                  SizedBox(height: 18.0,),
                  TextFormField(
                    controller: _emailCtrl,
                    // ignore: missing_return
                    validator: (email){
                      if (email.isEmpty || !email.contains("@"))
                        return "Insira um email válido!";
                    },
                    decoration: InputDecoration(
                      hintText: "Insira seu email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 18.0,),
                  TextFormField(
                    controller: _passwordCtrl,
                    // ignore: missing_return
                    validator: (senha){
                      if(senha.isEmpty || senha.length < 6)
                        return "Insira uma senha válida!";
                    },
                    decoration: InputDecoration(
                      hintText: "Insira uma senha de 6 dígitos",
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 18.0,),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: (){
                      //verifica validação do formulário
                      if(_formKey.currentState.validate()){

                        Map<String, dynamic> userData = {
                          "name":_nameCtrl.text,
                          "address":_addressCtrl.text,
                          "email": _emailCtrl.text,
                        };

                        model.signUp(userData: userData,
                            password: _passwordCtrl.text, onSuccess: _onSuccess,
                            onFail: _onFail);
                      }
                    },
                    child: Text(
                      "Criar",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  )
                ],
              ),
            );
        },
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
        ),
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "O sistema não pôde criar o usuário",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
    ));

  }
}


