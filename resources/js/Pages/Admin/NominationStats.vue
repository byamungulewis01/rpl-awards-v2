<script setup>
import { Head, usePage, router } from '@inertiajs/vue3';
import { computed, ref, watch } from 'vue';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { Check, ChevronDown, Download, Filter, UserRound } from 'lucide-vue-next';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';

import imagePath from '@/lib/image';

const page = usePage();

// Define props received from the controller
const props = defineProps({
    leagues: Array,
    categories: Array,
    activeLeague: Object,
    activeCategory: Object,
    candidatesWithVotes: Array,
    votingStats: Object,
    voters: Array
});

// Handle state management
const currentLeague = ref(props.activeLeague?.id || (props.leagues[0]?.id || 1));
const currentCategory = ref(props.activeCategory?.id || (props.categories[0]?.id || 1));
const sortBy = ref('vote_count');
const sortOrder = ref('desc');
const showVoters = ref(false);
const searchTerm = ref('');

// Filtered categories based on league
const availableCategories = computed(() => {
    return props.categories.filter(category => category.league_id === currentLeague.value);
});

// Format data for charts
const chartData = computed(() => {
    return props.candidatesWithVotes.map(candidate => ({
        name: candidate.name,
        votes: candidate.vote_count
    })).slice(0, 10); // Top 10 for readability
});

// Computed properties for sorting and filtering
const sortedCandidates = computed(() => {
    let sorted = [...props.candidatesWithVotes];

    if (sortBy.value === 'vote_count') {
        sorted = sorted.sort((a, b) => {
            return sortOrder.value === 'desc'
                ? b.vote_count - a.vote_count
                : a.vote_count - b.vote_count;
        });
    } else if (sortBy.value === 'name') {
        sorted = sorted.sort((a, b) => {
            return sortOrder.value === 'desc'
                ? b.name.localeCompare(a.name)
                : a.name.localeCompare(b.name);
        });
    }

    return sorted;
});

const filteredVoters = computed(() => {
    if (!searchTerm.value) return props.voters;

    return props.voters.filter(voter =>
        voter.name.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
        voter.email.toLowerCase().includes(searchTerm.value.toLowerCase())
    );
});

// Calculate stats
const multipleVoteCandidates = computed(() => {
    return props.candidatesWithVotes.filter(c => c.vote_count > 1).length;
});

const singleVoteCandidates = computed(() => {
    return props.candidatesWithVotes.filter(c => c.vote_count === 1).length;
});

const noVoteCandidates = computed(() => {
    return props.candidatesWithVotes.filter(c => c.vote_count === 0).length;
});

// Methods
const switchLeague = (leagueId) => {
    router.visit(route('admin.nominations.stats', {
        league: leagueId
    }), {
        preserveState: false
    });
};

const switchCategory = (categoryId) => {
    router.visit(route('admin.nominations.stats', {
        league: currentLeague.value,
        category: categoryId
    }), {
        preserveState: false
    });
};

const toggleSort = (column) => {
    if (sortBy.value === column) {
        sortOrder.value = sortOrder.value === 'asc' ? 'desc' : 'asc';
    } else {
        sortBy.value = column;
        sortOrder.value = 'desc';
    }
};

const toggleVotersList = () => {
    showVoters.value = !showVoters.value;
};

const viewCandidateDetail = (candidateId) => {
    router.visit(route('admin.nominations.candidate-detail', candidateId));
};

