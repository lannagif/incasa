class APIPath{
  static String dispositivo(String uid, String dispositivoID) => 'users/$uid/dispositivos/$dispositivoID';
  static String dispositivos(String uid) => 'users/$uid/dispositivos';
  //static Sting tipo(String uid, String tipoID) => 'users/$uid/tipos/$tiposID';
  //static String tipos(String uid) => 'users/$uid/tipos';
}