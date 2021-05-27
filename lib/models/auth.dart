class AuthModel {
  String id;
  String userEmail;
  String userNicename;
  String userDisplayName;
  String avatar;

  AuthModel(
      {this.id,
      this.userEmail,
      this.userNicename,
      this.userDisplayName,
      this.avatar});

  AuthModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userEmail = json['user_email'];
    userNicename = json['user_nicename'];
    userDisplayName = json['user_display_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_email'] = this.userEmail;
    data['user_nicename'] = this.userNicename;
    data['user_display_name'] = this.userDisplayName;
    data['avatar'] = this.avatar;
    return data;
  }
}
