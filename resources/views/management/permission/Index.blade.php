<!-- Breathing in, I calm body and mind. Breathing out, I smile. - Thich Nhat Hanh -->
@extends('layouts.Master')

@section('content')
<div class="card">
    <div class="card-header bg-dark">
        <div class="row">
            <div class="col-md-6">
                <h5 class="text-light">Permissions</h5>
            </div>
            <div class="col-md-6">
                @can('permissions-create')
                <a href="{{ route('permission.create') }}" class="btn btn-success float-right">Create New Permission</a>
                @endcan
            </div>
        </div>
    </div>
    <div class="card-body">
        <div class="row my-2">
            <div class="col-md-12">
                <form action="{{ route('permission.search') }}" method="POST">
                    @csrf
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="search_type">Search Type</label>
                                <select name="search_type" class="form-control">
                                    <option value="name" selected>Name</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="search_value">Search Value</label>
                                <input type="text" class="form-control" name="search_value" value="{{ isset($search_value) ? $search_value : old('search_value')}}">
                            </div>
                        </div>
                        <div class="col-md-2 d-flex align-items-center">
                            <button type="submit" class="btn btn-success mt-3 mx-1">
                                <i class="fa fa-search"></i>
                            </button>
                            @if (Request::is('permission/search'))
                            <a href="{{ route('permission.index') }}" class="btn btn-danger mt-3 mx-1">
                                <i class="fa fa-times"></i>
                            </a>
                            @endif
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>SL</th>
                                <th>Name</th>
                                <th>Display Name</th>
                                <th>Description</th>
                                @canany(['permissions-update', 'permissions-delete'])
                                <th>Actions</th>
                                @endcanany
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($permissions as $permission)
                            <tr>
                                <td>{{ $loop->index + 1}}</td>
                                <td>{{ $permission->name }}</td>
                                <td>{{ $permission->display_name }}</td>
                                <td>{{ $permission->description }}</td>
                                @canany(['permissions-update', 'permissions-delete'])
                                <td>
                                    @can('permissions-update')
                                    <div class="float-left mx-1">
                                        <a href="{{ route('permission.edit', $permission->id) }}" class="btn btn-success">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                    </div>
                                    @endcan

                                    @can('permissions-delete')
                                    <div class="float-left mx-1">
                                        @include('management.permission.Delete')
                                        {{-- <form action="{{ route('permission.delete', $permission->id) }}" method="post">
                                            @csrf
                                            <button class="btn btn-danger"><i class="fa fa-trash"></i></button>
                                        </form> --}}
                                    </div>
                                    @endcan
                                </td>
                                @endcanany
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                {!! $permissions->links('pagination::bootstrap-5') !!}
            </div>
        </div>
    </div>
</div>
@endsection
