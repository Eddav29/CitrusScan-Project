<?php
namespace App\Http\Controllers;

use App\Models\UserHistory;
use App\Models\User;
use App\Models\Prediction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class UserHistoryController extends Controller
{
    public function showHistory($user_id)
    {
        // Cek apakah user ada dalam database
        $user = User::find($user_id);

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        // Ambil semua riwayat prediksi berdasarkan user_id
        $history = UserHistory::where('user_id', $user_id)
            ->with(['prediction.disease']) // Memuat relasi prediction dan disease
            ->get();

        if ($history->isEmpty()) {
            return response()->json(['message' => 'No history found for this user'], 404);
        }

        // Tampilkan history dalam bentuk JSON
        return response()->json([
            'message' => 'User history retrieved successfully',
            'data' => $history->map(function ($historyItem) {
                // Validasi relasi prediction dan disease
                $prediction = $historyItem->prediction;
                $disease = $prediction ? $prediction->disease : null;

                return [
                    'prediction_id' => $historyItem->prediction_id,
                    'disease_name' => $disease ? $disease->name : 'Unknown disease', // Tampilkan "Unknown disease" jika tidak ditemukan
                    'created_at' => $historyItem->created_at,
                    'image_path' => asset('storage/' . $historyItem->image_path),
                ];
            }),
        ], 200);
    }
    
    public function showHistoryDetail($user_id, $user_history_id)
    {
        // Validasi apakah user ada
        $user = User::find($user_id);
        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }
    
        // Cari riwayat berdasarkan user_id dan prediction_id
        $history = UserHistory::with(['prediction.disease.treatments'])
            ->where('user_id', $user_id)
            ->where('prediction_id', $user_history_id)
            ->first();
    
        if (!$history) {
            return response()->json(['message' => 'History not found for this user'], 404);
        }
    
        // Format respon JSON untuk detail history
        $disease = $history->prediction->disease;
    
        return response()->json([
            'message' => 'History detail retrieved successfully',
            'data' => [
                'disease_name' => $disease->name ?? 'Unknown Disease',
                'confidence' => $history->prediction->confidence ?? null,
                'image_path' => asset('storage/' . $history->image_path),
                'description' => $disease->description ?? 'No description available',
                'treatment' => $disease->treatment ?? 'No general treatment available',
                'steps' => $disease->treatments->map(function ($treatment) {
                    return [
                        'step' => $treatment->step,
                        'action' => $treatment->action,
                    ];
                }),
                'created_at' => $history->created_at->toDateTimeString(),
            ],
        ], 200);
    }
    


}
