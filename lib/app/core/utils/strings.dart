String removeDiacritics(String string) {

  var withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  var withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz'; 

  for (int i = 0; i < withDia.length; i++) {      
    string = string.replaceAll(withDia[i], withoutDia[i]);
  }

  return string;

}

String capitalizeAndNoDiacritics (String string) {
  return removeDiacritics(string.toLowerCase());
}