<script setup>
import { Head, usePage } from '@inertiajs/vue3';
import { computed, ref } from 'vue';
import { Check, Plus, Save } from 'lucide-vue-next'
import imagePath from '@/lib/image';

const page = usePage();
const images_url = computed(() => page.props.images_url);

// Dummy team logos - using placeholder URLs for team logos
const teamLogos = {
    'APR FC': '/apr-fc-logo.png',
    'AS Kigali': '/kiyovu.jpg',
    'Rayon Sports': '/rayon-sports-logo.jpeg',
    'Police FC': '/apr-fc-logo.png',
    'Musanze FC': '/apr-fc-logo.png',
    'Gasogi United': '/gasogifc.jpg',
}

// ========== DATA FOR ALL CATEGORIES ==========

// Dummy players data
const players = ref([
    { id: 1, name: 'Olivier Niyonzima', jersey_number: 8, team: { name: 'APR FC', logo_url: teamLogos['APR FC'] } },
    { id: 2, name: 'Jacques Tuyisenge', jersey_number: 10, team: { name: 'AS Kigali', logo_url: teamLogos['AS Kigali'] } },
    { id: 3, name: 'Djabel Manishimwe', jersey_number: 21, team: { name: 'Police FC', logo_url: teamLogos['Police FC'] } },
    { id: 4, name: 'Emery Bayisenge', jersey_number: 4, team: { name: 'Rayon Sports', logo_url: teamLogos['Rayon Sports'] } },
    { id: 5, name: 'Thierry Manzi', jersey_number: 5, team: { name: 'APR FC', logo_url: teamLogos['APR FC'] } },
    { id: 6, name: 'Fitina Omborenga', jersey_number: 9, team: { name: 'Rayon Sports', logo_url: teamLogos['Rayon Sports'] } },
    { id: 7, name: 'Haruna Niyonzima', jersey_number: 10, team: { name: 'APR FC', logo_url: teamLogos['APR FC'] } },
    { id: 8, name: 'Justin Mico', jersey_number: 11, team: { name: 'Police FC', logo_url: teamLogos['Police FC'] } },
    { id: 9, name: 'Innocent Nshuti', jersey_number: 7, team: { name: 'APR FC', logo_url: teamLogos['APR FC'] } },
    { id: 10, name: 'Rachid Kalisa', jersey_number: 20, team: { name: 'Musanze FC', logo_url: teamLogos['Musanze FC'] } },
    { id: 11, name: 'Dominique Savio Nshuti', jersey_number: 14, team: { name: 'AS Kigali', logo_url: teamLogos['AS Kigali'] } },
    { id: 12, name: 'Ismael Nshutiyamagara', jersey_number: 6, team: { name: 'Gasogi United', logo_url: teamLogos['Gasogi United'] } }
])

// Dummy goals data
const goals = ref([
    { id: 1, scorer: 'Jacques Tuyisenge', match: 'AS Kigali vs Rayon Sports', date: '12 Sep 2024', minute: 35, video_url: '/goal1.mp4' },
    { id: 2, scorer: 'Fitina Omborenga', match: 'Rayon Sports vs APR FC', date: '28 Oct 2024', minute: 89, video_url: '/goal2.mp4' },
    { id: 3, scorer: 'Yannick Mukunzi', match: 'Rayon Sports vs Police FC', date: '05 Nov 2024', minute: 45, video_url: '/goal3.mp4' },
    { id: 4, scorer: 'Innocent Nshuti', match: 'APR FC vs Gasogi United', date: '19 Dec 2024', minute: 76, video_url: '/goal4.mp4' },
    { id: 5, scorer: 'Haruna Niyonzima', match: 'APR FC vs AS Kigali', date: '02 Jan 2025', minute: 12, video_url: '/goal5.mp4' },
    { id: 6, scorer: 'Justin Mico', match: 'Police FC vs Musanze FC', date: '17 Jan 2025', minute: 54, video_url: '/goal6.mp4' },
    { id: 7, scorer: 'Djabel Manishimwe', match: 'Police FC vs Rayon Sports', date: '30 Jan 2025', minute: 67, video_url: '/goal7.mp4' },
    { id: 8, scorer: 'Maxime Sekamana', match: 'AS Kigali vs Musanze FC', date: '14 Feb 2025', minute: 22, video_url: '/goal8.mp4' },
    { id: 9, scorer: 'Kevin Muhire', match: 'Rayon Sports vs Gasogi United', date: '05 Mar 2025', minute: 81, video_url: '/goal9.mp4' },
    { id: 10, scorer: 'Fred Muhozi', match: 'Gasogi United vs APR FC', date: '19 Mar 2025', minute: 90, video_url: '/goal10.mp4' },
])

