<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\users;
use App\Http\Resources\UserResource;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UsersController extends Controller
{
    //get all users
    public function index()
    {
        $users = users::all();
        return new UserResource(true, 'Users retrieved successfully', $users);
    }

    //register user
    public function register(){
        $validator = Validator::make(request()->all(), [
            'name' => 'required',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6',
        ]);

        if($validator->fails()){
            return new UserResource(false, $validator->errors(), null);
        }

        $user = new users();
        $user->name = request('name');
        $user->email = request('email');
        $user->password = Hash::make(request('password'));
        $user->save();

        return new UserResource(true, 'User registered successfully', $user);
    }

    //login
    public function login(){
        $validator = Validator::make(request()->all(), [
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if($validator->fails()){
            return new UserResource(false, $validator->errors(), null);
        }

        $user = users::where('email', request('email'))->first();
        if($user){
            if(Hash::check(request('password'), $user->password)){
                return new UserResource(true, 'User logged in successfully', $user);
            }else{
                return new UserResource(false, 'Invalid password', null);
            }
        }else{
            return new UserResource(false, 'User not found', null);
        }
    }
}
