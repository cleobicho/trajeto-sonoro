void cronometroGeral () {
  //cronometro (mapeamento de dados)
  Date cronometroMap = new Date(cronometro); //converte de long (que é um número em timestampMs) para data internacional
  String cronometroString = (cronometroMap.toLocaleString()); //converte a data internacional para data nacional

  //display cronometro
  textSize(18);
  textFont(campton);
  textAlign(LEFT, BOTTOM);
  fill(0);
  text(cronometroString, width - 210, height - distMargem);
  //incrementa o cronometro, fazendo a hora voltar (no caso, decrementa com um valor negativo)
  cronometro = cronometro + incCronometro;
}
  long getCronometro () {
    return cronometro;
  }