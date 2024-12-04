<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserHistory extends Model
{
    use HasFactory;

    protected $primaryKey = 'user_histories_id';
    public $incrementing = false;
    protected $keyType = 'string';
    

    protected $fillable = [
        'user_histories_id',
        'user_id',
        'prediction_id',
        'image_path',
    ];

    public function prediction()
    {
        return $this->belongsTo(Prediction::class, 'prediction_id', 'prediction_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }
}