// Dummy coaches data
const coaches = ref([
    { id: 1, name: 'Vincent Mashami', team: { name: 'APR FC', logo_url: teamLogos['APR FC'] }, wins: 18, draws: 5, losses: 3 },
    { id: 2, name: 'Francis Haringingo', team: { name: 'AS Kigali', logo_url: teamLogos['AS Kigali'] }, wins: 14, draws: 9, losses: 3 },
    { id: 3, name: 'André Casa Mbungo', team: { name: 'Rayon Sports', logo_url: teamLogos['Rayon Sports'] }, wins: 15, draws: 6, losses: 5 },
    { id: 4, name: 'Jimmy Mulisa', team: { name: 'Police FC', logo_url: teamLogos['Police FC'] }, wins: 12, draws: 8, losses: 6 },
    { id: 5, name: 'Etienne Ndayiragije', team: { name: 'Musanze FC', logo_url: teamLogos['Musanze FC'] }, wins: 10, draws: 7, losses: 9 },
    { id: 6, name: 'Guy Bukasa', team: { name: 'Gasogi United', logo_url: teamLogos['Gasogi United'] }, wins: 9, draws: 6, losses: 11 }
])

// Young players data
const youngPlayers = ref([
    { id: 1, name: 'Samuel Gueulette', jersey_number: 21, team: { name: 'APR FC', logo_url: teamLogos['APR FC'] }, age: 19 },
    { id: 2, name: 'Divine Muhire', jersey_number: 17, team: { name: 'Rayon Sports', logo_url: teamLogos['Rayon Sports'] }, age: 20 },
    { id: 3, name: 'Didier Mugisha', jersey_number: 14, team: { name: 'AS Kigali', logo_url: teamLogos['AS Kigali'] }, age: 20 },
    { id: 4, name: 'Samuel Chukwudi', jersey_number: 9, team: { name: 'Gasogi United', logo_url: teamLogos['Gasogi United'] }, age: 19 },
    { id: 5, name: 'Faustin Mutesa', jersey_number: 16, team: { name: 'Police FC', logo_url: teamLogos['Police FC'] }, age: 20 },
])

// Goalkeepers data
const goalkeepers = ref([
    { id: 1, name: 'Fiacre Ntwari', jersey_number: 1, team: { name: 'APR FC', logo_url: teamLogos['APR FC'] }, cleanSheets: 12 },
    { id: 2, name: 'Emery Mvuyekure', jersey_number: 1, team: { name: 'AS Kigali', logo_url: teamLogos['AS Kigali'] }, cleanSheets: 9 },
    { id: 3, name: 'Yves Kimenyi', jersey_number: 1, team: { name: 'Rayon Sports', logo_url: teamLogos['Rayon Sports'] }, cleanSheets: 10 },
    { id: 4, name: 'Marcel Nzarora', jersey_number: 1, team: { name: 'Police FC', logo_url: teamLogos['Police FC'] }, cleanSheets: 7 },
])

// ========== STATE MANAGEMENT ==========

// Gender selection
const currentGender = ref('men');

// Selected category
const currentCategory = ref('best-player');

// Category selections
const selections = ref({
    'best-player': [1, 3, 6], // Initially selected IDs
    'goal-of-season': [],
    'coach-of-season': [1, 2, 3],
    'young-player': [1],
    'goalkeeper': [1, 3],
    'women-best-player': [],
    'women-coach': [2, 3],
    'referee': []
});

