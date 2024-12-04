<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;
use App\Models\User;

class UpdateProfileTest extends TestCase
{
    use RefreshDatabase;

    public function test_user_can_view_profile_after_login()
    {
        $user = User::factory()->create([
            'email' => 'testuser@example.com',
            'password' => Hash::make('password'),
        ]);

        $loginResponse = $this->postJson('/api/login', [
            'email' => 'testuser@example.com',
            'password' => 'password',
        ]);

        $loginResponse->assertStatus(200);
        $token = $loginResponse->json('access_token');

        $profileResponse = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->getJson('/api/profile');

        $profileResponse->assertStatus(200);
        $profileResponse->assertJson(['user' => ['email' => 'testuser@example.com']]);
    }

    public function test_user_can_update_name_and_email()
    {
        $user = User::factory()->create([
            'email' => 'testuser@example.com',
            'password' => Hash::make('password'),
        ]);

        $loginResponse = $this->postJson('/api/login', [
            'email' => 'testuser@example.com',
            'password' => 'password',
        ]);

        $loginResponse->assertStatus(200);
        $token = $loginResponse->json('access_token');

        $updateData = [
            'name' => 'Updated Name',
            'email' => 'updatedemail@example.com',
        ];

        $updateResponse = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->putJson('/api/profile', $updateData);

        $updateResponse->assertStatus(200);
        $this->assertDatabaseHas('users', [
            'user_id' => $user->user_id, // Ubah 'id' menjadi 'user_id'
            'name' => 'Updated Name',
            'email' => 'updatedemail@example.com',
        ]);
        
    }

    public function test_user_can_update_password()
    {
        $user = User::factory()->create([
            'email' => 'testuser@example.com',
            'password' => Hash::make('password'),
        ]);

        $loginResponse = $this->postJson('/api/login', [
            'email' => 'testuser@example.com',
            'password' => 'password',
        ]);

        $loginResponse->assertStatus(200);
        $token = $loginResponse->json('access_token');

        $updatePasswordData = [
            'old_password' => 'password',
            'new_password' => 'newpassword',
            'new_password_confirmation' => 'newpassword',
        ];

        $updatePasswordResponse = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->putJson('/api/update-password', $updatePasswordData);

        $updatePasswordResponse->assertStatus(200);
        $this->assertTrue(Hash::check('newpassword', $user->fresh()->password));
    }
}