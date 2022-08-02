class NoteData {
  int timestamp;
  List<SubNote> subNotes;
  int version;

  NoteData(this.timestamp, this.subNotes, this.version);

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp,
    'subNotes': subNotes.map((subNote) => subNote.toJson()).toList(),
    'version': version
  };
}

class SubNote {
  int order;

  SubNote(this.order);

  Map<String, dynamic> toJson() => {};
}

class Income extends SubNote {
  String title;
  double income;

  Income(this.title, this.income, int order) : super(order);

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'income': income,
    'order': order
  };
}

class Outcome extends SubNote {
  String title;
  double outcome;

  Outcome(this.title, this.outcome, int order) : super(order);

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'outcome': outcome,
    'order': order
  };
}

class TextNote extends SubNote {
  String text;

  TextNote(this.text, int order) : super(order);

  @override
  Map<String, dynamic> toJson() => {
    'text': text,
    'order': order
  };
}

class ImageNote extends SubNote {
  String url;

  ImageNote(this.url, int order) : super(order);

  @override
  Map<String, dynamic> toJson() => {'url': url};
}