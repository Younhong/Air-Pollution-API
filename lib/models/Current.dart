import 'package:air_pollution_api/models/Pollution.dart';
import 'package:air_pollution_api/models/Weather.dart';

class Current {
  Weather weather;
  Pollution pollution;

  Current({this.weather, this.pollution});

  Current.fromJson(Map<String, dynamic> json) {
    weather =
    json['weather'] != null ? Weather.fromJson(json['weather']) : null;
    pollution = json['pollution'] != null
        ? Pollution.fromJson(json['pollution'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.weather != null) {
      data['weather'] = this.weather.toJson();
    }
    if (this.pollution != null) {
      data['pollution'] = this.pollution.toJson();
    }
    return data;
  }
}