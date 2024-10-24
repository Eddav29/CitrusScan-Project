<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class HistoryResource extends JsonResource
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
                'history_id'    => $this->history_id,
                'user_id'       => $this->user_id,
                'detection_id'  => $this->detection_id,
                'saved_at'      => $this->saved_at,
                'user'          => new UserResource($this->whenLoaded('user')),
                'detection'     => new DetectionsResource($this->whenLoaded('detection')),
            ]
        ];
    }
}
