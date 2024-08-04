/**
 * We'll load the axios HTTP library which allows us to easily issue requests
 * to our Laravel back-end. This library automatically handles sending the
 * CSRF token as a header based on the value of the "XSRF" token cookie.
 */
try {
    window.Popper = require('@popperjs/core');
    window.$ = window.jQuery = require('jquery');
    require('bootstrap');
} catch (e) {
    console.log(e);
}

import axios from 'axios';
window.axios = axios;

window.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

function loggedIn() {
    if (window.token) {
        let successToken = window.token;
        axios.defaults.headers.common = {'Authorization': `Bearer ${successToken}`};
        return successToken;
    }
    return;
}
loggedIn();

/**
 * Echo exposes an expressive API for subscribing to channels and listening
 * for events that are broadcast by Laravel. Echo and event broadcasting
 * allows your team to easily build robust real-time web applications.
 */

import Echo from 'laravel-echo';

import Pusher from 'pusher-js';
window.Pusher = Pusher;
// window.Pusher = require("pusher-js");

window.Echo = new Echo({
    broadcaster: "pusher",
    key: "c700de08b3af9a4cfd21",
    // import.meta.env.VITE_PUSHER_APP_KEY,
    cluster: "mt1",
    // import.meta.env.VITE_PUSHER_APP_CLUSTER ?? "mt1",
    // wsHost: import.meta.env.VITE_PUSHER_HOST
    //     ? import.meta.env.VITE_PUSHER_HOST
    //     : `ws-${import.meta.env.VITE_PUSHER_APP_CLUSTER}.pusher.com`,
    // wsPort: import.meta.env.VITE_PUSHER_PORT ?? 80,
    // wssPort: import.meta.env.VITE_PUSHER_PORT ?? 443,
    encrypted: true,
    forceTLS: false,
    // (import.meta.env.VITE_PUSHER_SCHEME ?? "https") === "https",
    // enabledTransports: ["ws", "wss"],
});
