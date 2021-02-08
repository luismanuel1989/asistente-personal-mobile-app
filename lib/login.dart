import 'package:controlVoiceApp/home.dart';
import 'package:controlVoiceApp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,designSize: Size(375,812),allowFontScaling: false);
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    final minHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 0,right: 0,top: ScreenUtil().setHeight(64)),
                  alignment: Alignment.center,
                  child: Text("Log In",style: TextStyle(fontSize: 20,fontFamily: "Lato",fontWeight: FontWeight.normal),textAlign: TextAlign.center),
                ),
                Container(

                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(16),right: ScreenUtil().setWidth(16),top: ScreenUtil().setHeight(157)),
                    height: ScreenUtil().setHeight(50),

                    child: TextField(

                      style: TextStyle(fontFamily: "Lato",fontSize: 16,color:  Colors.black),
                      controller: _emailController,

                      onSubmitted: (String value) async{ await
                      print("d");
                      },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Color(0xFFBDBDBD),fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(16),fontFamily: "Lato-Black"),
                          fillColor: Color.fromRGBO(246, 246, 246, 1),
                          filled: true,
                          labelText: "Email",
                          //Border for focus component
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(232, 232, 232, 1)),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10)
                              )
                          ),
                          //Border for enable component
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(232, 232, 232, 1)),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10)
                              )
                          ),

                          //Border for disable component
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(232, 232, 232, 1)),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10)
                              )
                          )
                      ),

                    )

                ),
                Container(

                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(16) ,right: ScreenUtil().setWidth(16),top: ScreenUtil().setHeight(8)),
                  height: ScreenUtil().setHeight(50),

                  child:    TextField(

                    style: TextStyle(fontFamily: "Lato",fontSize: 16,color:  Colors.black),
                    controller: _passwordController,
                    onSubmitted: (String value) async{ await
                    print("d");
                    },
                    decoration: InputDecoration(
                        fillColor: Color.fromRGBO(246, 246, 246, 1),
                        filled: true,
                        labelStyle: TextStyle(color: Color(0xFFBDBDBD),fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(16),fontFamily: "Lato-Black"),
                        labelText: "Password",
                        // suffixText: "Show",
                        suffix: Container(
                          margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                          child: Text("Show",style:  TextStyle(color: Color.fromRGBO(244, 157, 63, 1),fontSize: 16,fontFamily: "Lato-Black"),),
                        ),
                        // suffixStyle: TextStyle(color: Color.fromRGBO(244, 157, 63, 1),fontSize: 16,fontFamily: "Lato-Black"),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(232, 232, 232, 1)),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(232, 232, 232, 1)),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)
                            )
                        ),


                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(232, 232, 232, 1)),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)
                            )
                        )
                    ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(16),right: ScreenUtil().setWidth(16),top: ScreenUtil().setHeight(48)),
                  child: SizedBox(
                      height: ScreenUtil().setHeight(51),
                      //width of the parent widget
                      width: double.infinity,
                      child:  FlatButton(
                        color: Color.fromRGBO(244, 200, 63, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            side: BorderSide(color: Color.fromRGBO(244, 157, 63, 1))
                        ),

                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        },


                        child: Text("Login",style: TextStyle(fontSize: 18,fontFamily: "Lato",fontWeight: FontWeight.normal,color: Colors.white)),

                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(16),right: ScreenUtil().setWidth(16),top: 0),
                  child: SizedBox(
                      height: ScreenUtil().setHeight(51),
                      width: double.infinity,
                      child:  FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            side: BorderSide(color: Colors.white)
                        ),
                        onPressed: (){
                          /*
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen())
                          );

                           */
                        },
                        child: Text("Forgot password?",style: TextStyle(fontSize: 18,fontFamily: "Lato",fontWeight: FontWeight.normal,color: Color(0xFFF49D3F),)),

                      )
                  ),
                )


              ])),
    );

  }
}
