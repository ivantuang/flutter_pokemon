///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class PokemonModel {

  int? id;
  String? name;
  String? desc;
  bool? isFav;

  PokemonModel({
    this.id,
    this.name,
    this.desc,
    this.isFav = false,
  });

  PokemonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']?.toString();
    desc = json['desc']?.toString();
    isFav = json['isFav'] == 1;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['isFav'] = isFav! ? 1 : 0;
    return data;
  }

  /// To update model isFav
  updateFav() {
    isFav = !isFav!;
  }
}
