<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate;
use Laravel\Passport\Passport;

use App\Models\Role;
use App\Models\Permission;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The model to policy mappings for the application.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        //
    ];

    /**
     * Register any authentication / authorization services.
     */
    public function boot()
    {
        $this->registerPolicies();
        // if (! $this->app->routesAreCached()) {
        //     Passport::routes();
        // }
        try {
            //all auth user role gates
            $roles = Role::all();
            foreach ($roles as $role) {
                Gate::define($role->name, function ($user) use ($role) {
                    return $user->hasRole($role->name);
                });
            }

            //all auth user permission gates
            $permissions = Permission::all();
            foreach ($permissions as $permission) {
                Gate::define($permission->name, function ($user) use ($permission) {
                    return $user->hasPermission($permission->name);
                });
            }
        } catch (\Exception $event) {
            return $event;
        }
    }
}
