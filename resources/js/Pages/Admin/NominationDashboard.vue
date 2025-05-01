<script setup>
import { Head, usePage, router } from '@inertiajs/vue3';
import { computed, ref, watch } from 'vue';
import { Download, BarChart3, PieChart, Users, Medal, Filter } from 'lucide-vue-next';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';

import imagePath from '@/lib/image';

const page = usePage();

// Get props from backend
const props = defineProps({
    leagues: Array,
    categories: Array,
    activeLeague: Object,
    activeCategory: Object,
    votingStats: Object,
    voterActivity: Object,
    categoryCompletion: Array,
});

// ========== STATE MANAGEMENT ==========

// Current league (men/women)
const currentLeague = ref(props.activeLeague?.id || (props.leagues[0]?.id || 1));

// Selected category
const currentCategory = ref(props.activeCategory?.id || (props.categories[0]?.id || 1));

// Filter states
const showFilters = ref(false);
const filterRole = ref('all');
const filterMinVotes = ref(0);

// Sort state
const sortBy = ref('votes');
const sortOrder = ref('desc');

// Computed properties
const filteredCategories = computed(() => {
    return props.categories.filter(category => category.league_id === currentLeague.value);
});

const filteredCandidates = computed(() => {
    let candidates = [...props.votingStats.candidates];

    // Sort candidates
    candidates.sort((a, b) => {
        let comparison = 0;
        if (sortBy.value === 'votes') {
            comparison = a.votes - b.votes;
        } else if (sortBy.value === 'name') {
            comparison = a.name.localeCompare(b.name);
        } else if (sortBy.value === 'percentage') {
            comparison = a.percentage - b.percentage;
        }

        return sortOrder.value === 'desc' ? -comparison : comparison;
    });

    return candidates;
});

const filteredVoters = computed(() => {
    let voters = [...props.voterActivity.activeVoters];

    // Apply role filter
    if (filterRole.value !== 'all') {
        voters = voters.filter(voter => voter.role === filterRole.value);
    }

    // Apply minimum votes filter
    if (filterMinVotes.value > 0) {
        voters = voters.filter(voter => voter.total_votes >= filterMinVotes.value);
    }

    return voters;
});

const overallCompletion = computed(() => {
    if (!props.categoryCompletion || props.categoryCompletion.length === 0) return 0;

    const totalPercentages = props.categoryCompletion.reduce((sum, category) => sum + category.completionPercentage, 0);
    return Math.round(totalPercentages / props.categoryCompletion.length);
});

const roleStats = computed(() => {
    if (!props.voterActivity || !props.voterActivity.roleActivity) return [];

    const total = props.voterActivity.roleActivity.reduce((sum, item) => sum + item.votes_count, 0);

    return props.voterActivity.roleActivity.map(item => ({
        role: item.role,
        votersCount: item.voters_count,
        votesCount: item.votes_count,
        percentage: total > 0 ? Math.round((item.votes_count / total) * 100) : 0
    }));
});

// Methods
const switchCategory = (categoryId) => {
    currentCategory.value = categoryId;
    router.visit(route('admin.nominations.dashboard', {
        league: currentLeague.value,
        category: categoryId
    }), {
        preserveState: true,
        preserveScroll: true
    });
};

const switchLeague = (leagueId) => {
    router.visit(route('admin.nominations.dashboard', {
        league: leagueId
    }), {
        preserveState: false
    });
};

const toggleSort = (field) => {
    if (sortBy.value === field) {
        sortOrder.value = sortOrder.value === 'asc' ? 'desc' : 'asc';
    } else {
        sortBy.value = field;
        sortOrder.value = 'desc';
    }
};

const exportData = () => {
    window.location.href = route('admin.nominations.export', {
        category: currentCategory.value
    });
};

const toggleFilters = () => {
    showFilters.value = !showFilters.value;
};

// Watch for category changes
watch(currentCategory, (newCategoryId) => {
    router.visit(route('admin.nominations.dashboard', {
        league: currentLeague.value,
        category: newCategoryId
    }), {
        preserveState: true,
        preserveScroll: true
    });
});
</script>

