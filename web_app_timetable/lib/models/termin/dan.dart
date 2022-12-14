Map<String, Dan> daniMapped = {
  'MONDAY': Dan.ponedjeljak,
  'TUESDAY': Dan.utorak,
  'WEDNESDAY': Dan.srijeda,
  'THURSDAY': Dan.cetvrtak,
  'FRIDAY': Dan.petak,
};

enum Dan {
  ponedjeljak,
  utorak,
  srijeda,
  cetvrtak,
  petak,
}

Map<Dan, String> daniMappedNaBosanski = {
  Dan.ponedjeljak: 'Ponedjeljak',
  Dan.utorak: 'Utorak',
  Dan.srijeda: 'Srijeda',
  Dan.cetvrtak: 'Četvrtak',
  Dan.petak: 'Petak'
};

Map<Dan, String> daniMappedNaEngleski = {
  Dan.ponedjeljak: 'MONDAY',
  Dan.utorak: 'TUESDAY',
  Dan.srijeda: 'WEDNESDAY',
  Dan.cetvrtak: 'THURSDAY',
  Dan.petak: 'FRIDAY'
};
