class Note {
  String? id;
  String titleNote;
  String descriptionNote;

  Note({
    this.id,
    required this.titleNote,
    required this.descriptionNote,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
      id: json["id"],
      titleNote: json["title_note"],
      descriptionNote: json["description_note"]);

  Map<String, dynamic> toJson() =>
      {"title_note": titleNote, "description_note": descriptionNote};
}
