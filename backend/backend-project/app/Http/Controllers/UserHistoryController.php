<?php
namespace App\Http\Controllers;

use App\Models\UserHistory;
use Illuminate\Http\Request;

class UserHistoryController extends Controller
{
    // Menampilkan riwayat prediksi berdasarkan user_id
    public function showHistory($user_id)
    {
        // Cek apakah user ada dalam database
        $user = \App\Models\User::find($user_id);

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        // Ambil semua riwayat prediksi berdasarkan user_id
        $history = UserHistory::where('user_id', $user_id)
            ->with('prediction') // Jika kamu ingin mengambil data terkait prediksi
            ->get();

        if ($history->isEmpty()) {
            return response()->json(['message' => 'No history found for this user'], 404);
        }

        // Tampilkan history dalam bentuk JSON
        return response()->json([
            'message' => 'User history retrieved successfully',
            'data' => $history->map(function ($historyItem) {
                return [
                    'prediction_id' => $historyItem->prediction_id,
                    'image_path' => asset('storage/' . $historyItem->image_path),
                    'created_at' => $historyItem->created_at,
                ];
            }),
        ], 200);
    }
}
