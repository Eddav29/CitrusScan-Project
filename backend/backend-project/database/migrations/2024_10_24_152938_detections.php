<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

class Detections extends Migration
{
    public function up()
    {
        Schema::create('detections', function (Blueprint $table) {
            $table->uuid('detection_id')->primary();
            $table->uuid('user_id'); // Pastikan ini adalah UUID
            $table->foreign('user_id')->references('user_id')->on('users')->onDelete('cascade');
            $table->string('image_url');
            $table->string('disease_detected');
            $table->text('recommendation');
            $table->timestamp('detected_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('detections');
    }
}
