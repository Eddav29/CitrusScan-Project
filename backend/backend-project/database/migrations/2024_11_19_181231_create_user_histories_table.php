<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('user_histories', function (Blueprint $table) {
            $table->uuid('id')->primary(); // ID unik untuk setiap riwayat
            $table->uuid('user_id'); // Referensi ke tabel users
            $table->uuid('prediction_id'); // Referensi ke tabel predictions
            $table->text('image_path'); // Path gambar yang diunggah pengguna
            $table->timestamp('created_at')->useCurrent(); // Waktu aktivitas
            $table->foreign('user_id')->references('user_id')->on('users')->onDelete('cascade');
            $table->foreign('prediction_id')->references('id')->on('predictions')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_histories');
    }
};
