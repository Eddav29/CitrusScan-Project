<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\users;
use App\Http\Resources\UserResource;

class UsersController extends Controller
{
    //get all users
    public function index()
    {
        $users = users::all();
        return new UserResource(true, 'Users retrieved successfully', $users);
    }
    
}
