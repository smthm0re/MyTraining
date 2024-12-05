import "dart:io";

List<String> history = [];
String res = "";
int temp = 0;
int time = 0;

void main(){
  input();
  condition();
  save();
  replay();
}

void input(){
  try {
    inputTemp();
  } catch(e){
    print("Ошибка ввода температуры!");
    return input();
  }
  try {
    inputTime();
  } catch(e){
    print("Ошибка ввода времени!");
    return input();
  }
}

void inputTemp(){
  print("Введите температуру:");
  int tempUser = int.parse(stdin.readLineSync()!);
  if (tempUser < -90 || tempUser > 58){
    print("Введите корректную температуру!");
    return (inputTemp());
  } else {
    temp = tempUser;
  }
}

void inputTime(){
  print("Введите время:");
  int? timeUser = int.tryParse(stdin.readLineSync()!);
  if (timeUser! < 0 || timeUser > 24){
    print("Введите корректное время!");
    return (inputTime());
  } else {
    time = timeUser;
  }
}

void condition(){
  if (((time >= 22 || time < 6) && temp > 12)
      || ((time >= 6 || time < 22) && (temp < 22 || temp > 26))){
    res = "Температура: $temp°, Время: $time ч., В работе!";
  } else {
    res = "Температура: $temp°, Время: $time ч., Выключен.";
  }
}

void save (){
  print("Сохранить результат? (yes/no)");
  String? inputAnswer = stdin.readLineSync();
    if (inputAnswer == "yes"){
      print("Добавлено успешно!");
      history.add(res);
      show(history);
    } else if (inputAnswer == "no"){
      return;
    } else {
      print("Введите yes или no");
      return(save());
    }
}

void replay (){
  print("Завершить выполнение? (yes/no)");
  String? inputAnswer = stdin.readLineSync();
  if (inputAnswer == "yes"){
    print("Программа завершена. Всего хорошего!");
  } else if (inputAnswer == "no"){
    return(main());
  } else {
    print("Введите yes или no");
    return(replay());
  }
}

void show (List<String> arrayForShow){
  print('----- Значения из памяти: -----');
  for (int i = 0; i < arrayForShow.length; i++){
    print(arrayForShow[i]);
  }
}