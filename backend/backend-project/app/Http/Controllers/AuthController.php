<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Tymon\JWTAuth\Facades\JWTAuth;

class AuthController extends Controller
{
    // Register new user
    public function register(Request $request)
    {
        // Validate request data
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Create new user
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        // Generate token for the newly registered user
        $token = JWTAuth::fromUser($user);

        return response()->json([
            'success' => true,
            'message' => 'User successfully registered',
            'token' => $token,
            'user' => $user
        ], 201);
    }

public function login(Request $request)
{
    // Validate input
    $validator = Validator::make($request->all(), [
        'email' => 'required|string|email',
        'password' => 'required|string',
    ]);

    if ($validator->fails()) {
        return response()->json($validator->errors(), 400);
    }

    // Get credentials from request
    $credentials = $request->only('email', 'password');

    // Debugging credentials
    \Log::info('Credentials:', $credentials);

    // Get user by email
    $user = User::where('email', $request->email)->first();
    if ($user) {
        // Debugging user password
        \Log::info('Stored Password:', ['password' => $user->password]);
        \Log::info('Input Password:', ['password' => $request->password]);

        // Check if password matches
        $passwordMatches = Hash::check($request->password, $user->password);
        \Log::info('Password Match:', ['match' => $passwordMatches]);

        if (!$passwordMatches) {
            return response()->json(['error' => 'Invalid credentials'], 401);
        }

        // Generate token if password matches
        $token = JWTAuth::fromUser($user);
        return response()->json([
            'success' => true,
            'token' => $token,
            'user' => $user
        ], 200);
    } else {
        \Log::info('User not found for email:', ['email' => $request->email]);
        return response()->json(['error' => 'User not found'], 404);
    }
}
    // User logout
    public function logout()
    {
        Auth::logout();
        return response()->json([
            'success' => true,
            'message' => 'User successfully logged out'
        ]);
    }

    // Get the authenticated user
    public function me()
    {
        return response()->json(Auth::user());
    }
}
