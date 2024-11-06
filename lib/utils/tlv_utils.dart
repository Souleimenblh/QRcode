String encodeTLV(Map<String, String> data) {
  StringBuffer tlv = StringBuffer();

  data.forEach((key, value) {
    
    String keyType = 'LB'; 
    String valueType = 'VL'; 
    int keyLength = key.length;
    int valueLength = value.length;

    tlv.write('$keyType$keyLength$key$valueType$valueLength$value');
  });

  return tlv.toString();
}

Map<String, String> decodeTLV(String tlv) {
  Map<String, String> data = {};
  int i = 0;

  while (i < tlv.length) {
    String keyType = tlv.substring(i, i + 2);
    i += 2; 
    int keyLength = int.tryParse(tlv[i].toString()) ?? 0;
    i++; 

    String key = tlv.substring(i, i + keyLength);
    i += keyLength; 

    String valueType = tlv.substring(i, i + 2);
    i += 2; 

    int valueLength = int.tryParse(tlv[i].toString()) ?? 0;
    i++; 

    String value = tlv.substring(i, i + valueLength);
    i += valueLength; 

    data[key] = value;
  }

  return data;
}
