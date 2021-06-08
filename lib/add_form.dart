import 'package:flutter/material.dart';
import 'package:form_generator/add_options.dart';
import 'package:form_generator/main.dart';
import 'package:form_generator/models/models.dart';


class AddForm extends StatefulWidget {

  Question question;
  List<String> options;
  AddForm({this.question, this.options, this.questionnaires});
  List<Question> questionnaires;

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  GlobalKey<FormState> _form = new GlobalKey<FormState>();
  String titre, type_var, type_champ;
  bool _isOptions = false;
  List<String> option = [];
  int i = 0;
  var _type_vars = ['Nombre', 'Chaine de caractère', 'Date'];
  var _type_champ = ['Zone de texte', 'Liste déroulante', 'Case à cocher', 'Choix multiple'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Affiche();
  }

  Affiche(){
    if(widget.questionnaires != null)
      for(int i=0; i<widget.questionnaires.length; i++)
        print(widget.questionnaires[i].champ.typeChamp.name);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isOptions == true?Align(
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    Text("Ajouter les options"),
                    IconButton(
                        icon: Icon(Icons.add, color: Colors.blue,),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AddOption(question: widget.question, options: widget.options, questionnaires: widget.questionnaires,)));
                        }
                    ),
                  ],
                ),
              ):Container(),

              TextFormField(
                controller: widget.question == null?null: TextEditingController(text: widget.question.intitule),
                decoration: InputDecoration(
                    hintText: 'Intitulé de la question'
                ),
                validator: (titre){
                  if(titre.isEmpty)
                    return 'Champ obligatoire';
                  else
                    this.titre = titre;
                  return null;
                },
              ),
              DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: new Icon(Icons.arrow_drop_down_circle),
                    ),
                    isDense: false,
                    elevation: 1,
                    isExpanded: true,
                    onChanged: (String selected){
                      setState(() {
                        type_var = selected;
                      });
                    },
                    value: type_var,
                    hint: Text('Type de la variable',
                      style: tStyle(Colors.grey),),
                    items: _type_vars.map((String name){
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(name,
                          style: tStyle(Colors.black),),
                      );
                    }).toList(),
                  )
              ),
              DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: new Icon(Icons.arrow_drop_down_circle),
                    ),
                    isDense: false,
                    elevation: 1,
                    isExpanded: true,
                    onChanged: (String selected){
                      setState(() {
                        type_champ = selected;
                        if(type_champ == 'Zone de texte' || type_champ == null){
                          _isOptions = false;
                        }else {
                          _isOptions = true;
                        }
                      });
                    },
                    value: type_champ,
                    hint: Text('Type de champ',
                      style: tStyle(Colors.grey),),
                    items: _type_champ.map((String name){
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(name,
                          style: tStyle(Colors.black),),
                      );
                    }).toList(),
                  )
              ),
              widget.options != null?DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: new Icon(Icons.arrow_drop_down_circle),
                    ),
                    isDense: false,
                    elevation: 1,
                    isExpanded: true,
                    onChanged: (String selected){
                      setState(() {
                        option[i] = selected;
                        i++;
                      });
                    },
                    value: option[i],
                    hint: Text('Options',
                      style: tStyle(Colors.grey),),
                    items: widget.options.map((String name){
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(name,
                          style: tStyle(Colors.black),),
                      );
                    }).toList(),
                  )
              ):Container(),

              InkWell(
                onTap: (){
                  if(_form.currentState.validate()){
                    //this.question.intitule = this.titre;
                    TypeChamp typeChamp = new TypeChamp(
                        name: type_champ,
                        options: widget.options
                    );
                    TypeVariable typeVariable = new TypeVariable(
                        text: type_var
                    );
                    widget.question = new Question(
                        intitule: this.titre,
                        champ: new Champ(
                            typeChamp: typeChamp,
                            typeVariable: typeVariable
                        )
                    );
                    //this.question.champ.typeChamp = typeC
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> MyHomePage(question: widget.question, questionnaires: widget.questionnaires,)));
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(child: Text("Valider", style: tStyle(Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle tStyle(Color color) {
    return TextStyle(
        color: color
    );
  }
}