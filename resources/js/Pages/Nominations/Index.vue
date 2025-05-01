<script setup>
import { Head, usePage, router } from '@inertiajs/vue3';
import { computed, ref, watch } from 'vue';
import { Check, Plus, Save, UserRound } from 'lucide-vue-next'
import PublicLayout from '@/Layouts/PublicLayout.vue';
import imagePath from '@/lib/image';

const page = usePage();
const images_url = computed(() => page.props.images_url);

// Get props from backend
const props = defineProps({
    leagues: Array,
    categories: Array,
    candidates: Array,
    activeLeague: Object,
    activeCategory: Object,
    userSelections: Object,
});

// ========== STATE MANAGEMENT ==========

// Current league (men/women)
const currentLeague = ref(props.activeLeague?.id || (props.leagues[0]?.id || 1));

// Selected category
const currentCategory = ref(props.activeCategory?.id || (props.categories[0]?.id || 1));

// Store selections for each category
const selections = ref(props.userSelections || {});

// Computed properties
const categoryDetails = computed(() => {
    return props.categories.find(cat => cat.id === currentCategory.value) || {};
});

const categoryCandidates = computed(() => {
    return props.candidates || [];
});

const currentSelections = computed(() => {
    const key = currentCategory.value;
    return selections.value[key] || [];
});

const selectedItems = computed(() => {
    const category = currentCategory.value;
    const itemIds = selections.value[category] || [];

    return categoryCandidates.value.filter(item => itemIds.includes(item.id));
});

// Filter categories based on league
const availableCategories = computed(() => {
    return props.categories
        .filter(category => category.league_id === currentLeague.value)
        .map(category => {
            // Determine status based on selections
            let status = 'not-started';
            const selectionCount = (selections.value[category.id] || []).length;

            if (selectionCount > 0) {
                status = selectionCount >= category.pre_nom_count ? 'completed' : 'in-progress';
            }

            return {
                id: category.id,
                title: category.name,
                status: status,
                maxSelections: category.pre_nom_count
            };
        });
});

// Overall completion progress
const completionProgress = computed(() => {
    let completed = 0;
    let total = availableCategories.value.length;

    for (const category of availableCategories.value) {
        if (category.status === 'completed') {
            completed++;
        }
    }

    return total > 0 ? Math.round((completed / total) * 100) : 0;
});

// Methods
const switchCategory = (categoryId) => {
    currentCategory.value = categoryId;
    fetchCandidatesForCategory(categoryId);
};
const switchLeague = (leagueId) => {
    router.visit(route('nominations.index', {
        league: leagueId
    }), {
        preserveState: false, // Don't preserve state to ensure fresh data
        preserveScroll: false // Don't preserve scroll position
    });
};

const isSelected = (item) => {
    return currentSelections.value.includes(item.id);
};

const toggleSelection = (item) => {
    const category = currentCategory.value;
    const selectionArray = selections.value[category] || [];
    const index = selectionArray.indexOf(item.id);

    if (index === -1) {
        // Check if max selections reached
        if (selectionArray.length >= categoryDetails.value.pre_nom_count) {
            alert(`You can only select up to ${categoryDetails.value.pre_nom_count} items`);
            return;
        }
        // Add to selections
        selections.value[category] = [...selectionArray, item.id];
    } else {
        // Remove from selections
        selections.value[category] = selectionArray.filter(id => id !== item.id);
    }
};

const saveSelections = () => {
    const count = currentSelections.value.length;
    const max = categoryDetails.value.pre_nom_count;

    // Send selections to the server
    router.post(route('nominations.save'), {
        category_id: currentCategory.value,
        selections: currentSelections.value
    }, {
        onSuccess: () => {
            alert(`Saved ${count}/${max} selections for ${categoryDetails.value.name}!`);
        }
    });
};

// Fetch candidates when category changes
function fetchCandidatesForCategory(categoryId) {
    router.visit(route('nominations.index', {
        league: currentLeague.value,
        category: categoryId
    }), {
        preserveState: true,
        preserveScroll: true,
        only: ['candidates', 'activeCategory']
    });
}

