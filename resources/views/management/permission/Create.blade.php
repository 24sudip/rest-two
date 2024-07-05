<!-- It is not the man who has too little, but the man who craves more, that is poor. - Seneca -->
@extends('layouts.Master')

@section('content')
<div class="card">
    <div class="card-header bg-dark">
        <h5 class="text-light">Create New Permission</h5>
    </div>
    <div class="card-body">
        <form action="{{ route('permission.store') }}" method="POST">
            @csrf
            <permission-create></permission-create>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <button type="submit" class="btn btn-success float-right">Save</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
@endsection
