
class Weather {
  String ts;
  int hu;
  String ic;
  int pr;
  int tp;
  int wd;
  double ws;

  Weather({this.ts, this.hu, this.ic, this.pr, this.tp, this.wd, this.ws});

  Weather.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    hu = json['hu'];
    ic = json['ic'];
    pr = json['pr'];
    tp = json['tp'];
    wd = json['wd'];
    ws = json['ws'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ts'] = this.ts;
    data['hu'] = this.hu;
    data['ic'] = this.ic;
    data['pr'] = this.pr;
    data['tp'] = this.tp;
    data['wd'] = this.wd;
    data['ws'] = this.ws;
    return data;
  }
}