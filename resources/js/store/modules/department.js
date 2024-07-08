//
import axios from "axios";

export default {
    state: {
        department: {},
        departmentLinks: [],
    },
    getters: {
        department(state) {
            return state.department;
        },
        departmentLinks(state) {
            return state.departmentLinks;
        },
    },
    mutations: {
        set_department: (state, data) => {
            state.department = data;
            state.departmentLinks = [];
            for (let i = 0; i < data.links.length; i++) {
                if (
                    i === 1 ||
                    i === Number(data.links.length - 2) ||
                    data.links[i].active ||
                    isNaN(data.links[i].label) ||
                    Number(data.links[i].label) ===
                        Number(data.current_page + 1) ||
                    Number(data.links[i].label) ===
                        Number(data.current_page - 1)
                ) {
                    state.departmentLinks.push(data.links[i]);
                }
            }
        },
    },
    actions: {
        getDepartmentResult: (context, link) => {
            axios.get(link.url).then((response) => {
                context.commit("set_department", response.data);
            });
        },
        getDepartment: (context) => {
            axios.get(`${window.url}api/getDepartment`).then((response) => {
                // this.department = ;
                context.commit("set_department", response.data);
            });
        },
        storeDepartment: (context, departmentData) => {
            departmentData
                .post(window.url + "api/storeDepartment")
                .then((response) => {
                    context.dispatch("getDepartment");
                    $("#exampleModal").modal("hide");
                });
        },
        updateDepartment: (context, departmentData) => {
            departmentData
                .post(window.url + "api/updateDepartment/" + departmentData.id)
                .then((response) => {
                    context.dispatch("getDepartment");
                    $("#exampleModal").modal("hide");
                });
        },
        deleteDepartment: (context, departmentData) => {
            if (confirm("Are you sure you wanna delete department!")) {
                axios
                    .post(
                        window.url + "api/deleteDepartment/" + departmentData.id
                    )
                    .then(() => {
                        context.dispatch("getDepartment");
                    });
            }
        },
    },
};
