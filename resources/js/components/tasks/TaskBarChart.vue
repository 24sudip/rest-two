<template>
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8">
                            <h5>{{ $t("Tasks") }}</h5>
                        </div>
                        <div class="col-md-4">
                            <select class="form-control" v-model="year" @change.prevent="getBarChartData">
                                <option value="2024">2024</option>
                                <option value="2025">2025</option>
                                <option value="2026">2026</option>
                                <option value="2027">2027</option>
                                <option value="2028">2028</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <canvas id="tasks-bar-chart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';
    import Chart from 'chart.js/auto';
    export default {
        data() {
            return {
                year: '2024',
                myChart: null,
            }
        },
        computed: {
            current_roles() {
                return this.$store.getters.current_roles;
            },
            current_permissions() {
                return this.$store.getters.current_permissions;
            },
        },
        mounted() {
            this.$store.dispatch('getAuthRolesAndPermissions').then(() => {
                this.getBarChartData();
            });
        },
        methods: {
            getBarChartData() {
                axios.get(`${window.url}api/getBarChartData/${this.year}`).then((response) => {
                    let datasets = [];
                    if (this.current_permissions.has('tasks-create')) {
                        datasets.push({
                            label: `Assigned - Tasks - ${response.data.year}`,
                            data: response.data.tasks_array,
                            borderWidth: 2,
                            borderColor: 'gray',
                            backgroundColor: 'lightgray'
                        });
                    }
                    if (this.current_permissions.has('tasks-create')) {
                        datasets.push({
                            label: `Completed by others - Tasks - ${response.data.year}`,
                            data: response.data.other_completed_array,
                            borderWidth: 2,
                            borderColor: 'blue',
                            backgroundColor: 'lightblue'
                        });
                    }
                    if (this.current_permissions.has('inbox-update') && !this.current_roles.has('admin')) {
                        datasets.push({
                            label: `Completed on my own - Tasks - ${response.data.year}`,
                            data: response.data.own_completed_array,
                            borderWidth: 2,
                            borderColor: 'green',
                            backgroundColor: 'lightgreen'
                        });
                    }
                    if (this.myChart) this.myChart.destroy();
                    this.myChart = new Chart(document.getElementById('tasks-bar-chart').getContext("2d"), {
                        type: 'bar',
                        data: {
                            labels: response.data.months,
                            datasets: datasets,
                        },
                        options: {
                            responsive: true,
                        },
                    });
                }).catch(err => console.log(err));
            },
        }
    }
</script>
