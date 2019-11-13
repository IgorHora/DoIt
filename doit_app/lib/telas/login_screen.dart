import 'package:doit_app/models/user_model.dart';
import 'package:doit_app/telas/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //key para validação do formulário
  final _formKey = GlobalKey <FormState>();
  final _scaffoldKey = GlobalKey <ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC1DDCC),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
            "Entrar"
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Criar Conta",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            textColor: Colors.white,
            //substitui a tela de login pela cadastro
            onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=>SignupScreen())
              );
            },
          )
        ],
      ),
      //validar dados do login
      body: ScopedModelDescendant<UserModel>(
        builder: (context,child, model){
          if (model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          else
            return Form(
              key: _formKey,
              //rola tela caso o teclado cubra os campos
              child: ListView(
                padding: EdgeInsets.all(18.0),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    //exibe teclado com @
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (email){
                      if (email.isEmpty || !email.contains("@"))
                        return "Email inválido!";
                    },
                    decoration: InputDecoration(
                      hintText: "Insira seu email",
                    ),
                  ),
                  SizedBox(height: 18.0,),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    // ignore: missing_return
                    validator: (senha){
                      if (senha.isEmpty || senha.length < 6)
                        return "Senha inválida!";
                    },
                    decoration: InputDecoration(
                        hintText: "Insira sua senha"
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: (){
                        if(_emailController.text.isEmpty)
                          {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Insira seu email para recuperar a senha",
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }//if
                        else {
                          model.recoverPassword(_emailController.text);
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                                "Verifique sua caixa de email!",
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  SizedBox(height: 18.0,),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      //verifica validação do formulário
                      if(_formKey.currentState.validate()){

                      }
                      model.signIn(
                          email: _emailController.text,
                          password: _passwordController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail);
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
        },
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
              "Erro de Login!",
              textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
    );

  }



}
