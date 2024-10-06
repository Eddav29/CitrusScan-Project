<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject
{
    use Notifiable, HasFactory;

    protected $table = 'users';
    
    public $incrementing = false;
    protected $primaryKey = 'user_id';
    protected $keyType = 'string';

    // Attributes that are mass assignable
    protected $fillable = [
        'user_id', 'name', 'email', 'password',
    ];

    // Hide password from array or JSON
    protected $hidden = [
        'password',
        'remember_token',
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

    // Hash password when setting
    public function setPasswordAttribute($value)
    {
        $this->attributes['password'] = bcrypt($value);
    }

    // Relationships
    public function detections()
    {
        return $this->hasMany(Detection::class, 'user_id', 'user_id');
    }

    public function histories()
    {
        return $this->hasMany(History::class, 'user_id', 'user_id');
    }

    // JWT implementation
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }
}
