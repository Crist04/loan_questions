class QuestionModel {
  String? title;
  String? name;
  String? slug;
  String? description;
  Schemas? schemas;

  QuestionModel(
      {this.title, this.name, this.slug, this.description, this.schemas});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    schemas = json['schema'] != null ? Schemas.fromJson(json['schema']) : null;
  }
}

class Schemas {
  List<Fields>? fields;

  Schemas({this.fields});
  Schemas.fromJson(Map<String, dynamic> json) {
    if (json['fields'] != null) {
      fields = (json['fields'] as List).map((v) => Fields.fromJson(v)).toList();
    }
  }
}

class Schema {
  String? name;
  String? label;
  bool? hidden;
  bool? readonly;
  List<Options>? optionss;
  List<Fields>? fieldss;

  Schema(
      {this.name,
      this.label,
      this.hidden,
      this.readonly,
      this.optionss,
      this.fieldss});

  Schema.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    label = json['label'];
    if (json['hidden'] == "\${typeOFLoan !== 'balance-transfer-top-up'}") {
      hidden=true;
    }
    json['hidden'] == "\${typeOFLoan !== 'balance-transfer-top-up'}"?true:json['hidden'];
    
    readonly = json['readonly'];
    if (json['options'] != null) {
      optionss =
          (json['options'] as List).map((v) => Options.fromJson(v)).toList();
    }
    if (json['fields'] != null) {
      fieldss = (json['fields'] as List).map((v) => Fields.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['label'] = label;
    data['hidden'] = hidden;
    data['readonly'] = readonly;
    if (optionss != null) {
      data['options'] = optionss!.map((v) => v.toJson()).toList();
    }
    if (fieldss != null) {
      data['fields'] = fieldss!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fields {
  String? type;
  int? version;
  Schema? schema;

  Fields({this.type, this.version, this.schema});

  Fields.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    version = json['version'];
    schema = json['schema'] != null ? Schema.fromJson(json['schema']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['version'] = version;
    if (schema != null) {
      data['schema'] = schema!.toJson();
    }
    return data;
  }
}

class Options {
  String? key;
  String? value;

  Options({this.key, this.value});

  Options.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}
