<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Laravel\Sanctum\PersonalAccessToken;
use Illuminate\Support\Facades\Hash;
class AuthenticatedSessionController extends Controller
{
    /**
     * Handle an incoming authentication request.
     */
    public function store(LoginRequest $request)
    {
        $request->authenticate();
        
        $user = Auth::user();
        $token = $user->createToken('auth_token')->plainTextToken;

        

        return response()->json([
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user,
            'status' => 'Login successful',
        ], 200); // HTTP 200 OK
    }


    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request)
    {
        $user = Auth::guard('sanctum')->user(); // Manually check if user is authenticated

        if (!$user) {
            return response()->json(['error' => 'User not authenticated or token is invalid'], 401);
        }

        // Delete the user's current access token
        $user->currentAccessToken()->delete();

        // Invalidate the session and regenerate CSRF token
        // $request->session()->invalidate();
        // $request->session()->regenerateToken();

        return response()->json(['message' => 'Logout successful']);
    }

    public function profile(Request $request)
    {
        // Ambil token dari header Authorization
        $token = $request->bearerToken();
        \Log::info($token);
        $accessToken = PersonalAccessToken::findToken($token);
        \Log::info($accessToken);
        // Periksa apakah token valid
        if (!$accessToken || !$accessToken->tokenable) {
            return response()->json(['error' => 'User not authenticated'], 401);
        }
    
        // Ambil pengguna dari token
        $user = $accessToken->tokenable;
    
        return response()->json(['user' => $user], 200);
    }

    public function updateProfile(Request $request)
    {
        // Ambil token dari header Authorization
        $token = $request->bearerToken();
        $accessToken = PersonalAccessToken::findToken($token);

        // Periksa apakah token valid
        if (!$accessToken || !$accessToken->tokenable) {
            return response()->json(['error' => 'User not authenticated'], 401);
        }

        // Ambil pengguna dari token
        $user = $accessToken->tokenable;

        // Validasi input
        $request->validate([
            'name' => 'sometimes|string|max:255',
            'email' => 'sometimes|string|email|max:255|unique:users,email,' . $user->getKey() . ',user_id', 
        ]);

        // Update pengguna
        if ($request->has('name')) {
            $user->name = $request->input('name');
        }
        if ($request->has('email')) {
            $user->email = $request->input('email');
        }
        $user->save();

        return response()->json(['user' => $user], 200);
    }

    public function updatePassword(Request $request)
    {
        // Ambil token dari header Authorization
        $token = $request->bearerToken();
        $accessToken = PersonalAccessToken::findToken($token);

        // Periksa apakah token valid
        if (!$accessToken || !$accessToken->tokenable) {
            return response()->json(['error' => 'User not authenticated'], 401);
        }

        // Ambil pengguna dari token
        $user = $accessToken->tokenable;

        // Validasi input
        $request->validate([
            'old_password' => 'required|string',
            'new_password' => 'required|string|min:8|confirmed',
        ]);

        // Periksa apakah password lama cocok
        if (!Hash::check($request->input('old_password'), $user->password)) {
            return response()->json(['error' => 'Old password is incorrect'], 400);
        }

        // Update password
        $user->password = Hash::make($request->input('new_password'));
        $user->save();

        return response()->json(['message' => 'Password updated successfully'], 200);
    }
    
    //update profile_picture
    public function updateProfilePicture(Request $request)
    {
        // Ambil token dari header Authorization
        $token = $request->bearerToken();
        $accessToken = PersonalAccessToken::findToken($token);

        // Periksa apakah token valid
        if (!$accessToken || !$accessToken->tokenable) {
            return response()->json(['error' => 'User not authenticated'], 401);
        }

        // Ambil pengguna dari token
        $user = $accessToken->tokenable;

        // Validasi input
        $request->validate([
            'profile_picture' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        // Update profile picture
        $profilePicture = $request->file('profile_picture');
        $profilePicturePath = $profilePicture->store('profile_pictures', 'public');
        $user->profile_picture = $profilePicturePath;
        $user->save();

        return response()->json(['user' => $user], 200);
    }
    
}
