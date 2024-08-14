<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Auth;
use DB;
use Hash;
use Session;

class AuthController extends Controller
{
    public function Login(Request $request) {
        $credentials = $request->validate([
            'email'=>['required','email'],
            'password'=>['required'],
        ]);
        if (Auth::attempt($credentials)) {
            $request->session()->regenerate();
            $user = User::where('email', $request->email)->first();
            shell_exec('php ../artisan passport:install');
            $successToken = $user->createToken('task_token')->accessToken;
            session()->put('token', $successToken);
            
            $locale = 'en';
            app()->setLocale($locale);
            session()->put('locale', $locale);
            return redirect()->route('dashboard');
        }
        return back()->withErrors([
            'email'=>'The Provided Credentials Do Not Match Our Records.'
        ]);
    }

    public function Logout(Request $request) {
        $user = Auth::user();
        DB::table('oauth_access_tokens')->where('id', $request->token_id)->where('user_id', $user->id)->update([
            'revoked' => 1
        ]);
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect('/login');
    }

    public function Register(Request $request) {
        $request->validate([
            'email'=>['required','email'],
            'name'=>['required'],
            'password'=>['required','confirmed','min:6'],
        ]);
        User::create([
            'department_id' => 0,
            'name'=>$request->name,
            'email'=>$request->email,
            'password'=>Hash::make($request->password),
        ]);
        Session::flash('success_message','Account Created Successfully!');
        return redirect('/login');
    }
}
