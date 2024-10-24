<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DetectionsResource extends JsonResource
{
    public $status;
    public $message;
    public $resource;

    public function __construct($status, $message, $resource)
    {
        parent::__construct($resource);
        $this->status  = $status;
        $this->message = $message;
    }

    public function toArray(Request $request): array
    {
        return [
            'success'   => $this->status,
            'message'   => $this->message,
            'data'      => [
                'detection_id'    => $this->detection_id,
                'user_id'         => $this->user_id,
                'image_url'       => $this->image_url,
                'disease_detected'=> $this->disease_detected,
                'recommendation'  => $this->recommendation,
                'detected_at'     => $this->detected_at,
                'user'            => new UserResource($this->whenLoaded('user')),
            ]
        ];
    }
}
