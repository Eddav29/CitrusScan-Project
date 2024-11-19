<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Laravel\Sanctum\PersonalAccessToken;
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
}