// Category configuration
const categories = {
    'best-player': {
        title: 'Best Player of the Season',
        description: 'Select 10 players from the preliminary list',
        maxSelections: 10,
        data: players,
        status: 'in-progress',
        colorClass: 'bg-blue-50'
    },
    'goal-of-season': {
        title: 'Goal of the Season',
        description: 'Select 3 goals from the preliminary list',
        maxSelections: 3,
        data: goals,
        status: 'not-started',
        colorClass: 'bg-gray-50'
    },
    'coach-of-season': {
        title: 'Coach of the Season',
        description: 'Select 3 coaches from the preliminary list',
        maxSelections: 3,
        data: coaches,
        status: 'completed',
        colorClass: 'bg-green-50'
    },
    'young-player': {
        title: 'Young Player of the Season',
        description: 'Select 5 young players from the preliminary list',
        maxSelections: 5,
        data: youngPlayers,
        status: 'in-progress',
        colorClass: 'bg-blue-50'
    },
    'goalkeeper': {
        title: 'Goalkeeper of the Season',
        description: 'Select 3 goalkeepers from the preliminary list',
        maxSelections: 3,
        data: goalkeepers,
        status: 'in-progress',
        colorClass: 'bg-blue-50'
    },
    'women-best-player': {
        title: 'Best Player of the Season - Women',
        description: 'Select 10 players from the preliminary list',
        maxSelections: 10,
        data: [], // Would normally have women's players data
        status: 'not-started',
        colorClass: 'bg-gray-50'
    },
    'women-coach': {
        title: 'Coach of the Season - Women',
        description: 'Select 3 coaches from the preliminary list',
        maxSelections: 3,
        data: [], // Would normally have women's coaches data
        status: 'completed',
        colorClass: 'bg-green-50'
    },
    'referee': {
        title: 'Referee of the Season',
        description: 'Select 3 referees from the preliminary list',
        maxSelections: 3,
        data: [], // Would normally have referees data
        status: 'not-started',
        colorClass: 'bg-gray-50'
    }
};

// Computed properties
const currentCategoryData = computed(() => {
    const key = currentCategory.value;
    return categories[key] || categories['best-player'];
});

const currentSelections = computed(() => {
    const key = currentCategory.value;
    return selections.value[key] || [];
});

const selectedItems = computed(() => {
    const category = currentCategory.value;
    const itemIds = selections.value[category] || [];
    const categoryData = currentCategoryData.value.data;

    return categoryData.filter(item => itemIds.includes(item.id));
});

// Filter categories based on gender
const availableCategories = computed(() => {
    const prefix = currentGender.value === 'women' ? 'women-' : '';
    return Object.keys(categories)
        .filter(key => {
            if (currentGender.value === 'women') {
                return key.startsWith('women-') || key === 'referee';
            } else {
                return !key.startsWith('women-');
            }
        })
        .map(key => {
            return {
                id: key,
                title: categories[key].title,
                status: categories[key].status
            };
        });
});

// Overall completion progress
const completionProgress = computed(() => {
    let completed = 0;
    let total = 0;

    for (const key in categories) {
        if (categories[key].status === 'completed') {
            completed++;
        }
        total++;
    }

    return Math.round((completed / total) * 100);
});

// Methods
const switchCategory = (categoryId) => {
    currentCategory.value = categoryId;
};

