//timestamp (https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/prototype)
import java.util.Date;

JSONObject jsonNovo;
JSONArray listaNova;

int contador = 0;
int incContador = 5;

int contadorNovo = 0;
int incContNovo = 1;

void setup() 
{
  JSONObject jsonOriginal = loadJSONObject("2-old_lilian.json");

  listaNova = new JSONArray();
  jsonNovo = new JSONObject();


  JSONArray listaOriginal = jsonOriginal.getJSONArray("locations");

  for (int i = 0; i < listaOriginal.size(); i++) {
    JSONObject jsonNovo = new JSONObject();
    jsonOriginal = listaOriginal.getJSONObject(i); 

    String data = jsonOriginal.getString("timestampMs");
    long cronometroLista = Long.parseLong(data); //converte o timestampMs de string para long
    int latitude = jsonOriginal.getInt("latitudeE7");
    int longitude = jsonOriginal.getInt("longitudeE7");
    if (i == contador && cronometroLista >= 1483228860000L) {
      jsonNovo.setInt("latitudeE7", latitude);
      jsonNovo.setInt("longitudeE7", longitude);
      jsonNovo.setLong("timestampMs", cronometroLista);

      listaNova.setJSONObject(contadorNovo, jsonNovo);
      println ("lendo dados");
      println (contador);
      println (contadorNovo);

      contador = contador + incContador;
      contadorNovo = contadorNovo + incContNovo;
    }
  }

  println ("salvando dados");
  saveJSONArray(listaNova, "data/2.json");
  println ("dados salvos");

  //println(values); //imprime os dados, os arrays e suas informações
  //println(values.size()); //imprime a quantidade de arrays (85305 no arquivo resumido)
}