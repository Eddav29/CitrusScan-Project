<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class UserHistoryResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        Carbon::setLocale('id'); // Set locale to Indonesian

        return [
            'user_histories_id' => $this->user_histories_id,
            'user_id' => $this->user_id,
            'prediction_id' => $this->prediction_id,
            'image_path' => $this->image_path,
            'created_at' => Carbon::parse($this->created_at)->translatedFormat('d F Y'),
        ];
    }
}