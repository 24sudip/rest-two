<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Role;
use Session;

class RoleController extends Controller
{
    public function RoleIndex() {
        $roles = Role::all();
        return view('management.role.Index', compact('roles'));
    }

    public function RoleCreate() {
        return view('management.role.Create');
    }

    public function RoleStore(Request $request) {
        $request->validate([
            'name'=>['required'],
            'display_name'=>['required'],
            'description'=>['required'],
        ]);
        Role::create([
            'name'=>$request->name,
            'display_name'=>$request->display_name,
            'description'=>$request->description,
        ]);
        Session::flash('success_message','Role Created Successfully!');
        return redirect()->route('role.index');
    }

    public function RoleEdit($id) {
        $role = Role::find($id);
        return view('management.role.Edit', compact('role'));
    }

    public function RoleUpdate(Request $request, $id) {
        $request->validate([
            'name'=>['required'],
            'display_name'=>['required'],
            'description'=>['required'],
        ]);
        Role::where('id',$id)->update([
            'name'=>$request->name,
            'display_name'=>$request->display_name,
            'description'=>$request->description,
        ]);
        Session::flash('success_message','Role Updated Successfully!');
        return redirect()->route('role.index');
    }

    public function RoleDelete($id) {
        Role::where('id', $id)->delete();
        Session::flash('success_message','Role Deleted Successfully!');
        return redirect()->route('role.index');
    }
}
