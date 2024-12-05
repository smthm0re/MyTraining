import 'dart:io';

int repeatCheck = 0;
int requisite = 0;
String result = "";

List<String> history = [];

Map<int, int> server = {};
Map<int, int> passwords = {};

Machine cashMachine = Machine(cash: 0);

Card cardNumber1 = Card(client: "Никита", requisite: 111222, pin: 7777);
Card cardNumber2 = Card(client: "Иван", requisite: 888999, pin: 1111);

void main (){
  addToServer(cardNumber1);
  addToServer(cardNumber2);
  print("Здравствуйте!");
  verification();
  completeTask();
  info();
}

class Machine {
  Machine({required this.cash});
  int cash;

  void takeCash(){
    print("Введите сумму");
    int inputMoney = int.parse(stdin.readLineSync()!);
    if (server[requisite]! < inputMoney){
      print("Для снятия $inputMoney р. недостаточно средств на Вашей карте.");
      return completeTask();
    } else if (cash < inputMoney){
      print("Извините, в банкомате закончились деньги.");
      return completeTask();
    } else {
      cash -= inputMoney;
      server.update(requisite, (value) => (value) - inputMoney);
      print("Выполнено!");
      result = "Вы получили $inputMoney р. со счета $requisite.";
      history.add(result);
    }
  }

  void depositCash(){
    print("Введите сумму");
    int inputMoney = int.parse(stdin.readLineSync()!);
    cash += inputMoney;
    server.update(requisite, (value) => (value) + inputMoney);
    print("Выполнено!");
    result = "Вы внесли $inputMoney р. на счет $requisite.";
    history.add(result);
  }

  void translation(){
    print("Пожалуйста, введите реквизиты получателя:");
    int requisiteAddress = int.parse(stdin.readLineSync()!);
    print("Введите сумму");
    int inputMoney = int.parse(stdin.readLineSync()!);
    if (server[requisite]! < inputMoney){
      print("Для перевода $inputMoney р. недостаточно средств на Вашей карте.");
      return completeTask();
    } else {
      server.update(requisite, (value) => (value) - inputMoney);
      server.update(requisiteAddress, (value) => (value) + inputMoney);
      print("Выполнено!");
      result = "Вы перевели $inputMoney р. со счета $requisite на счет $requisiteAddress.";
      history.add(result);
    }
   }
}

class Card {
  Card({
    required this.client,
    required this.requisite,
    required this.pin,
  });

  final String client;
  final int pin;
  final int requisite;
}

void addToServer (Card cardNumber) {
  server[cardNumber.requisite] = 0;
  passwords[cardNumber.requisite] = cardNumber.pin;
}

void verification (){
  try {
    inputCardDetails();
  } catch(e){
    print("Неверный формат. Повторите снова.");
    print("*" * 50);
    return verification();
  }
}

void inputCardDetails () {
  print("Пожалуйста, введите реквизиты карты:");
  int requisiteUser = int.parse(stdin.readLineSync()!);
  switch (server.containsKey(requisiteUser)) {
    case false:
      print("Недействительный номер карты. Повторите снова.");
      print("*" * 50);
      return verification();
    case true:
      requisite = requisiteUser;
      print("Пожалуйста, введите пин-код:");
      int pinUser = int.parse(stdin.readLineSync()!);
      switch (pinUser == passwords[requisiteUser]!) {
        case false:
          repeatCheck += 1;
          print("Введен неверный пин-код! Попытка $repeatCheck из 3");
          print("*" * 50);
          if (repeatCheck == 3){
            print("Карта заблокирована!");
            print("Завершение работы...");
            exit(0);
          };
          return verification();
        case true:
          repeatCheck = 0;
          print("Успешный вход в систему.");
      }
  }
}

void completeTask (){
  try {
    inputTask();
    replay();
  } catch(e){
    print("*" * 50);
    print("Неверный запрос. Повторите снова.");
    print("*" * 50);
    return inputTask();
  }
}

void inputTask () {
  List<String> tasksList = ["deposit", "take cash", "translation"];
  print("Введите Ваш запрос: " + tasksList.toString());
  String? inputTask = stdin.readLineSync();
  if (inputTask == "deposit") {
    try {
      cashMachine.depositCash();
    } catch (e) {
      print("Ошибка. Повторите снова.");
      print("*" * 50);
      return completeTask();
    }
  } else if (inputTask == "take cash") {
    try {
      cashMachine.takeCash();
    } catch (e) {
      print("Ошибка. Повторите снова.");
      print("*" * 50);
      return completeTask();
    }
  } else if (inputTask == "translation") {
    try {
      cashMachine.translation();
    } catch (e) {
      print("Ошибка. Повторите снова.");
      print("*" * 50);
      return completeTask();
    }
  } else {
    print("Введен недействительный запрос. Повторите снова.");
    return completeTask();
  }
}

void replay (){
  List<String> answerList = ["yes", "no"];
  print("Завершить выполнение? " + answerList.toString());
  String? inputAnswer = stdin.readLineSync();
  if (inputAnswer == "yes"){
    print("Завершение работы...");
  } else if (inputAnswer == "no"){
    return completeTask();
  } else {
    print("Введите yes или no");
    return(replay());
  }
}

void info () {
  print("*" * 50);
  show(history);
  print("*" * 50);
  print("Проверка:");
  print("в банкомате: " + cashMachine.cash.toString() + " рублей.");
  print("на сервере: " + server.toString());
}

void show (List<String> arrayForShow){
  print("История операций:");
  for (int i = 0; i < arrayForShow.length; i++){
    print(arrayForShow[i]);
  }
  print("Баланс: " + server[requisite].toString() + " р.");
  print("*" * 50);
}