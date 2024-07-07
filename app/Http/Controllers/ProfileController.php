<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Rules\MatchOldPassword;
use Validator;
use Auth;
use Hash;
use Session;

class ProfileController extends Controller
{
    public function ProfileIndex() {
        $user = Auth::user();
        return view('profile.Index', compact('user'));
    }

    public function ProfileUpdate(Request $request, $id) {
        $validation = Validator::make($request->all(), [
            'name'=>['required'],
            'email'=>['required','email','unique:users,email,'.$id]
        ]);
        if ($validation->fails()) {
            return redirect()->back()->withErrors($validation);
        }
        User::where('id',$id)->update([
            'name'=>$request->name,
            'email'=>$request->email,
        ]);
        Session::flash('success_message','Information Updated Successfully');
        return redirect()->route('profile.index');
    }

    public function ProfilePasswordUpdate(Request $request, $id) {
        $validation = Validator::make($request->all(), [
            'old_password'=>['required', new MatchOldPassword],
            'password'=>['required','confirmed'],
            'password_confirmation'=>['required']
        ]);
        if ($validation->fails()) {
            return redirect()->back()->withErrors($validation);
        }
        User::find($id)->update([
            'password'=>Hash::make($request->password)
        ]);
        Session::flash('success_message','Password Updated Successfully!');
        return redirect()->route('profile.index');
    }
}
