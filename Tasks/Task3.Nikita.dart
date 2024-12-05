
String name = "Никита";

void main(){
  backwards2(name);
  myReversed(name);
}

// void backwards (String anyName){
//   List<String> letters = [];
//    for(int i = 0; i < name.length; i++) {
//      letters += [name[i]];
//    }
//    List<String> lettersBack = List.from(letters.reversed);
//    print(lettersBack.join());
// }

void backwards2 (String anyName){
  List<String> letters = [];
  for(int i = 0; i < name.length; i++){
    letters += [name[i]];
  }
}

void myReversed (String anyName){
  List<String> letters2 = [];
   for(int i = anyName.length - 1; i >= 0; i--){
     letters2.add(anyName[i]);
   }
   print(letters2.join());
 }
