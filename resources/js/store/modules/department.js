//
import axios from "axios";

export default {
    state: {
        department: {},
    },
    getters: {
        department(state) {
            return state.department;
        },
    },
    mutations: {
        set_department: (state, data) => {
            state.department = data;
        },
    },
    actions: {
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
        }
    },
};
