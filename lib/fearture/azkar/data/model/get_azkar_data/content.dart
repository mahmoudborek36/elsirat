class Content {
  String? zekr;
  int? repeat;
  String? bless;

  Content({this.zekr, this.repeat, this.bless});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        zekr: json['zekr'] as String?,
        repeat: json['repeat'] as int?,
        bless: json['bless'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'zekr': zekr,
        'repeat': repeat,
        'bless': bless,
      };
}
