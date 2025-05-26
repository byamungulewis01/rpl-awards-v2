<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use App\Models\CoachCaptainVote;
use Illuminate\Http\Resources\Json\JsonResource;

class VoterResultResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'team' => $this->team,
            'role_label' => $this->role_label,
            'best_player' => CoachCaptainVote::where('user_id', $this->id)->where('category_id', 1)->first()->candidate->name ?? 'N/A',
            'best_coach' => CoachCaptainVote::where('user_id', $this->id)->where('category_id', 3)->first()->candidate->name ?? 'N/A',
            'best_youth' => CoachCaptainVote::where('user_id', $this->id)->where('category_id', 4)->first()->candidate->name ?? 'N/A',
            'best_keeper' => CoachCaptainVote::where('user_id', $this->id)->where('category_id', 5)->first()->candidate->name ?? 'N/A',
        ];
    }
}
