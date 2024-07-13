<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\{Department, Role, Permission, User};

class ApiController extends Controller
{
    public function getAllDepartment() {
        return response()->json(Department::all());
    }

    public function getAllRoles() {
        return response()->json(Role::all());
    }

    public function getAllPermissions() {
        return response()->json(Permission::all());
    }

    public function getAllUser() {
        return response()->json(User::with('department')->with('roles')->with('permissions')->get());
    }
}
