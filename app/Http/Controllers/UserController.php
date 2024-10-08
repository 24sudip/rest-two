<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\{User, Role};
use Hash;

class UserController extends Controller
{
    public function searchUser() {
        if ($search = \Request::get('name')) {
            $users = User::where(function ($query) use ($search) {
                $query
                ->where('name', 'LIKE', "%$search%")
                ->orWhere('email', 'LIKE', "%$search%")
                ;
            })->with('department')->with('roles')->with('permissions')->latest()->paginate(10);
        } else {
            $users = User::with('department')->with('roles')->with('permissions')->latest()->paginate(10);
        }
        return response()->json($users);
    }

    public function UserIndex() {
        return view('management.user.Index');
    }

    public function getUser() {
        return response()->json(User::with('department')->with('roles')->with('permissions')->latest()->paginate(10));
    }

    public function storeUser(Request $request) {
        // return $request->all();
        $request->validate([
            'name'=>'required',
            'email'=>'required',
            'password'=>'required',
        ]);
        if ($request->department_id != '') {
            $department_id = $request->department_id;
        } else {
            $department_id = 0;
        }

        if (count($request->selected_roles) > 0) {
            $role_id = $request->selected_roles[0];
            $role = Role::findOrFail($role_id);
            if($role->name === 'director') {
                $user_level = 1;
            } else if($role->name === 'manager') {
                $user_level = 2;
            } else if($role->name === 'employee') {
                $user_level = 3;
            } else {
                $user_level = 0;
            }
        } else {
            $user_level = 0;
        }

        $user = User::create([
            'department_id'=>$department_id,
            'user_level'=>$user_level,
            'name'=>$request->name,
            'email'=>$request->email,
            'password'=>Hash::make($request->password)
        ]);
        $user->syncRoles($request->selected_roles);
        $user->syncPermissions($request->selected_permissions);
        return response()->json('success');
    }

    public function updateUser(Request $request, $id) {
        $request->validate([
            'name'=>'required',
            'email'=>'required',
        ]);
        $user = User::findOrFail($id);

        if ($request->department_id != '') {
            $department_id = $request->department_id;
        } else {
            $department_id = 0;
        }

        if ($request->password === null) {
            $password = $user->password;
        } else {
            $password = Hash::make($request->password);
        }

        if (count($request->selected_roles) > 0) {
            $role_id = $request->selected_roles[0];
            $role = Role::findOrFail($role_id);
            if($role->name === 'director') {
                $user_level = 1;
            } else if($role->name === 'manager') {
                $user_level = 2;
            } else if($role->name === 'employee') {
                $user_level = 3;
            } else {
                $user_level = 0;
            }
        } else {
            $user_level = 0;
        }

        User::where('id', $id)->update([
            'department_id'=>$department_id,
            'user_level'=>$user_level,
            'name'=>$request->name,
            'email'=>$request->email,
            'password'=>$password
        ]);

        $user->syncRoles($request->selected_roles);
        $user->syncPermissions($request->selected_permissions);
        return response()->json('success');
    }

    public function deleteUser($id) {
        $user = User::findOrFail($id);
        $user->roles()->detach();
        $user->permissions()->detach();
        $user->delete();
        return response()->json('success');
    }
}
