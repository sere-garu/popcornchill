import "bootstrap";
import "../plugins/flatpickr"

import places from 'places.js';

const addressInput = document.getElementById('event_address');

if (addressInput) {
  places({
  	appId: "plG2YG1484D8",
  	apiKey: PLACES_API_KEY,

  	container: addressInput
  });
}