<template>

    <Head title="Nominations Dashboard" />

    <AuthenticatedLayout>
        <!-- Overview Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-white rounded-lg shadow p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-blue-100 text-blue-600">
                        <BarChart3 class="w-6 h-6" />
                    </div>
                    <div class="ml-4">
                        <h3 class="text-sm font-medium text-gray-500">Total Votes</h3>
                        <p class="text-xl font-semibold">{{ votingStats.totalVotes || 0 }}</p>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-green-100 text-green-600">
                        <Users class="w-6 h-6" />
                    </div>
                    <div class="ml-4">
                        <h3 class="text-sm font-medium text-gray-500">Active Voters</h3>
                        <p class="text-xl font-semibold">{{ voterActivity.activeVoters?.length || 0 }}</p>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-purple-100 text-purple-600">
                        <Medal class="w-6 h-6" />
                    </div>
                    <div class="ml-4">
                        <h3 class="text-sm font-medium text-gray-500">Categories</h3>
                        <p class="text-xl font-semibold">{{ categoryCompletion?.length || 0 }}</p>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-yellow-100 text-yellow-600">
                        <PieChart class="w-6 h-6" />
                    </div>
                    <div class="ml-4">
                        <h3 class="text-sm font-medium text-gray-500">Overall Completion</h3>
                        <p class="text-xl font-semibold">{{ overallCompletion }}%</p>
                    </div>
                </div>
                <div class="mt-4 w-full bg-gray-200 rounded-full h-2">
                    <div class="bg-yellow-500 h-2 rounded-full" :style="`width: ${overallCompletion}%`"></div>
                </div>
            </div>
        </div>

        <!-- League selection tabs -->
        <div class="mb-6">
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
                    <div class="px-4 py-3 bg-gray-50 border-b flex justify-between items-center">
                        <h3 class="text-lg font-medium text-gray-900">Categories</h3>
                    </div>
                    <div class="p-4">
                        <div class="space-y-2">
                            <button v-for="category in filteredCategories" :key="category.id"
                                @click="switchCategory(category.id)" :class="[
                                    'w-full text-left px-3 py-2 rounded-md flex justify-between items-center',
                                    currentCategory === category.id
                                        ? 'bg-blue-50 text-blue-700 font-medium'
                                        : 'hover:bg-gray-50'
                                ]">
                                <span>{{ category.name }}</span>
                                <span v-if="categoryCompletion" class="text-xs px-2 py-0.5 rounded-full" :class="[
                                    categoryCompletion.find(c => c.id === category.id)?.completionPercentage >= 75
                                        ? 'bg-green-100 text-green-800'
                                        : categoryCompletion.find(c => c.id === category.id)?.completionPercentage >= 40
                                            ? 'bg-yellow-100 text-yellow-800'
                                            : 'bg-red-100 text-red-800'
                                ]">
                                    {{categoryCompletion.find(c => c.id === category.id)?.completionPercentage || 0}}%
                                </span>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Category Completion Status -->
                <div class="bg-white shadow rounded-lg overflow-hidden">
                    <div class="px-4 py-3 bg-gray-50 border-b">
                        <h3 class="text-lg font-medium text-gray-900">Completion Status</h3>
                    </div>
                    <div class="p-4">
                        <ul class="space-y-4">
                            <li v-for="category in categoryCompletion" :key="category.id" class="flex flex-col">
                                <div class="flex justify-between text-sm mb-1">
                                    <span class="text-gray-600">{{ category.name }}</span>
                                    <span class="font-medium">{{ category.votersCount }}/{{ category.totalVoters
                                        }}</span>
                                </div>
                                <div class="w-full bg-gray-200 rounded-full h-2">
                                    <div class="rounded-full h-2" :style="`width: ${category.completionPercentage}%`"
                                        :class="[
                                            category.completionPercentage >= 75
                                                ? 'bg-green-500'
                                                : category.completionPercentage >= 40
                                                    ? 'bg-yellow-500'
                                                    : 'bg-red-500'
                                        ]"></div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Dashboard Content Area -->
            <div class="md:col-span-3 space-y-6">
                <!-- Voting Results -->
                <div class="bg-white shadow rounded-lg overflow-hidden">
                    <div class="px-4 py-3 bg-gray-50 border-b flex justify-between items-center">
                        <h3 class="text-lg font-medium text-gray-900">
                            Voting Results: {{ props.activeCategory?.name }}
                        </h3>
                        <button @click="exportData"
                            class="px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700 flex items-center space-x-1">
                            <Download class="w-4 h-4" />
                            <span>Export</span>
                        </button>
                    </div>
                    <div class="p-4">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead>
                                <tr>
                                    <th
                                        class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Candidate
                                    </th>
                                    <th @click="toggleSort('votes')"
                                        class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer">
                                        <div class="flex items-center space-x-1">
                                            <span>Votes</span>
                                            <span v-if="sortBy === 'votes'" class="text-blue-500">
                                                {{ sortOrder === 'desc' ? '↓' : '↑' }}
                                            </span>
                                        </div>
                                    </th>
                                    <th @click="toggleSort('percentage')"
                                        class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer">
                                        <div class="flex items-center space-x-1">
                                            <span>Percentage</span>
                                            <span v-if="sortBy === 'percentage'" class="text-blue-500">
                                                {{ sortOrder === 'desc' ? '↓' : '↑' }}
                                            </span>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <tr v-for="candidate in filteredCandidates" :key="candidate.id">
                                    <td class="px-3 py-2 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div v-if="candidate.image" class="w-8 h-8 rounded-full overflow-hidden">
                                                <img :src="imagePath(`/${candidate.image}`)" alt="Candidate"
                                                    class="w-full h-full object-cover" />
                                            </div>
                                            <div v-else
                                                class="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center">
                                                <span class="text-xs">{{ candidate.name.charAt(0) }}</span>
                                            </div>
                                            <div class="ml-2">
                                                <div class="text-sm font-medium text-gray-900">{{ candidate.name }}
                                                </div>
                                                <div v-if="candidate.team" class="text-xs text-gray-500">{{
                                                    candidate.team }}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-3 py-2 whitespace-nowrap">
                                        <div class="text-sm">{{ candidate.votes }}</div>
                                    </td>
                                    <td class="px-3 py-2 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="text-sm mr-2">{{ candidate.percentage }}%</div>
                                            <div class="w-24 bg-gray-200 rounded-full h-2">
                                                <div class="bg-blue-600 h-2 rounded-full"
                                                    :style="`width: ${candidate.percentage}%`"></div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Role Distribution -->
                    <div class="bg-white shadow rounded-lg overflow-hidden">
                        <div class="px-4 py-3 bg-gray-50 border-b">
                            <h3 class="text-lg font-medium text-gray-900">Voting by Role</h3>
                        </div>
                        <div class="p-4">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead>
                                    <tr>
                                        <th
                                            class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Role
                                        </th>
                                        <th
                                            class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Voters
                                        </th>
                                        <th
                                            class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Votes
                                        </th>
                                        <th
                                            class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            %
                                        </th>
                                    </tr>
                                </thead>
                                <!-- <tbody class="bg-white divide-y divide-gray-200">
                                    <tr v-for="item in roleStats" :key="item.role">
                                        <td class="px-3 py-2 whitespace-nowrap">
                                            <div class="text-sm capitalize">{{ voter.role }}</div>
                                        </td>
                                        <td class="px-3 py-2 whitespace-nowrap">
                                            <div class="text-sm">{{ voter.categories_voted }}</div>
                                        </td>
                                        <td class="px-3 py-2 whitespace-nowrap">
                                            <div class="text-sm">{{ voter.total_votes }}</div>
                                        </td>
                                    </tr>
                                </tbody> -->
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
