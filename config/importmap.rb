# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/pwa_support", under: "pwa_support"

pin "debounce", to: "https://ga.jspm.io/npm:debounce@2.0.0/index.js"
pin "activestorage", to: "https://ga.jspm.io/npm:activestorage@5.2.8-1/app/assets/javascripts/activestorage.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
