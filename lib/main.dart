import 'package:flutter/material.dart';
import 'package:form_generator/dialog_box.dart';
import 'package:form_generator/models/models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Form generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController titreFormController;
  GlobalKey<FormState> _form = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isthere = false;
  List<Question> questionnaires = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titreFormController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title, style: tStyle(),),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: (){
                  if(_form.currentState.validate()){

                  }
                },
                child: Text("Valider", style: tStyle(),)),
            ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: titreFormController,
                decoration: InputDecoration(
                  hintText: 'Titre du formulaire'
                ),
                validator: (titre){
                  if(titre.isEmpty)
                  return "Champ obligatoire*";
                  return null;
                },
              ),

              Container(
                height: MediaQuery.of(context).size.height - 500,
                child: ListView.builder(
                    itemCount: questionnaires.length,
                    itemBuilder: (_, index){
                      return Container();
                    }
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          DialogBox();
        },
        tooltip: 'nouveau',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  TextStyle tStyle(){
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15
    );
  }
}
