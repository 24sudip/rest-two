<template>
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-dark">
                    <h5 class="text-light">Reports</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="type">Report Type</label>
                                <select class="form-control" v-model="reportData.type">
                                    <option value="#" disabled>Select a type</option>
                                    <option value="assigned" v-if="current_permissions.has('tasks-create')">Assigned Tasks</option>
                                    <option value="other_completed" v-if="current_permissions.has('tasks-create')">Completed Tasks</option>
                                    <option value="all_inbox" v-if="current_permissions.has('inbox-read')">Inbox Tasks</option>
                                    <option value="completed_inbox" v-if="current_permissions.has('inbox-update')">Completed Inbox Tasks</option>
                                </select>
                                <div class="text-danger" v-if="reportData.errors.has('type')" v-html="reportData.errors.get('type')" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="start_date">Start Date</label>
                                <input type="date" class="form-control" v-model="reportData.start_date">
                                <div class="text-danger" v-if="reportData.errors.has('start_date')" v-html="reportData.errors.get('start_date')" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="end_date">End Date</label>
                                <input type="date" class="form-control" v-model="reportData.end_date">
                                <div class="text-danger" v-if="reportData.errors.has('end_date')" v-html="reportData.errors.get('end_date')" />
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-start mt-3" v-if="current_permissions.has('reports-create') && reportData.type != '#' && reportData.start_date != '' && reportData.end_date != ''">
                        <button type="button" class="btn btn-success">
                            <i class="fa fa-file-excel-o"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                reportData: new Form({
                    type: '#',
                    start_date: '',
                    end_date: '',
                }),
            }
        },
        mounted() {
            this.$store.dispatch('getAuthRolesAndPermissions');
        },
        computed: {
            current_roles() {
                return this.$store.getters.current_roles;
            },
            current_permissions() {
                return this.$store.getters.current_permissions;
            },
        },
    }
</script>
