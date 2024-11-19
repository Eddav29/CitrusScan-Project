<?php

namespace App\Http\Controllers;

use App\Models\History;
use Illuminate\Http\Request;
use App\Http\Resources\HistoryResource;

class HistoryController extends Controller
{
    public function index()
    {
        $histories = History::all();

        return response()->json([
            'success' => true,
            'message' => 'Histories fetched successfully',
            'data'    => $histories,
        ], 200); // Status 200 OK
    }

    public function show($id)
    {
        $history = History::find($id);

        if ($history) {
            return response()->json([
                'success' => true,
                'message' => 'History found successfully',
                'data'    => $history,
            ], 200); // Status 200 OK
        }

        return response()->json([
            'success' => false,
            'message' => 'History not found',
        ], 404); // Status 404 Not Found
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'user_id'      => 'required|exists:users,user_id',
            'detection_id' => 'required|exists:detections,detection_id',
            'saved_at'     => 'required|date',
        ]);

        $history = History::create($validatedData);

        return response()->json([
            'success' => true,
            'message' => 'History created successfully',
            'data'    => $history,
        ], 201); // Status 201 Created
    }

    public function update(Request $request, $id)
    {
        $history = History::find($id);

        if (!$history) {
            return response()->json([
                'success' => false,
                'message' => 'History not found',
            ], 404); // Status 404 Not Found
        }

        $validatedData = $request->validate([
            'user_id'      => 'sometimes|exists:users,user_id',
            'detection_id' => 'sometimes|exists:detections,detection_id',
            'saved_at'     => 'sometimes|date',
        ]);

        $history->update($validatedData);

        return response()->json([
            'success' => true,
            'message' => 'History updated successfully',
            'data'    => $history,
        ], 200); // Status 200 OK
    }

    public function destroy($id)
    {
        $history = History::find($id);

        if (!$history) {
            return response()->json([
                'success' => false,
                'message' => 'History not found',
            ], 404); // Status 404 Not Found
        }

        $history->delete();

        return response()->json([
            'success' => true,
            'message' => 'History deleted successfully',
        ], 200); // Status 200 OK
    }
}
