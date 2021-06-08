class TypeChamp {
  String name;
  List<String> options;

  TypeChamp({this.name, this.options});
}

class TypeVariable {
  String text;
  String boolean;
  String number;
  TypeVariable({this.text, this.number, this.boolean});
}



class Champ {
  TypeChamp typeChamp;
  TypeVariable typeVariable;
  Champ({this.typeChamp, this.typeVariable});
}

class Question {
  String intitule;
  Champ champ;
  Question({this.intitule, this.champ});
}

class Formulaire {
  String label;
  List<Question> questions;
  Formulaire({this.label, this.questions});
}