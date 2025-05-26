<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';

const props = defineProps({
    results: Array,
    bestPlayerVotes: Array,
    bestCoachVotes: Array,
    bestYouthVotes: Array,
    bestKeeperVotes: Array,
});



</script>

<template>

    <Head title="Ibisubizo by'Itora - Voting Results" />
    <PublicLayout title="Ibisubizo by'Itora - Voting Results">
        <!-- add catoryzed results -->
        <div class="container mx-auto px-4 py-8">
            <h1 class="text-2xl font-bold mb-8">Ibisubizo by'Itora - Voting Results</h1>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                <div class="bg-white rounded-xl shadow-lg p-3 hover:shadow-xl transition-shadow">
                    <div class="flex items-center mb-6">
                        <div class="p-3 bg-blue-100 rounded-lg">
                            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                            </svg>
                        </div>
                        <h2 class="text-xl font-bold ml-3">Best Player</h2>
                    </div>
                    <ul class="space-y-3">
                        <li v-for="vote in bestPlayerVotes" :key="vote.id"
                            class="p-2 bg-gray-50 rounded-lg flex justify-between items-center">
                            <span class="font-medium">{{ vote.name }}</span>
                            <span class="bg-blue-500 text-white px-3 py-1 rounded-full text-sm">{{ vote.votes }}
                                votes</span>
                        </li>
                    </ul>
                </div>
                <div class="bg-white rounded-xl shadow-lg p-3 hover:shadow-xl transition-shadow">
                    <div class="flex items-center mb-6">
                        <div class="p-3 bg-green-100 rounded-lg">
                            <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                            </svg>
                        </div>
                        <h2 class="text-xl font-bold ml-3">Best Coach</h2>
                    </div>
                    <ul class="space-y-3">
                        <li v-for="vote in bestCoachVotes" :key="vote.id"
                            class="p-2 bg-gray-50 rounded-lg flex justify-between items-center">
                            <span class="font-medium">{{ vote.name }}</span>
                            <span class="bg-green-500 text-white px-3 py-1 rounded-full text-sm">{{ vote.votes }}
                                votes</span>
                        </li>
                    </ul>
                </div>
                <div class="bg-white rounded-xl shadow-lg p-3 hover:shadow-xl transition-shadow">
                    <div class="flex items-center mb-6">
                        <div class="p-3 bg-yellow-100 rounded-lg">
                            <svg class="w-6 h-6 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                            </svg>
                        </div>
                        <h2 class="text-xl font-bold ml-3">Best Youth</h2>
                    </div>
                    <ul class="space-y-3">
                        <li v-for="vote in bestYouthVotes" :key="vote.id"
                            class="p-2 bg-gray-50 rounded-lg flex justify-between items-center">
                            <span class="font-medium">{{ vote.name }}</span>
                            <span class="bg-yellow-500 text-white px-3 py-1 rounded-full text-sm">{{ vote.votes }}
                                votes</span>
                        </li>
                    </ul>
                </div>
                <div class="bg-white rounded-xl shadow-lg p-3 hover:shadow-xl transition-shadow">
                    <div class="flex items-center mb-6">
                        <div class="p-3 bg-purple-100 rounded-lg">
                            <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M3 21v-4m0 0V5a2 2 0 012-2h6.5l1 1H21l-3 6 3 6h-8.5l-1-1H5a2 2 0 00-2 2zm9-13.5V9" />
                            </svg>
                        </div>
                        <h2 class="text-xl font-bold ml-3">Best Keeper</h2>
                    </div>
                    <ul class="space-y-3">
                        <li v-for="vote in bestKeeperVotes" :key="vote.id"
                            class="p-2 bg-gray-50 rounded-lg flex justify-between items-center">
                            <span class="font-medium">{{ vote.name }}</span>
                            <span class="bg-purple-500 text-white px-3 py-1 rounded-full text-sm">{{ vote.votes }}
                                votes</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="max-w-7xl mx-auto px-4 py-8">
            <h1 class="text-2xl font-bold mb-8">Ibisubizo by'Itora - Voting Results</h1>

            <div class="overflow-x-auto rounded-lg border border-gray-200">
                <table class="min-w-full bg-white rounded-lg shadow-md">
                    <thead class="bg-gray-50">
                        <tr>
                            <th
                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider w-4">
                                #</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Team</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Best Player</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Best Coach</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Best Youth</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Best Keeper</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <tr v-for="(result, index) in results.data" :key="result.id" class="hover:bg-gray-50">
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{ index + 1 }}
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{ result.name }}
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ result.team }} ({{
                                result.role_label }})</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{
                                result.best_player }}
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ result.best_coach }}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ result.best_youth }}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ result.best_keeper }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </PublicLayout>
</template>

<style scoped>
.animate-scale-in {
    animation: scaleIn 0.5s ease-in-out;
}

@keyframes scaleIn {
    0% {
        transform: scale(0.9);
        opacity: 0;
    }

    100% {
        transform: scale(1);
        opacity: 1;
    }
}
</style>