class NoteData {
  int timestamp;
  List<SubNote> subNotes;
  int version;

  NoteData(this.timestamp, this.subNotes, this.version);
}

class SubNote {
  int order;

  SubNote(this.order);
}

class Income extends SubNote {
  String title;
  double income;

  Income(this.title, this.income, int order) : super(order);
}

class Outcome extends SubNote {
  String title;
  double outcome;

  Outcome(this.title, this.outcome, int order) : super(order);
}

class TextNote extends SubNote {
  String text;

  TextNote(this.text, int order) : super(order);
}

class ImageData extends SubNote {
  String url;

  ImageData(this.url, int order) : super(order);
}