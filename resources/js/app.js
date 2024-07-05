import './bootstrap';

import { createApp } from 'vue';
import { store } from './store/store';

import Department from './components/Department.vue';
import PermissionCreate from './components/permissions/PermissionCreate.vue';
import User from './components/users/User.vue';

import Form from "vform";
window.Form = Form;

import Multiselect from "@vueform/multiselect";
import "@vueform/multiselect/themes/default.css";

const app = createApp({});

app.component("Department", Department);
app.component('permission-create', PermissionCreate);
app.component("User", User);
app.component("multi-select", Multiselect);

window.url = '/';

app.use(store);

app.mount('#app');

