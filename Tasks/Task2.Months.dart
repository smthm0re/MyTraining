// С помощью кейсов написать метод, который по номеру месяца выведет его письменное написание
import "dart:io";

int month = 0;

List<String> monthsList = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
  "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"];

Map<int, String> monthsMap = {
   1: "", 2: "", 3: "", 4: "", 5: "", 6: "",
   7: "", 8: "", 9: "", 10: "", 11: "", 12: ""
 };

void main(){
  fromListToMap(monthsList);
  try {
    inputMonth();
  } catch (e){
    print("Ошибка! Номер - это цифра!");
    return main();
  }
  numberByMonth(month);
  print('*' * 35);
  print('Далее вывод значений для теста:');
  for (int i = 1; i <= monthsMap.length; i++){
    print(monthsMap[i]);
  }
  print('*' * 35);
}

void fromListToMap(List<String> anyList){
  for (int i = 0; i < monthsList.length; i++){
    monthsMap.update(i + 1, (value) => monthsList[i]);
  }
}

void inputMonth(){
  print("Введите номер месяца:");
  int monthUser = int.parse(stdin.readLineSync()!);
  switch (monthsMap.containsKey(monthUser)){
    case false:
      print("Введён несуществующий номер!");
      return inputMonth();
    case true:
      month = monthUser;
  }
}

void numberByMonth(int key){
  for (int i = month; i <= month; i++){
    print(monthsMap[i]);
  }
}