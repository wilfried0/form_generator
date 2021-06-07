class TypeChamp {
  String name;
  String label;
  List<String> options;

  TypeChamp({this.name, this.label, this.options});
}

class TypeVariable {
  bool isText;
  TypeVariable({this.isText});
}



class Champ {
  TypeChamp typeChanmp;
  TypeVariable typeVariable;
  Champ({this.typeChanmp, this.typeVariable});
}

class Question {
  String intitule;
  Champ champ;
}

class Formulaire {
  String label;
  List<Question> questions;
  Formulaire({this.label, this.questions});
}