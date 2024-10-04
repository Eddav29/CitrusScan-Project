<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class History extends Migration
{
    public function up()
    {
        Schema::create('history', function (Blueprint $table) {
            $table->uuid('history_id')->primary();
            $table->uuid('user_id'); // Pastikan ini adalah UUID
            $table->foreign('user_id')->references('user_id')->on('users')->onDelete('cascade');
            $table->uuid('detection_id'); // Pastikan ini adalah UUID
            $table->foreign('detection_id')->references('detection_id')->on('detections')->onDelete('cascade');
            $table->timestamp('saved_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('history');
    }
}
