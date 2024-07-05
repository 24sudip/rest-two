const mix = require("laravel-mix");

mix.js("resources/js/app.js", "public/js")
    .vue()
    .sass(
    "resources/sass/app.scss",
    "public/css", [
        //
    ]
).sourceMaps();

// "type": "module",
// "vue": "^3.4.30"
// "@vue/compiler-sfc": "^3.4.30",
// "laravel-vite-plugin": "^1.0.0",
// "vite": "^5.0.0",
