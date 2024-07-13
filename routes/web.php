<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{HomeController, DepartmentController, UserController, RoleController, PermissionController};
use App\Http\Controllers\{AuthController, ProfileController, TaskController};

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/
Route::get('/', function () {
    return redirect('/login');
});

Route::controller(AuthController::class)->group(function () {
    Route::post('/register', 'Register')->name('register');
    Route::post('/login', 'Login')->name('login');
    Route::post('/logout', 'Logout')->name('logout')->middleware('auth');
});

Route::middleware(['auth'])->group(function () {
    Route::get('/dashboard', [HomeController::class, 'Dashboard'])->name('dashboard');

    Route::controller(DepartmentController::class)->group(function () {
        Route::get('/department/index', 'DepartmentIndex')->name('department.index')->middleware('permission:departments-read');
        Route::get('/department/create', 'DepartmentCreate')->name('department.create')->middleware('permission:departments-create');
        Route::post('/department/store', 'DepartmentStore')->name('department.store')->middleware('permission:departments-create');
        Route::get('/department/edit/{id}', 'DepartmentEdit')->name('department.edit')->middleware('permission:departments-update');
        Route::post('/department/update/{id}', 'DepartmentUpdate')->name('department.update')->middleware('permission:departments-update');
        Route::post('/department/delete/{id}', 'DepartmentDelete')->name('department.delete')->middleware('permission:departments-delete');
    });

    Route::controller(RoleController::class)->group(function () {
        Route::get('/role/index', 'RoleIndex')->name('role.index')->middleware('permission:roles-read');
        Route::get('/role/create', 'RoleCreate')->name('role.create')->middleware('permission:roles-create');
        Route::post('/role/store', 'RoleStore')->name('role.store')->middleware('permission:roles-create');
        Route::get('/role/edit/{id}', 'RoleEdit')->name('role.edit')->middleware('permission:roles-update');
        Route::post('/role/update/{id}', 'RoleUpdate')->name('role.update')->middleware('permission:roles-update');
        Route::post('/role/delete/{id}', 'RoleDelete')->name('role.delete')->middleware('permission:roles-delete');
        Route::post('/role/search', 'RoleSearch')->name('role.search')->middleware('permission:roles-read');
    });

    Route::controller(PermissionController::class)->group(function () {
        Route::get('/permission/index', 'PermissionIndex')->name('permission.index')->middleware('permission:permissions-read');
        Route::get('/permission/create', 'PermissionCreate')->name('permission.create')->middleware('permission:permissions-create');
        Route::post('/permission/store', 'PermissionStore')->name('permission.store')->middleware('permission:permissions-create');
        Route::get('/permission/edit/{id}', 'PermissionEdit')->name('permission.edit')->middleware('permission:permissions-update');
        Route::post('/permission/update/{id}', 'PermissionUpdate')->name('permission.update')->middleware('permission:permissions-update');
        Route::post('/permission/delete/{id}', 'PermissionDelete')->name('permission.delete')->middleware('permission:permissions-delete');
        Route::post('/permission/search', 'PermissionSearch')->name('permission.search')->middleware('permission:permissions-read');
    });

    Route::get('/user/index', [UserController::class, 'UserIndex'])->name('user.index')->middleware('permission:users-read');

    Route::controller(ProfileController::class)->group(function () {
        Route::get('/profile/index', 'ProfileIndex')->name('profile.index')->middleware('permission:profile-read');
        Route::post('/profile/update/{id}', 'ProfileUpdate')->name('profile.update')->middleware('permission:profile-update');
        Route::post('/profile/password/update/{id}', 'ProfilePasswordUpdate')->name('profile.password.update')->middleware('permission:profile-password-update');
    });

    Route::controller(TaskController::class)->group(function () {
        Route::get('/task/index', 'TaskIndex')->name('task.index')->middleware('permission:tasks-read');
        // Route::post('/orders', 'store');
    });
});
