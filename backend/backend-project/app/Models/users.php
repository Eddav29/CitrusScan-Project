<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Str;

class User extends Authenticatable
{
    use Notifiable;

    protected $table = 'users';
    
    // Disable auto-incrementing and use UUID
    public $incrementing = false;

    // Use UUID as the primary key
    protected $primaryKey = 'user_id';

    // Use string instead of integer for primary key type
    protected $keyType = 'string';

    // Mass-assignable attributes
    protected $fillable = [
        'user_id', 'name', 'email', 'password',
    ];

    // Automatically generate UUID for user_id on model creation
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            if (!$model->user_id) {
                $model->user_id = (string) Str::uuid();
            }
        });
    }

    // Relationship to detections
    public function detections()
    {
        return $this->hasMany(Detection::class, 'user_id', 'user_id');
    }

    // Relationship to history
    public function histories()
    {
        return $this->hasMany(History::class, 'user_id', 'user_id');
    }
}
