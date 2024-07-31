//
import axios from "axios";

export default {
    state: {
        unread_notifications: {},
        filtered_department: [],
        filtered_roles: [],
        filtered_permission_categories: [],
        filtered_permissions: [],
        all_permissions: [],
        filtered_users: [],
    },
    getters: {
        filtered_department(state) {
            return state.filtered_department;
        },
        unread_notifications(state) {
            return state.unread_notifications;
        },
        filtered_roles(state) {
            return state.filtered_roles;
        },
        filtered_permission_categories(state) {
            return state.filtered_permission_categories;
        },
        filtered_permissions(state) {
            return state.filtered_permissions;
        },
        filtered_users(state) {
            return state.filtered_users;
        },
    },
    mutations: {
        set_unread_notifications: (state, data) => {
            state.unread_notifications = data;
        },
        set_all_department: (state, data) => {
            state.filtered_department = [];
            data.forEach((department) =>
                state.filtered_department.push({
                    value: department.id,
                    label: department.name,
                })
            );
        },
        set_all_roles: (state, data) => {
            state.filtered_roles = [];
            data.forEach((role) =>
                state.filtered_roles.push({
                    value: role.id,
                    label: role.name,
                })
            );
        },
        set_all_permissions: (state, data) => {
            state.all_permissions = data;
            state.filtered_permission_categories = [];
            let itemsArray = [];
            data.forEach((item) => {
                let items = item.name.split("-");
                itemsArray.push(items[0]);
            });
            let uniqueItems = [...new Set(itemsArray)];
            state.filtered_permission_categories = uniqueItems;
        },
        set_filtered_permissions: (state, data) => {
            state.filtered_permissions = [];
            console.log(data.values);
            data.values.forEach((value) => {
                state.all_permissions.find((element) => {
                    if (element.name.includes(value)) {
                        state.filtered_permissions.push({
                            value: element.id,
                            label: element.name,
                        });
                    }
                });
            });
        },
        set_all_users: (state, data) => {
            state.filtered_users = [];
            data.forEach((user) => {
                if (
                    user.department_id === window.auth_user.department_id &&
                    user.id !== window.auth_user.id &&
                    user.user_level !== 0 &&
                    user.user_level > window.auth_user.user_level
                ) {
                    state.filtered_users.push({
                        value: user.id,
                        label: user.name,
                    });
                }
            });
        },
    },
    actions: {
        getUnreadNotification: (context) => {
            axios.get(`${window.url}api/getUnreadNotification`)
            .then((response) => {
                context.commit("set_unread_notifications", response.data);
            });
        },
        markNotificationAsRead: (context, unreadData) => {
            axios
                .get(`${window.url}api/markNotificationAsRead?unread=${unreadData.id}`)
                .then((response) => {
                    context.dispatch("getUnreadNotification");
                    window.Toast.fire({
                        icon: "success",
                        title: "Notification Marked As Read!",
                    });
                });
        },
        getAllDepartment: (context) => {
            axios.get(`${window.url}api/getAllDepartment`).then((response) => {
                context.commit("set_all_department", response.data);
            });
        },
        getAllRoles: (context) => {
            axios.get(`${window.url}api/getAllRoles`).then((response) => {
                context.commit("set_all_roles", response.data);
            });
        },
        getAllPermissions: (context) => {
            axios.get(`${window.url}api/getAllPermissions`).then((response) => {
                context.commit("set_all_permissions", response.data);
            });
        },
        getFilteredPermissions: (context, data) => {
            context.commit("set_filtered_permissions", data);
        },
        getAllUser: (context, data) => {
            axios.get(`${window.url}api/getAllUser`).then((response) => {
                context.commit("set_all_users", response.data);
            });
        },
    },
};
