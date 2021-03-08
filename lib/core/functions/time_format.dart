String formatTime (int number){
  if(number >= 10)
    return number.toString();
  else return '0$number';
}