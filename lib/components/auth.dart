import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/components/admin.dart';
import 'package:spotify_clone/components/spotify_home.dart';
import 'package:spotify_clone/logic/admin_logic.dart';
import 'package:spotify_clone/logic/auth_logic.dart';
import 'package:spotify_clone/logic/basic_ui.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future onloadDecider() async {
    User user = FirebaseAuth.instance.currentUser;
    if(user == null){
      print("No User");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Material(
        child: ChangeNotifierProvider(
          create: (_)=>SessionManagement(),
          child: FirebaseSession(),
        ),
      )));
    }else{
      print("Current User : "+user.uid);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Material(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=>SessionManagement(),),
          ],
          child: SpotifyHome(),
        ),
      )));
    }
  }
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), (){
      onloadDecider();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset("./images/spotify_logo_title.png"),
      ),
    );
  }
}

class FirebaseSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 0, 254, 100),
              Color.fromRGBO(51, 51, 153, 100),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        ),
        child: AuthUI(),
      )
    );
  }
}

class AuthUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('./images/spotify_logo_banner_black.png', height: MediaQuery.of(context).size.height*0.12,),
          Text("Millions of songs. \n Free on Spotify.", style: TextStyle(
            fontFamily: 'Proxima Nova',
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
          ),),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Continue with", style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0,
                ),),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupOrLogin()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.mail_outline, color: Colors.black,),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text("EMAIL", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),),
                      ],
                    ),
                  )
                ),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(
                      child: ChangeNotifierProvider(
                        create: (_)=>Admin(),
                        child: SpotifyAdmin(),
                      ),
                    )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.mail_outline, color: Colors.black,),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text("Admin", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),),
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignupOrLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 0, 254, 100),
              Color.fromRGBO(51, 51, 153, 100),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Email", style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'Proxima Nova Bold',
              ),),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(
                    child: MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (_)=>CreateUserAccount(),),
                        ChangeNotifierProvider(create: (_)=>ShowCustomAlertDialog(),),
                      ],
                      child: CreateAccount(),
                    ),
                  )));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 300.0,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Text("SIGN UP FREE", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      color: Colors.grey,
                      height: 2.0,
                      width: MediaQuery.of(context).size.width*0.35,
                    ),
                    Text("OR", style: TextStyle(
                      color: Colors.grey,
                    ),),
                    Container(
                      alignment: Alignment.center,
                      color: Colors.grey,
                      height: 2.0,
                      width: MediaQuery.of(context).size.width*0.35,
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(
                    child: MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (_)=>LoginLogic(),),
                        ChangeNotifierProvider(create: (_)=>ShowCustomAlertDialog(),),
                      ],
                      child: LoginPage(),
                    ),
                  )));
                },
                child: Container(
                  width: 300.0,
                  padding: EdgeInsets.all(12.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Text("LOG IN", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionObj = Provider.of<CreateUserAccount>(context);
    final uiComponents = Provider.of<ShowCustomAlertDialog>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text("Create account", style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: PageView(
        controller: sessionObj.pctrl,
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("What's your email?",style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Proxima Nova Bold',
                ),),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder()
                  ),
                  onChanged: (String text){
                    sessionObj.emailNextButtonListener(text);
                    sessionObj.email = text;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(45.0, 15.0, 45.0, 15.0),
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      sessionObj.emailNextEnabled ? sessionObj.pctrl.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn) : uiComponents.showCustomDialog(context, "Please Enter your Email");
                    },
                    color: sessionObj.emailNextEnabled ? Colors.white : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text("NEXT", style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: 'Proxima Nova Bold'
                    ),),
                  ),
                )
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Create a Password",style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Proxima Nova Bold',
                ),),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  obscureText: !sessionObj.showPassword,
                  autofocus: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: (){
                        sessionObj.showPassFun();
                      },
                      icon: sessionObj.showPassword ? Icon(Icons.visibility, color: Colors.white,) : Icon(Icons.visibility_off , color: Colors.white,),
                    )
                  ),
                  onChanged: (String text){
                    sessionObj.passNextButtonListener(text);
                    sessionObj.password = text;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(45.0, 15.0, 45.0, 15.0),
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      sessionObj.passNextEnabled ? sessionObj.pctrl.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn) : uiComponents.showCustomDialog(context, "Password must of atleast 8 Charecters") ;
                    },
                    color: sessionObj.passNextEnabled ? Colors.white : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text("NEXT", style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: 'Proxima Nova Bold'
                    ),),
                  ),
                )
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("What's your name?",style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Proxima Nova Bold',
                ),),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String text){
                    sessionObj.nameNextButtonListener(text);
                    sessionObj.name = text;
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 5.0),
                  child: Text("This appears on your Spotify profile."),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: sessionObj.isCreatingAccount ? CircularProgressIndicator() : RaisedButton(
                    padding: EdgeInsets.fromLTRB(45.0, 15.0, 45.0, 15.0),
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      sessionObj.nameNextEnabled ? sessionObj.signUp(context ,sessionObj.name ,sessionObj.email, sessionObj.password) : uiComponents.showCustomDialog(context, "Name should be atleast 6 Charecters");
                    },
                    color: sessionObj.nameNextEnabled ? Colors.white : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text("Create", style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: 'Proxima Nova Bold'
                    ),),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("By creating an account, you agree to Spotify's Terms of Service.", textAlign: TextAlign.center,),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("To learn more about how Spotify collects, uses, shares and protects your personal data please read Spotify's Privacy Policy", textAlign: TextAlign.center,),
                    ],
                  ),
                )
              ],
            ),
          ),



        ],
      ),
    );
  }
}


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginLogic = Provider.of<LoginLogic>(context);
    final uiComponents = Provider.of<ShowCustomAlertDialog>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Email or userame", style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'Proxima Nova Bold',
            ),),
            SizedBox(
              height: 5.0,
            ),
            TextFormField(
              autofocus: false,
              decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16.0),
              fillColor: Colors.grey,
              filled: true,
                border: OutlineInputBorder(),
              ),
              onChanged: (String text){
                loginLogic.email = text;
                loginLogic.loginButtonListener(loginLogic.email, loginLogic.password);
              },
            ),

            SizedBox(
              height: 30.0,
            ),


            Text("Password", style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'Proxima Nova Bold',
            ),),
            SizedBox(
              height: 5.0,
            ),
            TextFormField(
              obscureText: !loginLogic.showPassword,
              autofocus: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                fillColor: Colors.grey,
                filled: true,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: (){
                    loginLogic.showPassFun();
                  },
                  icon: loginLogic.showPassword ? Icon(Icons.visibility, color: Colors.white,) : Icon(Icons.visibility_off , color: Colors.white,),
                )
              ),
              onChanged: (String text){
                  loginLogic.password = text;
                  loginLogic.loginButtonListener(loginLogic.email, loginLogic.password);
                },
              ),

              SizedBox(
                height: 20.0,
              ),

            Center(
                  child: loginLogic.isAuthenticating ? CircularProgressIndicator() : RaisedButton(
                    padding: EdgeInsets.fromLTRB(45.0, 15.0, 45.0, 15.0),
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      loginLogic.loginButton ? loginLogic.loginIn(context, loginLogic.email, loginLogic.password) : uiComponents.showCustomDialog(context, "Enter your Email and Password") ;
                    },
                    color: loginLogic.loginButton ? Colors.white : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text("LOG IN", style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: 'Proxima Nova Bold'
                    ),),
                  ),
                ),

                SizedBox(
                  height: 30.0,
                ),

            Center(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(
                    child: ChangeNotifierProvider(create: (context)=>ForgotPassword(), child: PasswordRecovery(),),
                  )));
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 7.0, 30.0, 7.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: Text("FORGOT YOUR PASSWORD?", style: TextStyle(
                    fontFamily: 'Proxima Nova Bold',
                    fontSize: 14.0,
                  ),),
                ),
              ),
            ),
                        
          ],
        ),
      ),
    );
  }
}


class PasswordRecovery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final forgotObj = Provider.of<ForgotPassword>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text("Forgot your password?", style: TextStyle(
          fontFamily: 'Proxima Nova Bold',
        ),),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Email or username", style: TextStyle(
              fontFamily: 'Proxima Nova Bold',
              fontSize: 35.0,
            ),),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                focusColor: Colors.black,
                contentPadding: EdgeInsets.all(16.0),
                fillColor: Colors.grey,
                filled: true,
                border: OutlineInputBorder(),
                disabledBorder: InputBorder.none,
              ),
              onChanged: (String text){
                forgotObj.buttonActivateListener(text);
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            Text("We'll send a link to your email that will log you in."),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(35.0, 20.0, 35.0, 20.0),
                color: forgotObj.getLinkEnable ? Colors.white : Colors.grey,
                onPressed: ()async{
                  forgotObj.getLinkEnable ? (await forgotObj.sendEmail(context ,forgotObj.email)) ? forgotObj.showCustomAlertDialog.showCustomDialog(context, "An Email was sent to you to reset your Password, Check your inbox.") : print("Something went wrong") : forgotObj.showCustomAlertDialog.showCustomDialog(context, "Please enter valid Email");
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Text("GET LINK", style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Proxima Nova Bold',
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}