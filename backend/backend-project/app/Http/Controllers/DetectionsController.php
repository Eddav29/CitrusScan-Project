<?php

namespace App\Http\Controllers;

use App\Models\Detections;
use Illuminate\Http\Request;
use App\Http\Resources\DetectionResource;

class DetectionsController extends Controller
{
    public function index()
    {
        $detections = Detections::all();

        return response()->json([
            'success' => true,
            'message' => 'Detections fetched successfully',
            'data'    => DetectionResource::collection($detections),
        ], 200); // Status 200 OK
    }

    public function show($id)
    {
        $detection = Detections::find($id);

        if ($detection) {
            return response()->json([
                'success' => true,
                'message' => 'Detection found successfully',
                'data'    => new DetectionResource($detection),
            ], 200); // Status 200 OK
        }

        return response()->json([
            'success' => false,
            'message' => 'Detection not found',
        ], 404); // Status 404 Not Found
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'user_id'          => 'required|exists:users,user_id',
            'image_url'        => 'required|string',
            'disease_detected' => 'required|string',
            'recommendation'   => 'required|string',
            'detected_at'      => 'required|date',
        ]);

        $detection = Detections::create($validatedData);

        return response()->json([
            'success' => true,
            'message' => 'Detection created successfully',
            'data'    => new DetectionResource($detection),
        ], 201); // Status 201 Created
    }

    public function update(Request $request, $id)
    {
        $detection = Detections::find($id);

        if (!$detection) {
            return response()->json([
                'success' => false,
                'message' => 'Detection not found',
            ], 404); // Status 404 Not Found
        }

        $validatedData = $request->validate([
            'user_id'          => 'sometimes|exists:users,user_id',
            'image_url'        => 'sometimes|string',
            'disease_detected' => 'sometimes|string',
            'recommendation'   => 'sometimes|string',
            'detected_at'      => 'sometimes|date',
        ]);

        $detection->update($validatedData);

        return response()->json([
            'success' => true,
            'message' => 'Detection updated successfully',
            'data'    => new DetectionResource($detection),
        ], 200); // Status 200 OK
    }

    public function destroy($id)
    {
        $detection = Detections::find($id);

        if (!$detection) {
            return response()->json([
                'success' => false,
                'message' => 'Detection not found',
            ], 404); // Status 404 Not Found
        }

        $detection->delete();

        return response()->json([
            'success' => true,
            'message' => 'Detection deleted successfully',
        ], 200); // Status 200 OK
    }
}