const exportToCSV = () => {
    // Create CSV content
    let csv = 'Candidate Name,Team,Votes\n';
    sortedCandidates.value.forEach(candidate => {
        csv += `"${candidate.name}","${candidate.team?.name || ''}",${candidate.vote_count}\n`;
    });

    // Create download link
    const blob = new Blob([csv], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.setAttribute('hidden', '');
    a.setAttribute('href', url);
    a.setAttribute('download', `${props.activeCategory.name}-nominations.csv`);
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
};

// Watch for changes
watch(currentCategory, (newValue) => {
    switchCategory(newValue);
});
</script>

<template>

    <Head title="Nomination Statistics - Admin" />

    <AuthenticatedLayout title="Nomination Statistics">
        <div class="mb-8">
            <div class="flex justify-between items-center mb-4">
                <h1 class="text-2xl font-bold text-gray-900">Nomination Analytics</h1>
                <button @click="exportToCSV"
                    class="flex items-center px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
                    <Download class="w-4 h-4 mr-2" />
                    Export CSV
                </button>
            </div>

            <!-- League selection tabs -->
            <div class="border-b border-gray-200">
                <nav class="flex -mb-px space-x-8">
                    <button v-for="league in props.leagues" :key="league.id" @click="switchLeague(league.id)" :class="[
                        'whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm',
                        currentLeague === league.id
                            ? 'border-blue-500 text-blue-600'
                            : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                    ]">
                        {{ league.name }}
                    </button>
                </nav>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
            <!-- Category Selector Sidebar -->
            <div class="md:col-span-1">
                <div class="bg-white shadow rounded-lg overflow-hidden mb-6">
                    <div class="px-4 py-3 bg-gray-50 border-b">
                        <h3 class="text-lg font-medium text-gray-900">Categories</h3>
                    </div>
                    <div class="p-4">
                        <div class="space-y-2">
                            <button v-for="category in availableCategories" :key="category.id"
                                @click="switchCategory(category.id)" :class="[
                                    'w-full text-left px-3 py-2 rounded-md flex justify-between items-center',
                                    currentCategory === category.id
                                        ? 'bg-blue-50 text-blue-700 font-medium'
                                        : 'hover:bg-gray-50'
                                ]">
                                <span>{{ category.name }}</span>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="bg-white shadow rounded-lg overflow-hidden mb-6">
                    <div class="px-4 py-3 bg-gray-50 border-b">
                        <h3 class="text-lg font-medium text-gray-900">Overview</h3>
                    </div>
                    <div class="p-4 space-y-4">
                        <div class="flex justify-between items-center p-3 bg-blue-50 rounded-md">
                            <span class="text-blue-700">Total Voters:</span>
                            <span class="font-medium">{{ votingStats.total_voters }}</span>
                        </div>
                        <div class="flex justify-between items-center p-3 bg-green-50 rounded-md">
                            <span class="text-green-700">Total Votes:</span>
                            <span class="font-medium">{{ votingStats.total_votes }}</span>
                        </div>
                        <div class="flex justify-between items-center p-3 bg-purple-50 rounded-md">
                            <span class="text-purple-700">Completion Rate:</span>
                            <span class="font-medium">{{ votingStats.completion_rate }}%</span>
                        </div>
                        <div class="flex justify-between items-center p-3 bg-yellow-50 rounded-md">
                            <span class="text-yellow-700">Multiple Vote Candidates:</span>
                            <span class="font-medium">{{ multipleVoteCandidates }}</span>
                        </div>
                        <div class="flex justify-between items-center p-3 bg-red-50 rounded-md">
                            <span class="text-red-700">Single Vote Candidates:</span>
                            <span class="font-medium">{{ singleVoteCandidates }}</span>
                        </div>
                        <div class="flex justify-between items-center p-3 bg-gray-50 rounded-md">
                            <span class="text-gray-700">No Vote Candidates:</span>
                            <span class="font-medium">{{ noVoteCandidates }}</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="md:col-span-3">
                <!-- Chart Section -->
                <div class="bg-white shadow rounded-lg mb-6 p-4">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">Top 10 Candidates by Votes</h3>
                    <!-- <div class="h-64">
                        <ResponsiveContainer width="100%" height="100%">
                            <BarChart data={chartData} margin={{ top: 20, right: 30, left: 20, bottom: 5 }}>
                                <CartesianGrid strokeDasharray="3 3" />
                                <XAxis dataKey="name" />
                                <YAxis />
                                <Tooltip />
                                <Bar dataKey="votes" fill="#3b82f6" />
                            </BarChart>
                        </ResponsiveContainer>
                    </div> -->
                </div>

                <!-- Candidates Table -->
                <div class="bg-white shadow rounded-lg mb-6 overflow-hidden">
                    <div class="px-4 py-3 bg-gray-50 border-b">
                        <h3 class="text-lg font-medium text-gray-900">{{ props.activeCategory?.name }} - All Candidates
                        </h3>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col"
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        <button class="flex items-center" @click="toggleSort('name')">
                                            Candidate
                                            <ChevronDown v-if="sortBy === 'name'"
                                                :class="['w-4 h-4 ml-1', sortOrder === 'desc' ? '' : 'transform rotate-180']" />
                                        </button>
                                    </th>
                                    <th scope="col"
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Team
                                    </th>
                                    <th scope="col"
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        <button class="flex items-center" @click="toggleSort('vote_count')">
                                            Votes
                                            <ChevronDown v-if="sortBy === 'vote_count'"
                                                :class="['w-4 h-4 ml-1', sortOrder === 'desc' ? '' : 'transform rotate-180']" />
                                        </button>
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <template v-if="sortedCandidates.length">
                                    <tr v-for="candidate in sortedCandidates" :key="candidate.id"
                                        @click="viewCandidateDetail(candidate.id)"
                                        class="hover:bg-gray-50 cursor-pointer">
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div v-if="candidate.image" class="flex-shrink-0 h-10 w-10">
                                                    <img :src="imagePath(`/${candidate.image}`)"
                                                        class="h-10 w-10 rounded-full object-cover"
                                                        :alt="candidate.name" />
                                                </div>
                                                <div v-else
                                                    class="flex-shrink-0 h-10 w-10 bg-gray-100 rounded-full flex items-center justify-center">
                                                    <UserRound class="h-5 w-5 text-gray-400" />
                                                </div>
                                                <div class="ml-4">
                                                    <div class="text-sm font-medium text-gray-900">{{ candidate.name }}
                                                    </div>
                                                    <div v-if="candidate.jersey_number" class="text-sm text-gray-500">
                                                        #{{ candidate.jersey_number }}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            {{ candidate.team?.name || '-' }}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <span :class="[
                                                    'px-2 inline-flex text-xs leading-5 font-semibold rounded-full',
                                                    candidate.vote_count > 1 ? 'bg-green-100 text-green-800' :
                                                        candidate.vote_count === 1 ? 'bg-yellow-100 text-yellow-800' :
                                                            'bg-gray-100 text-gray-800'
                                                ]">
                                                    {{ candidate.vote_count }}
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                </template>
                                <tr v-else>
                                    <td colspan="3"
                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">
                                        No candidates found
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Voters Section -->
                <div class="bg-white shadow rounded-lg mb-6 overflow-hidden">
                    <div class="px-4 py-3 bg-gray-50 border-b flex justify-between items-center">
                        <h3 class="text-lg font-medium text-gray-900">Voters ({{ filteredVoters.length }})</h3>
                        <button @click="toggleVotersList" class="text-blue-600 hover:text-blue-800">
                            {{ showVoters ? 'Hide Voters' : 'Show Voters' }}
                        </button>
                    </div>
                    <div v-if="showVoters" class="p-4">
                        <div class="mb-4">
                            <input type="text" v-model="searchTerm" placeholder="Search voters..."
                                class="w-full p-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500" />
                        </div>
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Voter
                                        </th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Role
                                        </th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            #
                                            Selections</th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Candidates Selected</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <template v-if="filteredVoters.length">
                                        <tr v-for="voter in filteredVoters" :key="voter.id">
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm font-medium text-gray-900">{{ voter.name }}</div>
                                                <div class="text-sm text-gray-500">{{ voter.email }}</div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                {{ voter.role }}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                {{ voter.selections_count }}
                                            </td>
                                            <td class="px-6 py-4 text-sm text-gray-500">
                                                <div class="max-w-md truncate">
                                                    {{ voter.selections.join(', ') }}
                                                </div>
                                            </td>
                                        </tr>
                                    </template>
                                    <tr v-else>
                                        <td colspan="4"
                                            class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">
                                            No voters found
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
