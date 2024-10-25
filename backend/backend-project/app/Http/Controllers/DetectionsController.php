<?php

namespace App\Http\Controllers;

use App\Models\Detections;
use Illuminate\Http\Request;
use App\Http\Resources\DetectionResource;
use Illuminate\Support\Facades\Storage;

class DetectionsController extends Controller
{
    public function index()
    {
        $detections = Detections::all();

        return response()->json([
            'success' => true,
            'message' => 'Detections fetched successfully',
            'data'    => DetectionResource::collection($detections),
        ], 200);
    }

    public function show($id)
    {
        $detection = Detections::find($id);

        if ($detection) {
            return response()->json([
                'success' => true,
                'message' => 'Detection found successfully',
                'data'    => new DetectionResource($detection),
            ], 200);
        }

        return response()->json([
            'success' => false,
            'message' => 'Detection not found',
        ], 404);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'user_id'          => 'required|exists:users,user_id',
            'image'            => 'required|image|mimes:jpeg,png,jpg|max:2048',
            'disease_detected' => 'required|string',
            'recommendation'   => 'required|string',
            'detected_at'      => 'required|date',
        ]);

        // Handle image upload
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            
            // Save image to storage
            $path = $image->storeAs('public/detections', $imageName);
            
            // Generate public URL
            $imageUrl = Storage::url($path);
            
            // Replace image file with URL in validated data
            $validatedData['image_url'] = $imageUrl;
            unset($validatedData['image']);
        }

        $detection = Detections::create($validatedData);

        return response()->json([
            'success' => true,
            'message' => 'Detection created successfully',
            'data'    => new DetectionResource($detection),
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $detection = Detections::find($id);

        if (!$detection) {
            return response()->json([
                'success' => false,
                'message' => 'Detection not found',
            ], 404);
        }

        $validatedData = $request->validate([
            'user_id'          => 'sometimes|exists:users,user_id',
            'image'            => 'sometimes|image|mimes:jpeg,png,jpg|max:2048',
            'disease_detected' => 'sometimes|string',
            'recommendation'   => 'sometimes|string',
            'detected_at'      => 'sometimes|date',
        ]);

        // Handle image update
        if ($request->hasFile('image')) {
            // Delete old image if exists
            if ($detection->image_url) {
                $oldPath = str_replace('/storage/', 'public/', $detection->image_url);
                Storage::delete($oldPath);
            }

            $image = $request->file('image');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            
            // Save new image
            $path = $image->storeAs('public/detections', $imageName);
            
            // Generate public URL
            $imageUrl = Storage::url($path);
            
            // Replace image file with URL in validated data
            $validatedData['image_url'] = $imageUrl;
            unset($validatedData['image']);
        }

        $detection->update($validatedData);

        return response()->json([
            'success' => true,
            'message' => 'Detection updated successfully',
            'data'    => new DetectionResource($detection),
        ], 200);
    }

    public function destroy($id)
    {
        $detection = Detections::find($id);

        if (!$detection) {
            return response()->json([
                'success' => false,
                'message' => 'Detection not found',
            ], 404);
        }

        // Delete image from storage if exists
        if ($detection->image_url) {
            $path = str_replace('/storage/', 'public/', $detection->image_url);
            Storage::delete($path);
        }

        $detection->delete();

        return response()->json([
            'success' => true,
            'message' => 'Detection deleted successfully',
        ], 200);
    }
}