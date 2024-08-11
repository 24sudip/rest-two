import './bootstrap';

import { createApp } from 'vue';
import { store } from './store/store';

import ContactComponent from "./components/ContactComponent.vue";

import DashboardComponent from "./components/DashboardComponent.vue";

import LogoutComponent from "./components/auth/LogoutComponent.vue";
import NotificationComponent from "./components/NotificationComponent.vue";
import Department from './components/Department.vue';
import PermissionCreate from './components/permissions/PermissionCreate.vue';
import User from './components/users/User.vue';
import Task from "./components/tasks/Task.vue";
import Inbox from "./components/tasks/Inbox.vue";
import Report from "./components/tasks/Report.vue";

import Form from "vform";
window.Form = Form;

import moment from "moment";

var Emitter = require("tiny-emitter");
window.emitter = new Emitter();

import Multiselect from "@vueform/multiselect";
import "@vueform/multiselect/themes/default.css";

import Swal from 'sweetalert2';
window.Swal = Swal;

const Toast = Swal.mixin({
    toast: true,
    position: "top-end",
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.onmouseenter = Swal.stopTimer;
        toast.onmouseleave = Swal.resumeTimer;
    },
});
window.Toast = Toast;

const app = createApp({});

app.component("multi-select", Multiselect);

app.component("contact-component", ContactComponent);
app.component("dashboard-component", DashboardComponent);
app.component("logout-component", LogoutComponent);
app.component("notification-component", NotificationComponent);
app.component("Department", Department);
app.component('permission-create', PermissionCreate);
app.component("User", User);
app.component("Task", Task);
app.component("Inbox", Inbox);
app.component("Report", Report);

app.config.globalProperties.$filters = {
    myDate(date) {
        return moment(date).startOf("hour").fromNow();
    }
};

window.url = '/';

app.use(store);

app.mount('#app');
