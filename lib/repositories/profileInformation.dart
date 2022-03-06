class ProfileInfo{
  late String email;
  late String name;
  late String surname;
  late String gender;
  late int height;
  late int weight;
  late int dailyActivity;

  ProfileInfo(this.email,this.name,this.surname,this.gender,this.height,this.weight,this.dailyActivity);
  void printInfo()
  {
    print("name: "+name);
    print("surname: "+surname);
    print("gender: "+gender);
    print("height: "+height.toString());
    print("weight: "+weight.toString());
    print("gender: "+gender);
    print("dailyActivity: "+dailyActivity.toString());

  }
}
ProfileInfo person1=ProfileInfo("email","Meriç","Karadayı","WOMAN",174,65,4);