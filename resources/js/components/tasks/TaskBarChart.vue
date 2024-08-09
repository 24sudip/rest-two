<template>
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8">
                            <h5>Tasks</h5>
                        </div>
                        <div class="col-md-4">
                            <select class="form-control" v-model="year">
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
                chartData: {
                    labels: [],
                    datasets: [],
                },
                chartOptions: {
                    responsive: true,
                },
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
                    console.log(response.data);
                }).catch(err => console.log(err));
            },
        }
    }
</script>
