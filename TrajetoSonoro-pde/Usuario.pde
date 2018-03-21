class Usuario 
{
  //  variaveis globais
  float latitude;
  float longitude;
  float latitudeMap;
  float longitudeMap;
  long dataLista;
  long cronometroLista;
  int numeroLista;
  int incNumLista;

  //usuarios
  JSONObject jsonObject;
  JSONArray jsonArray;


  //inicializa as variaveis, atribuindo valor.
  Usuario (JSONObject tempJsonObject, JSONArray tempJsonArray, boolean rebootState) 
  {
    numeroLista = 1;
    incNumLista = 1;
    rebootState = false;

    //usuario
    jsonObject = tempJsonObject;
    jsonArray = tempJsonArray;

    //nesse grupo, as variaveis são iniciadas pegando as infos do primeiro "pacote" do array.
    jsonArray = jsonObject.getJSONArray("locations"); //escolhe o array dentro do arquivo .json
    jsonObject = jsonArray.getJSONObject(numeroLista);  //escolhe o "pacote" dentro do array
    latitude = jsonObject.getFloat("latitudeE7"); //escolhe e lê uma informação especifica dentro do "pacote" = latitude
    longitude = jsonObject.getFloat("longitudeE7"); //escolhe e lê uma informação especifica dentro do "pacote" = longitude
    dataLista = jsonObject.getLong("timestampMs"); //escolhe e lê uma informação especifica dentro do "pacote" = timestampMs
    cronometroLista = dataLista; //converte o timestampMs de string para long
  }

  void defineGeolocalizacao() 
  {
    //println (getCronometro ());
    //println ("arraySize = " + jsonArray.size());
    //println ("numeroLista = " + numeroLista);
    //println (rebootState);

    if (!rebootState) {
      if (numeroLista <= jsonArray.size() - 1) 
      {
        //println ("run");

        //CONDICIONAL 1
        if (cronometro - rangeCronometro <= cronometroLista && cronometroLista <= cronometro + rangeCronometro) 
        {       
          if (numeroLista >= jsonArray.size() - 1) 
          {
            println ("REBOOT");
            println (rebootState);

            numeroLista = 1;
            rebootState = true;
          } else 
          {
            latitude = jsonObject.getFloat("latitudeE7");
            longitude = jsonObject.getFloat("longitudeE7");
            //mapeamento dados (latitude e longitude)
            latitudeMap = latitude / 10000000;
            longitudeMap = longitude / 10000000;

            //println ("cond 1 | " + "cronometroLista = " + cronometroLista + " == cronometro " + cronometro + " | numeroLista = " + numeroLista); // -> ok

            //sequenciamento do array
            numeroLista = numeroLista + incNumLista; // passa para o array (pacote) seguinte. Vai ficar pausado nesse item do array até que a condicional seja verdadeira de novo. Isso sincroniza o tempo de vários usuários.
          }
        }


        //CONDICIONAL 2
        while (cronometroLista  < cronometro - rangeCronometro) 
        {
          if (numeroLista >= jsonArray.size() - 1) 
          {
            println ("REBOOT");
            println (rebootState);

            numeroLista = 1;
            rebootState = true;
          } else 
          {
            //serquenciamento do array. Fica decrementando o número da lista até que a condicional (while) não seja mais verdadeira.
            numeroLista = numeroLista - incNumLista;   

            jsonObject = jsonArray.getJSONObject(numeroLista); 
            dataLista = jsonObject.getLong("timestampMs"); //obtem dados de data/hora do arquivo (calendario)
            cronometroLista = dataLista; //converte o dado do Array timestamp de string para long

            // obtem os dados de latitude/longitude do arquivo, no "pacote" atual avaliado (geolocalização) [o while faz sempre ser o pacote anterior]
            latitude = jsonObject.getFloat("latitudeE7");
            longitude = jsonObject.getFloat("longitudeE7");
            //mapeamento dados (latitude e longitude)
            latitudeMap = latitude / 10000000;
            longitudeMap = longitude / 10000000;

            //println ("cond 2 | " + "cronometroLista = " + cronometroLista + " < cronometro " + cronometro + " | numeroLista = " + numeroLista); // -> ok
          }
        }    

        //CONDICIONAL 3
        while (cronometroLista  > cronometro + rangeCronometro) 
        {    
          if (numeroLista>= jsonArray.size() - 1) 
          {
            println ("REBOOT");
            println (rebootState);

            numeroLista = 1;
            rebootState = true;
          } else {
            //serquenciamento do array. Fica incrementando o número da lista até que a condicional (while) não seja mais verdadeira.
            numeroLista = numeroLista + incNumLista;            

            // obtem os dados de latitude/longitude do arquivo, no "pacote" atual avaliado (geolocalização) [o while faz sempre ser o pacote posterior]
            jsonObject = jsonArray.getJSONObject(numeroLista); 
            dataLista = jsonObject.getLong("timestampMs"); //obtem dados de data/hora do arquivo (calendario)
            cronometroLista = dataLista; //converte o dado do Array timestamp de string para long

            //println ("cond 3 | " + "cronometroLista = " + cronometroLista + " > cronometro " + cronometro + " | numeroLista = " + numeroLista); // -> ok
          }
        }
      }
    }

    if (rebootState) {
      println ("reboot boolean");
      println (getCronometro ());
      cronometro = cronometroInicial;
      numeroLista = 1;
      rebootState = !rebootState;
    }
    //else if (rebootState = true) 
    //{
    //  println ("reboot boolean");

    //  //rebootState = !rebootState;
    //  println (rebootState);
    //}
  }

  boolean getRebootState () {
    return rebootState;
  }

  float getLatitudeMap () {
    return latitudeMap;
  }

  float getLongitudeMap () {
    return longitudeMap;
  }

  void desenhaPin (color cor) { //desenha o pin
    //mapaPin (cria um marcador de localização de acordo com a lat-long do array json
    Location localPin = new Location(latitudeMap, longitudeMap); //define a localização geografica
    ScreenPosition posPin = map.getScreenPosition(localPin); //define a posição na tela, de acordo com a localização ("responsivo")
    //desenha pin / define aspectos visuais
    fill (cor, 50);
    ellipse (posPin.x, posPin.y, 40, 40);
    fill (cor, 150);
    ellipse (posPin.x, posPin.y, 8, 8);
  }
}