<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HomeController extends Controller
{
    function __construct() {
        $this->middleware('auth');
    }
    
    public function Dashboard() {
        return view('Dashboard');
    }
}
