// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import { initSelect2 } from '../components/init_select2';
import { initNavSelector } from "../components/nav_selector"
import { initMenuSelector } from "../components/menu_selector"
import { initArrayInput } from "../components/array_input"
import { initHEXModal } from "../components/hex_modal"
import { initTableauHexSearchBar } from "../components/tableau_hex_search_bar"
import { initReducteur } from "../components/reducteur"
import { initBasicMultiple } from "../components/basic_multiple"

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  initSelect2();
  initNavSelector();
  initMenuSelector();
  initArrayInput();
  initHEXModal();
  initTableauHexSearchBar();
  initReducteur();
  initBasicMultiple();
});
