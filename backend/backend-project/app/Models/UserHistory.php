<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class UserHistory extends Model
{
    use HasFactory, HasUuids;

    protected $table = 'user_histories';
    protected $primaryKey = 'user_histories_id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'user_histories_id',
        'user_id',
        'prediction_id',
        'image_path',
        'created_at', 
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    public function prediction()
    {
        return $this->belongsTo(Prediction::class, 'prediction_id', 'prediction_id');
    }
}