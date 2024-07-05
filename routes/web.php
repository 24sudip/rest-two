<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{HomeController, DepartmentController, UserController, RoleController, PermissionController};
use App\Http\Controllers\AuthController;

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

// Route::get('/', function () {
//     return view('welcome');
// });
Route::post('/login', [AuthController::class, 'Login'])->name('login');

Route::get('/', [HomeController::class, 'Dashboard']);

Route::get('/department/index', [DepartmentController::class, 'DepartmentIndex'])->name('department.index');
Route::get('/department/create', [DepartmentController::class, 'DepartmentCreate'])->name('department.create');
Route::post('/department/store', [DepartmentController::class, 'DepartmentStore'])->name('department.store');
Route::get('/department/edit/{id}', [DepartmentController::class, 'DepartmentEdit'])->name('department.edit');
Route::post('/department/update/{id}', [DepartmentController::class, 'DepartmentUpdate'])->name('department.update');
Route::post('/department/delete/{id}', [DepartmentController::class, 'DepartmentDelete'])->name('department.delete');

Route::get('/role/index', [RoleController::class, 'RoleIndex'])->name('role.index');
Route::get('/role/create', [RoleController::class, 'RoleCreate'])->name('role.create');
Route::post('/role/store', [RoleController::class, 'RoleStore'])->name('role.store');
Route::get('/role/edit/{id}', [RoleController::class, 'RoleEdit'])->name('role.edit');
Route::post('/role/update/{id}', [RoleController::class, 'RoleUpdate'])->name('role.update');
Route::post('/role/delete/{id}', [RoleController::class, 'RoleDelete'])->name('role.delete');

Route::get('/permission/index', [PermissionController::class, 'PermissionIndex'])->name('permission.index');
Route::get('/permission/create', [PermissionController::class, 'PermissionCreate'])->name('permission.create');
Route::post('/permission/store', [PermissionController::class, 'PermissionStore'])->name('permission.store');
Route::get('/permission/edit/{id}', [PermissionController::class, 'PermissionEdit'])->name('permission.edit');
Route::post('/permission/update/{id}', [PermissionController::class, 'PermissionUpdate'])->name('permission.update');
Route::post('/permission/delete/{id}', [PermissionController::class, 'PermissionDelete'])->name('permission.delete');

Route::get('/user/index', [UserController::class, 'UserIndex'])->name('user.index');
