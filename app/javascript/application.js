
// app/javascript/application.js

import Rails from "@rails/ujs";
import * as bootstrap from "bootstrap"; // Bootstrap 5
import jQuery from "jquery"; // jQuery

// Make jQuery available globally
window.$ = window.jQuery = jQuery;

// Initialize Rails UJS
Rails.start();

// Log message when jQuery is loaded and Turbolinks is ready
$(document).on('turbolinks:load', function() {
  console.log('jQuery is loaded');
});

