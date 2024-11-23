<?php

namespace Tests\Unit;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

class DiseaseApiTest extends TestCase
{
    use RefreshDatabase;

    /** @test */
    public function it_returns_a_list_of_disease_names()
    {
        // Act: Panggil endpoint untuk daftar nama penyakit
        $response = $this->get('/api/diseases');

        // Assert: Pastikan response berisi daftar nama penyakit
        $response->assertStatus(200);

        // Opsional: Validasi data di response, pastikan sesuai format
        $response->assertJsonStructure([
            '*' => ['name'], // Pastikan response berisi array dengan key 'name'
        ]);
    }

    /** @test */
    public function it_returns_disease_details_with_treatment_steps()
    {
        // Arrange: Tambahkan data dummy penyakit dan langkah perawatan
        $disease = \App\Models\Disease::factory()->create([
            'disease_id' => \Str::uuid(),
            'name' => 'Test Disease',
            'description' => 'This is a test disease.',
            'treatment' => 'Take rest and stay hydrated.',
        ]);

        \App\Models\DiseaseTreatment::factory()->create([
            'disease_treatments_id' => \Str::uuid(),
            'disease_id' => $disease->disease_id,
            'step' => 1,
            'action' => 'Drink water regularly.',
        ]);

        \App\Models\DiseaseTreatment::factory()->create([
            'disease_treatments_id' => \Str::uuid(),
            'disease_id' => $disease->disease_id,
            'step' => 2,
            'action' => 'Get enough sleep.',
        ]);

        // Act: Panggil endpoint untuk detail penyakit
        $response = $this->get('/api/diseases/' . $disease->disease_id);

        // Assert: Pastikan response sesuai
        $response->assertStatus(200)
            ->assertJsonStructure([
                'name',
                'description',
                'treatment',
                'steps' => [
                    '*' => ['step', 'action'],
                ],
            ]);
    }


    /** @test */
    public function it_returns_404_when_disease_not_found()
    {
        // Act: Panggil endpoint dengan ID yang tidak ada
        $response = $this->get('/api/diseases/invalid-id');

        // Assert: Pastikan respons adalah 404
        $response->assertStatus(404)
                 ->assertJson(['message' => 'Disease not found']);
    }
}
