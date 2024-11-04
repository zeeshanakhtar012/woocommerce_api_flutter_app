/// change_language : "Change Language"

class EnUs {
  EnUs({
      String? changeLanguage,}){
    _changeLanguage = changeLanguage;
}

  EnUs.fromJson(dynamic json) {
    _changeLanguage = json['change_language'];
  }
  String? _changeLanguage;
EnUs copyWith({  String? changeLanguage,
}) => EnUs(  changeLanguage: changeLanguage ?? _changeLanguage,
);
  String? get changeLanguage => _changeLanguage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['change_language'] = _changeLanguage;
    return map;
  }

}