<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class DiseaseTreatmentResource extends JsonResource
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
            'disease_treatments_id' => $this->disease_treatments_id,
            'disease_id' => $this->disease_id,
            'step' => $this->step,
            'action' => $this->action,
            'created_at' => Carbon::parse($this->created_at)->translatedFormat('d F Y'),
            'updated_at' => Carbon::parse($this->updated_at)->translatedFormat('d F Y'),
        ];
    }
}