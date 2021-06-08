import 'package:flutter/material.dart';
import 'package:form_generator/add_form.dart';
import 'package:form_generator/models/models.dart';

class AddOption extends StatefulWidget {
  Question question;
  List<String> options;
  AddOption({this.question, this.options, this.questionnaires});
  List<Question> questionnaires;

  @override
  _AddOptionState createState() => _AddOptionState();
}

class _AddOptionState extends State<AddOption> {
  GlobalKey<FormState> _form = new GlobalKey<FormState>();

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
      body: Center(
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Intitulé de l\'option'
                  ),
                  validator: (option){
                    if(option.isEmpty)
                      return 'Champ obligatoire';
                    else{
                      if(widget.options == null){
                        widget.options = [];
                        widget.options.add(option);
                      }else{
                        widget.options.add(option);
                      }
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20,),

                InkWell(
                  onTap: (){
                    if(_form.currentState.validate()){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> AddForm(options: widget.options, question: widget.question, questionnaires: widget.questionnaires,)));
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
      ),
    );
  }

  TextStyle tStyle(Color color) {
    return TextStyle(
        color: color
    );
  }
}
