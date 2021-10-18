String countryAbbrevation(String country) {
  if (country.toLowerCase() == 'kenya') {
    return 'KE';
  }
  if (country.toLowerCase() == 'tanzania') {
    return 'TZ';
  }
  if (country.toLowerCase() == 'uganda') {
    return 'UG';
  }
  if (country.toLowerCase() == 'ethiopia') {
    return 'ETH';
  }
  return country.substring(0, 2);
}
