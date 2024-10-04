<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class History extends Model
{
    protected $table = 'history';
    
    // Disable auto-incrementing and use UUID
    public $incrementing = false;

    // Use UUID as the primary key
    protected $primaryKey = 'history_id';

    // Use string instead of integer for primary key type
    protected $keyType = 'string';

    // Mass-assignable attributes
    protected $fillable = [
        'history_id', 'user_id', 'detection_id', 'saved_at',
    ];

    // Automatically generate UUID for history_id on model creation
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            if (!$model->history_id) {
                $model->history_id = (string) Str::uuid();
            }
        });
    }

    // Relationship to user
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    // Relationship to detection
    public function detection()
    {
        return $this->belongsTo(Detection::class, 'detection_id', 'detection_id');
    }
}
