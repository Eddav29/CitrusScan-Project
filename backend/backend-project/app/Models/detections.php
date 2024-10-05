<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;
use Illuminate\Database\Eloquent\Casts\Attribute;

class Detections extends Model
{
    protected $table = 'detections';
    
    // Disable auto-incrementing and use UUID
    public $incrementing = false;

    // Use UUID as the primary key
    protected $primaryKey = 'detection_id';

    // Use string instead of integer for primary key type
    protected $keyType = 'string';

    // Mass-assignable attributes
    protected $fillable = [
        'detection_id', 'user_id', 'image_url', 'disease_detected', 'recommendation'
    ];

    // Automatically generate UUID for detection_id on model creation
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            if (!$model->detection_id) {
                $model->detection_id = (string) Str::uuid();
            }
        });
    }

    // Relationship to user
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    // Relationship to history
    public function histories()
    {
        return $this->hasMany(History::class, 'detection_id', 'detection_id');
    }

    // Accessor for image_url to return full storage URL
    protected function imageUrl(): Attribute
    {
        return Attribute::make(
            get: fn ($imageUrl) => url('/storage/detections/' . $imageUrl),
        );
    }
}
