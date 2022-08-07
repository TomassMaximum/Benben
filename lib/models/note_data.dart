class NoteData {
  int id;
  int createdAt;
  int modifiedAt;
  List<SubNote> subNotes;
  int version;

  NoteData(this.id, this.createdAt, this.modifiedAt, this.subNotes, this.version);

  factory NoteData.fromJson(Map<String, dynamic> map, int id) {
    List<SubNote> _getSubNotes(List<dynamic> subNoteMaps) {
      List<SubNote> subNotes = <SubNote>[];
      for(dynamic subNote in subNoteMaps) {
        if(subNote['income'] != null) {
          subNotes.add(Income(subNote['title'], subNote['income'], subNote['order']));
        } else if(subNote['outcome'] != null) {
          subNotes.add(Outcome(subNote['title'], subNote['outcome'], subNote['order']));
        } else if(subNote['url'] != null) {
          subNotes.add(ImageNote(subNote['url'], subNote['imageData'], subNote['order']));
        } else if(subNote['text'] != null) {
          subNotes.add(TextNote(subNote['text'], subNote['order']));
        }
      }
      return subNotes;
    }

    return NoteData(
        id,
        map['createdAt'],
        map['modifiedAt'],
        _getSubNotes(map['subNotes']),
        map['version']);


  }

  Map<String, dynamic> toJson() => {
    'createdAt': createdAt,
    'modifiedAt': modifiedAt,
    'subNotes': subNotes.map((subNote) => subNote.toJson()).toList(),
    'version': version
  };
}

class SubNote {
  int order;

  SubNote(this.order);

  Map<String, dynamic> toJson() => {};

  SubNote.fromJson(Map<String, dynamic> map) : order = map['order'];
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

  @override
  factory Income.fromJson(Map<String, dynamic> map) {
    return Income(map['title'], map['income'], map['order']);
  }
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

  @override
  factory Outcome.fromJson(Map<String, dynamic> map) {
    return Outcome(map['title'], map['outcome'], map['order']);
  }
}

class TextNote extends SubNote {
  String text;

  TextNote(this.text, int order) : super(order);

  @override
  Map<String, dynamic> toJson() => {
    'text': text,
    'order': order
  };

  @override
  factory TextNote.fromJson(Map<String, dynamic> map) {
    return TextNote(map['text'], map['order']);
  }
}

class ImageNote extends SubNote {
  String url;
  String imageData;

  ImageNote(this.url, this.imageData, int order) : super(order);

  @override
  Map<String, dynamic> toJson() => {
    'url': url,
    'imageData': imageData,
    'order': order
  };

  @override
  factory ImageNote.fromJson(Map<String, dynamic> map) {
    return ImageNote(map['url'], map['imageData'], map['order']);
  }
}