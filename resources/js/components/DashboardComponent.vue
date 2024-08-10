<template>
    <div class="row justify-content-center">
        <div class="col-md-3 mb-3">
            <select class="form-control" v-model="chart_type" @click="changeChartType">
                <option value="bar">Bar Chart</option>
                <option value="line">Line Chart</option>
            </select>
        </div>
    </div>
    <TaskBarChart v-if="chart_type == 'bar'" />
    <TaskLineChart v-if="chart_type == 'line'" />
</template>

<script>
    import TaskBarChart from './tasks/TaskBarChart.vue';
    import TaskLineChart from './tasks/TaskLineChart.vue';
    export default {
        components: {
            TaskBarChart,
            TaskLineChart,
        },
        data() {
            return {
                chart_type: 'bar',
            }
        },
        methods: {
            changeChartType(event) {
                this.chart_type = event.target.value;
            },
        },
    }
</script>