// Watch for category changes
watch(currentCategory, (newCategoryId) => {
    fetchCandidatesForCategory(newCategoryId);
});
</script>

<template>

    <Head title="Preliminary Nominations" />

    <PublicLayout title="Preliminary Nominations">
        <!-- Progress indicator -->
        <div class="mb-8">
            <div class="flex justify-between items-center mb-2">
                <h2 class="text-lg font-semibold">Your Nomination Progress</h2>
                <span class="text-sm text-green-600">
                    {{availableCategories.filter(c => c.status === 'completed').length}} of
                    {{ availableCategories.length }} categories completed
                </span>
            </div>
            <div class="w-full bg-gray-200 rounded-full h-2.5">
                <div class="bg-green-600 h-2.5 rounded-full" :style="`width: ${completionProgress}%`"></div>
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
                                <span>{{ category.title }}</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Category Content Area -->
            <div class="md:col-span-3">
                <div class="bg-white shadow rounded-lg overflow-hidden">
                    <div class="flex items-center justify-between p-4"
                        :class="categoryDetails.status === 'completed' ? 'bg-green-50' : categoryDetails.status === 'in-progress' ? 'bg-blue-50' : 'bg-gray-50'">
                        <div>
                            <h3 class="text-lg font-medium text-gray-900">{{ categoryDetails.name }}</h3>
                            <p class="text-sm text-gray-500">
                                Select {{ categoryDetails.pre_nom_count }} {{ categoryDetails.candidate_type
                                }}(s)
                                from the preliminary list
                            </p>
                        </div>
                        <div class="flex items-center space-x-2">
                            <span class="text-sm font-medium text-blue-600">
                                {{ currentSelections.length }}/{{ categoryDetails.pre_nom_count || 0 }} selected
                            </span>
                            <span :class="[
                                'px-2.5 py-0.5 rounded-full text-xs font-medium',
                                availableCategories.find(c => c.id === currentCategory)?.status === 'completed' ? 'bg-green-100 text-green-800' :
                                    availableCategories.find(c => c.id === currentCategory)?.status === 'in-progress' ? 'bg-yellow-100 text-yellow-800' :
                                        'bg-red-100 text-red-800'
                            ]">
                                {{availableCategories.find(c => c.id === currentCategory)?.status.replace('-',
                                    '') || 'Not Started'}}
                            </span>
                        </div>
                    </div>

                    <div class="p-4">
                        <!-- Loading state -->
                        <div v-if="page.props.processing" class="text-center py-10">
                            <p class="text-gray-500">Loading candidates...</p>
                        </div>

                        <!-- Empty state if no data -->
                        <div v-else-if="!categoryCandidates.length" class="text-center py-10">
                            <p class="text-gray-500">No candidates available for this category yet.</p>
                        </div>

                        <!-- Player/Coach Selection Cards -->
                        <div v-else-if="['player', 'coach'].includes(categoryDetails.candidate_type)"
                            class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                            <div v-for="item in categoryCandidates" :key="item.id"
                                :class="['border rounded-md p-3', isSelected(item) ? 'bg-blue-50 border-blue-300' : 'hover:bg-gray-50']">
                                <div class="flex items-center space-x-3">

                                    <div v-if="item.image" class="w-12 h-12 rounded-full overflow-hidden">
                                        <img :src="imagePath(`/${item.image}`)" alt="Candidate"
                                            class="w-full h-full object-cover" />
                                    </div>
                                    <div v-else
                                        class="w-12 h-12 rounded-full bg-gray-200 flex items-center justify-center">
                                        <UserRound class="w-6 h-6 text-gray-400" />
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex justify-between">
                                            <h4 class="font-medium">{{ item.name }}</h4>
                                            <button @click="toggleSelection(item)"
                                                :class="isSelected(item) ? 'text-blue-600 hover:text-blue-800' : 'text-gray-400 hover:text-blue-600'">
                                                <Check v-if="isSelected(item)" class="h-5 w-5" />
                                                <Plus v-else class="h-5 w-5" />
                                            </button>
                                        </div>
                                        <p v-if="item.team" class="text-sm text-gray-600">{{ item.team.name }}
                                            <span v-if="item.jersey_number" class="text-xs text-gray-500">#{{
                                                item.jersey_number }}</span>
                                        </p>
                                        <p v-if="item.description" class="text-sm text-gray-600">{{
                                            item.description
                                        }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Goal Selection Cards -->
                        <div v-else-if="categoryDetails.candidate_type === 'goal'"
                            class="grid grid-cols-1 lg:grid-cols-2 gap-4">
                            <div v-for="goal in categoryCandidates" :key="goal.id"
                                :class="['border rounded-md p-3', isSelected(goal) ? 'bg-blue-50 border-blue-300' : 'hover:bg-gray-50']">
                                <div class="flex items-start space-x-3">
                                    <div v-if="goal.image" class="w-12 h-12 rounded-full overflow-hidden">
                                        <img :src="imagePath(`/${goal.image}`)" alt="Goal Candidate"
                                            class="w-full h-full object-cover" />
                                    </div>
                                    <div v-else
                                        class="w-12 h-12 rounded-full bg-gray-200 flex items-center justify-center">
                                        <UserRound class="w-6 h-6 text-gray-400" />
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex justify-between">
                                            <h4 class="font-medium">{{ goal.player_name }}</h4>
                                            <button @click="toggleSelection(goal)"
                                                :class="isSelected(goal) ? 'text-blue-600 hover:text-blue-800' : 'text-gray-400 hover:text-blue-600'">
                                                <Check v-if="isSelected(goal)" class="h-5 w-5" />
                                                <Plus v-else class="h-5 w-5" />
                                            </button>
                                        </div>
                                        <div class="mt-1 flex items-center space-x-2">
                                            <p class="text-sm text-gray-600">{{ goal.name }}</p>
                                            <span class="text-xs bg-gray-100 px-2 py-1 rounded">{{ goal.date }}</span>
                                        </div>
                                        <p class="text-xs text-gray-500 mt-1">Match day: {{ goal.match_day }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Referee Selection Cards -->
                        <div v-else-if="categoryDetails.candidate_type === 'referee'"
                            class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                            <div v-for="referee in categoryCandidates" :key="referee.id"
                                :class="['border rounded-md p-3', isSelected(referee) ? 'bg-blue-50 border-blue-300' : 'hover:bg-gray-50']">
                                <div class="flex items-center space-x-3">
                                    <div v-if="referee.image" class="w-12 h-12 rounded-full overflow-hidden">
                                        <img :src="imagePath(`/${referee.image}`)" alt="Candidate"
                                            class="w-full h-full object-cover" />
                                    </div>
                                    <div v-else
                                        class="w-12 h-12 rounded-full bg-gray-200 flex items-center justify-center">
                                        <UserRound class="w-6 h-6 text-gray-400" />
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex justify-between">
                                            <h4 class="font-medium">{{ referee.name }}</h4>
                                            <button @click="toggleSelection(referee)"
                                                :class="isSelected(referee) ? 'text-blue-600 hover:text-blue-800' : 'text-gray-400 hover:text-blue-600'">
                                                <Check v-if="isSelected(referee)" class="h-5 w-5" />
                                                <Plus v-else class="h-5 w-5" />
                                            </button>
                                        </div>
                                        <p v-if="referee.description" class="text-sm text-gray-600">{{
                                            referee.description }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="border-t px-4 py-3 flex justify-end">
                        <button @click="saveSelections"
                            class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 flex items-center space-x-2"
                            :disabled="page.props.processing">
                            <Save class="h-4 w-4" />
                            <span>Save Selections ({{ currentSelections.length }}/{{
                                categoryDetails.pre_nom_count || 0 }})</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </PublicLayout>
</template>
