# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "@ar-js-org/ar.js", to: "@ar-js-org--ar.js.js" # @3.4.7
pin "aframe" # @1.7.0
pin "three" # @0.164.1
pin_all_from "app/javascript/custom", under: "custom"