const switchGender = (gender) => {
    currentGender.value = gender;

    // Switch to the first category of the selected gender
    if (gender === 'women') {
        currentCategory.value = 'women-best-player';
    } else {
        currentCategory.value = 'best-player';
    }
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
        if (selectionArray.length >= currentCategoryData.value.maxSelections) {
            alert(`You can only select up to ${currentCategoryData.value.maxSelections} items`);
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
    const max = currentCategoryData.value.maxSelections;
    alert(`Saved ${count}/${max} selections for ${currentCategoryData.value.title}!`);

    // Update category status if appropriate
    if (count > 0) {
        if (count === max) {
            categories[currentCategory.value].status = 'completed';
        } else {
            categories[currentCategory.value].status = 'in-progress';
        }
    }
};
</script>

<template>

    <Head title="Preliminary Nominations" />

    <div class="min-h-screen bg-slate-50">
        <!-- Header -->
        <header class="bg-white shadow-sm border-b">
            <div class="max-w-7xl mx-auto px-4 py-6 sm:px-6 lg:px-8 flex items-center justify-between">
                <div class="flex items-center space-x-4">
                    <img :src="imagePath('/RPL-LOGO.png')" alt="Rwanda Premier League" class="h-12" />
                    <div>
                        <h1 class="text-2xl font-bold text-blue-600">RPL 2025 Awards</h1>
                        <p class="text-sm text-gray-500">Preliminary Nominations</p>
                    </div>
                </div>
                <div class="flex items-center space-x-4">
                    <span class="text-sm text-gray-700">Welcome, John Doe (Journalist)</span>
                    <button
                        class="px-3 py-1 text-sm font-medium bg-red-400 text-white rounded-md hover:bg-red-600">Logout</button>
                </div>
            </div>
        </header>

        <!-- Main content -->
        <main class="max-w-7xl mx-auto px-4 py-8 sm:px-6 lg:px-8">
            <!-- Progress indicator -->
            <div class="mb-8">
                <div class="flex justify-between items-center mb-2">
                    <h2 class="text-lg font-semibold">Your Nomination Progress</h2>
                    <span class="text-sm text-green-600">4 of 13 categories completed</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2.5">
                    <div class="bg-green-600 h-2.5 rounded-full" :style="`width: ${completionProgress}%`"></div>
                </div>
            </div>

            <!-- Gender selection tabs -->
            <div class="mb-6">
                <div class="border-b border-gray-200">
                    <nav class="flex -mb-px space-x-8">
                        <button @click="switchGender('men')" :class="[
                            'whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm',
                            currentGender === 'men'
                                ? 'border-blue-500 text-blue-600'
                                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                        ]">
                            Men
                        </button>
                        <button @click="switchGender('women')" :class="[
                            'whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm',
                            currentGender === 'women'
                                ? 'border-blue-500 text-blue-600'
                                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                        ]">
                            Women
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
                                    <span :class="[
                                        'px-2 py-1 text-xs rounded-full',
                                        category.status === 'completed' ? 'bg-green-100 text-green-800' :
                                            category.status === 'in-progress' ? 'bg-yellow-100 text-yellow-800' :
                                                'bg-red-100 text-red-800'
                                    ]">
                                        {{ category.status.replace('-', ' ') }}
                                    </span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Category Content Area -->
                <div class="md:col-span-3">
                    <div class="bg-white shadow rounded-lg overflow-hidden">
                        <div class="flex items-center justify-between p-4" :class="currentCategoryData.colorClass">
                            <div>
                                <h3 class="text-lg font-medium text-gray-900">{{ currentCategoryData.title }}</h3>
                                <p class="text-sm text-gray-500">{{ currentCategoryData.description }}</p>
                            </div>
                            <div class="flex items-center space-x-2">
                                <span class="text-sm font-medium text-blue-600">
                                    {{ currentSelections.length }}/{{ currentCategoryData.maxSelections }} selected
                                </span>
                                <span :class="[
                                    'px-2.5 py-0.5 rounded-full text-xs font-medium',
                                    currentCategoryData.status === 'completed' ? 'bg-green-100 text-green-800' :
                                        currentCategoryData.status === 'in-progress' ? 'bg-yellow-100 text-yellow-800' :
                                            'bg-red-100 text-red-800'
                                ]">
                                    {{ currentCategoryData.status === 'in-progress' ? 'In Progress' :
                                        currentCategoryData.status === 'completed' ? 'Completed' : 'Not Started' }}
                                </span>
                            </div>
                        </div>

                        <div class="p-4">
                            <!-- Empty state if no data -->
                            <div v-if="!currentCategoryData.data || currentCategoryData.data.length === 0"
                                class="text-center py-10">
                                <p class="text-gray-500">No data available for this category yet.</p>
                            </div>

                            <!-- Player/Coach Selection Cards -->
                            <div v-else-if="['best-player', 'coach-of-season', 'young-player', 'goalkeeper', 'women-best-player', 'women-coach'].includes(currentCategory)"
                                class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                <div v-for="item in currentCategoryData.data" :key="item.id"
                                    :class="['border rounded-md p-3', isSelected(item) ? 'bg-blue-50 border-blue-300' : 'hover:bg-gray-50']">
                                    <div class="flex items-center space-x-3">
                                        <div v-if="item.team"
                                            class="h-12 w-12 rounded-full bg-white flex items-center justify-center overflow-hidden border">
                                            <img :src="`${images_url + item.team.logo_url}`"
                                                :alt="`${item.team.name} logo`" class="h-10 w-10 object-contain" />
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
                                            <p v-if="item.age" class="text-sm text-gray-600">Age: {{ item.age }}</p>
                                            <p v-if="item.cleanSheets" class="text-sm text-gray-600">Clean Sheets: {{
                                                item.cleanSheets }}</p>
                                            <p v-if="item.wins !== undefined" class="text-sm text-gray-600">
                                                {{ item.wins }}W {{ item.draws }}D {{ item.losses }}L
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Goal Selection Cards -->
                            <div v-else-if="currentCategory === 'goal-of-season'"
                                class="grid grid-cols-1 lg:grid-cols-2 gap-4">
                                <div v-for="goal in currentCategoryData.data" :key="goal.id"
                                    :class="['border rounded-md p-3', isSelected(goal) ? 'bg-blue-50 border-blue-300' : 'hover:bg-gray-50']">
                                    <div class="flex items-start space-x-3">
                                        <div class="flex-1">
                                            <div class="flex justify-between">
                                                <h4 class="font-medium">{{ goal.scorer }}</h4>
                                                <button @click="toggleSelection(goal)"
                                                    :class="isSelected(goal) ? 'text-blue-600 hover:text-blue-800' : 'text-gray-400 hover:text-blue-600'">
                                                    <Check v-if="isSelected(goal)" class="h-5 w-5" />
                                                    <Plus v-else class="h-5 w-5" />
                                                </button>
                                            </div>
                                            <div class="mt-1 flex items-center space-x-2">
                                                <p class="text-sm text-gray-600">{{ goal.match }}</p>
                                                <span class="text-xs bg-gray-100 px-2 py-1 rounded">{{ goal.date
                                                    }}</span>
                                            </div>
                                            <p class="text-xs text-gray-500 mt-1">{{ goal.minute }}' minute</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Referee Selection would go here -->
                            <div v-else-if="currentCategory === 'referee'" class="text-center py-10">
                                <p class="text-gray-500">Referee data will be available soon.</p>
                            </div>
                        </div>

                        <div class="border-t px-4 py-3 flex justify-end">
                            <button @click="saveSelections"
                                class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 flex items-center space-x-2">
                                <Save class="h-4 w-4" />
                                <span>Save Selections ({{ currentSelections.length }}/{{
                                    currentCategoryData.maxSelections }})</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Submit all nominations -->

        </main>


        <footer class="bg-gray-800 text-white py-8">
            <div class="max-w-7xl mx-auto px-4">
                <div class="flex flex-col md:flex-row justify-between items-center">
                    <div class="mb-4 md:mb-0">
                        <div class="flex items-center space-x-4">
                            <img :src="`${images_url}/rpl-awards-white.png`" alt="Rwanda Premier League" class="h-12" />
                        </div>
                    </div>
                    <div class="text-center md:text-right">
                        <p class="text-gray-300 text-sm mb-2">© 2025 Rwanda Premier League. All rights reserved.</p>
                        <div class="flex space-x-4 justify-center md:justify-end">
                            <a href="#" class="text-gray-300 hover:text-white">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" class="lucide-facebook">
                                    <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z">
                                    </path>
                                </svg>
                            </a>
                            <a href="#" class="text-gray-300 hover:text-white">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" class="lucide-twitter">
                                    <path
                                        d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z">
                                    </path>
                                </svg>
                            </a>
                            <a href="#" class="text-gray-300 hover:text-white">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" class="lucide-instagram">
                                    <rect width="20" height="20" x="2" y="2" rx="5" ry="5"></rect>
                                    <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                                    <line x1="17.5" x2="17.51" y1="6.5" y2="6.5"></line>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </div>
</template>
