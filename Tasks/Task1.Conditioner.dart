
List<String> history = [
  "Кондиционер включен! Так как температура 12 градусов и время 20 часов",
  "Кондиционер включен! Так как температура 13 градусов и время 20 часов",
  "Кондиционер включен! Так как температура 14 градусов и время 20 часов",
];

void main(){
  for(int i = 0; i < 10; i++){
    job(i+23, i+3);
  }
  show(history);
}

void job (int temp, int time){
  String res;
  if (((time >= 22 || time < 6) && temp > 12)
      || ((time >= 6 || time < 22) && (temp < 22 || temp > 26))){
   res = "Кондиционер включен! Так как температура $temp градусов и время $time часов";
   //print(res);
  } else {
    res = "Кондиционер выключен, так как температура $temp градусов и время $time часов";
    //print(res);
  }
  save(res);
}

void save (String res){
  history.add(res);
}

void show (List<String> arrayForShow){
  print('----------------------------');
  print('История');
  for (int i = 0; i < arrayForShow.length; i++){
    print(arrayForShow[i]);
  }
}