import 'package:flutter/material.dart';
import 'package:form_generator/add_form.dart';
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

  MyHomePage({Key key, this.title, this.question, this.questionnaires}) : super(key: key);

  final String title;
  Question question;
  List<Question> questionnaires;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController titreFormController, questionController;
  GlobalKey<FormState> _form = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isthere = false;
  String option;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titreFormController = new TextEditingController();
    questionController = new TextEditingController();
    if(widget.question != null){
      print(widget.question.intitule);
      print(widget.question.champ.typeVariable.text);
      print(widget.question.champ.typeChamp.name);
      if(widget.questionnaires != null){
        widget.questionnaires.add(widget.question);
      }else{
        widget.questionnaires = [];
        widget.questionnaires.add(widget.question);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Form generator', style: tStyle(),),
        centerTitle: false,
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
      body: Form(
        key: _form,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
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
            ),
            widget.questionnaires != null?Container(
              height: MediaQuery.of(context).size.height -  500,
              child: ListView.builder(
                  itemCount: widget.questionnaires.length,
                  itemBuilder: (_, index){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${widget.questionnaires[index].intitule}"),
                          getTypeChamp(widget.questionnaires[index].champ.typeChamp.name, null),
                        ],
                      ),
                    );
                  }
              ),
            ):Container(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text("Ajouter une nouvelle question", style: TextStyle(
                  color: Colors.black
                ),),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddForm(question: widget.question, options: [], questionnaires: widget.questionnaires,)));
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

  Widget getTypeChamp(String type, List<String> _options){
    Widget _widget;
    switch(type){
      case 'Zone de texte':
        _widget = Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                  color: Colors.grey.withOpacity(.3),
                  width: 1
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Réponse'
              ),
            ),
          ),
        );
        break;
      case 'Liste déroulante':
        _widget = Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                  color: Colors.grey.withOpacity(.3),
                  width: 1
              )
          ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                underline: Container(),
                icon: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: new Icon(Icons.arrow_drop_down_circle),
                ),
                isDense: false,
                elevation: 1,
                isExpanded: true,
                onChanged: (String selected){
                  setState(() {
                    option = selected;
                  });
                },
                value: option,
                hint: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text('Type de champ',
                    style: dStyle(Colors.grey),),
                ),
                items: widget.question.champ.typeChamp.options.map((String name){
                  return DropdownMenuItem<String>(
                    value: name,
                    child: Padding(
                      padding:EdgeInsets.only(left: 15),
                      child: Text(name,
                        style: dStyle(Colors.black),),
                    ),
                  );
                }).toList(),
              )
          ),
        );
        break;
      case 'Case à cocher':
        //_widget = ;
        break;
      case 'Choix multiple':
        //_widget = ;
        break;
    }
    return _widget;
  }

  TextStyle dStyle(Color color) {
    return TextStyle(
        color: color
    );
  }
}
