/// change_language : "Changer de langue"

class FrFr {
  FrFr({
      String? changeLanguage,}){
    _changeLanguage = changeLanguage;
}

  FrFr.fromJson(dynamic json) {
    _changeLanguage = json['change_language'];
  }
  String? _changeLanguage;
FrFr copyWith({  String? changeLanguage,
}) => FrFr(  changeLanguage: changeLanguage ?? _changeLanguage,
);
  String? get changeLanguage => _changeLanguage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['change_language'] = _changeLanguage;
    return map;
  }

}