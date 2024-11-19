<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class Detections extends Model
{
    use HasFactory,HasUuids;

    protected $table = 'detections';
    protected $primaryKey = 'detection_id';
    protected $fillable = [
        'user_id',
        'image_url',
        'disease_detected',
        'recommendation',
        'detected_at',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }
}
