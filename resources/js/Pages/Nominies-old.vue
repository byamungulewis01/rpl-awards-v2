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
                    <button class="px-3 py-1 text-sm font-medium bg-red-400 text-white rounded-md hover:bg-red-600">Logout</button>
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
                    <div class="bg-green-600 h-2.5 rounded-full" style="width: 30%"></div>
                </div>
            </div>

            <!-- Category tabs -->
            <div class="mb-6">
                <div class="border-b border-gray-200">
                    <nav class="flex -mb-px space-x-8">
                        <button
                            class="border-blue-500 text-blue-600 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm"
                            aria-current="page">
                            Men
                        </button>
                        <button
                            class="border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm">
                            Women
                        </button>
                    </nav>
                </div>
            </div>

            <div class="space-y-6">
                <!-- Category 1: Best Player of the Season - Men -->
                <div class="bg-white shadow rounded-lg overflow-hidden">
                    <div class="flex items-center justify-between p-4 bg-blue-50">
                        <div>
                            <h3 class="text-lg font-medium text-gray-900">Best Player of the Season - Men</h3>
                            <p class="text-sm text-gray-500">Select 10 players from the preliminary list of 30</p>
                        </div>
                        <div class="flex items-center space-x-2">
                            <span class="text-sm font-medium text-blue-600">{{ selectedPlayers.length }}/10
                                selected</span>
                            <span class="px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                                In Progress
                            </span>
                        </div>
                    </div>

                    <div class="p-4">
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                            <!-- Player cards -->
                            <div v-for="player in paginatedPlayers" :key="player.id"
                                :class="['border rounded-md p-3', isSelected(player) ? 'bg-blue-50 border-blue-300' : 'hover:bg-gray-50']">
                                <div class="flex items-center space-x-3">
                                    <div
                                        class="h-12 w-12 rounded-full bg-white flex items-center justify-center overflow-hidden border">
                                        <img :src="`${images_url + player.team.logo_url}`"
                                            :alt="`${player.team.name} logo`" class="h-10 w-10 object-contain" />
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex justify-between">
                                            <h4 class="font-medium">{{ player.name }}</h4>
                                            <button @click="togglePlayerSelection(player)"
                                                :class="isSelected(player) ? 'text-blue-600 hover:text-blue-800' : 'text-gray-400 hover:text-blue-600'">
                                                <Check v-if="isSelected(player)" class="h-5 w-5" />
                                                <Plus v-else class="h-5 w-5" />
                                            </button>
                                        </div>
                                        <p class="text-sm text-gray-600">{{ player.team.name }}
                                            <span class="text-xs text-gray-500">#{{ player.jersey_number }}</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 flex justify-between items-center">
                            <div class="text-sm text-gray-500">
                                Showing {{ paginationStart + 1 }} to {{ paginationEnd }} of {{ players.length }} players
                            </div>
                            <div class="flex space-x-1">
                                <button @click="prevPage" :disabled="currentPage === 1"
                                    class="px-3 py-1 border rounded text-sm flex items-center space-x-1"
                                    :class="currentPage === 1 ? 'opacity-50 cursor-not-allowed' : 'hover:bg-gray-50'">
                                    <ChevronLeft class="h-4 w-4" />
                                    <span>Previous</span>
                                </button>

                                <button v-for="page in totalPages" :key="page" @click="goToPage(page)" :class="[
                                    'px-3 py-1 border rounded text-sm',
                                    currentPage === page ? 'bg-blue-600 text-white' : 'hover:bg-gray-50'
                                ]">
                                    {{ page }}
                                </button>

                                <button @click="nextPage" :disabled="currentPage === totalPages"
                                    class="px-3 py-1 border rounded text-sm flex items-center space-x-1"
                                    :class="currentPage === totalPages ? 'opacity-50 cursor-not-allowed' : 'hover:bg-gray-50'">
                                    <span>Next</span>
                                    <ChevronRight class="h-4 w-4" />
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="border-t px-4 py-3 flex justify-end">
                        <button @click="saveSelections"
                            class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 flex items-center space-x-2">
                            <Save class="h-4 w-4" />
                            <span>Save Selections ({{ selectedPlayers.length }}/10)</span>
                        </button>
                    </div>
                </div>

                <!-- Category 2: Goal of the Season -->
                <div class="bg-white shadow rounded-lg overflow-hidden">
                    <div class="flex items-center justify-between p-4 bg-gray-50">
                        <div>
                            <h3 class="text-lg font-medium text-gray-900">Goal of the Season</h3>
                            <p class="text-sm text-gray-500">Select 3 goals from the preliminary list of 10</p>
                        </div>
                        <div class="flex items-center space-x-2">
                            <span class="text-sm font-medium text-blue-600">{{ selectedGoals.length }}/3 selected</span>
                            <span class="px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                Not Started
                            </span>
                        </div>
                    </div>

                    <div class="p-4">
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-4">
                            <!-- Goal cards -->
                            <div v-for="goal in paginatedGoals" :key="goal.id"
                                :class="['border rounded-md p-3', isGoalSelected(goal) ? 'bg-blue-50 border-blue-300' : 'hover:bg-gray-50']">
                                <div class="flex items-start space-x-3">

                                    <div class="flex-1">
                                        <div class="flex justify-between">
                                            <h4 class="font-medium">{{ goal.scorer }}</h4>
                                            <button @click="toggleGoalSelection(goal)"
                                                :class="isGoalSelected(goal) ? 'text-blue-600 hover:text-blue-800' : 'text-gray-400 hover:text-blue-600'">
                                                <Check v-if="isGoalSelected(goal)" class="h-5 w-5" />
                                                <Plus v-else class="h-5 w-5" />
                                            </button>
                                        </div>
                                        <div class="mt-1 flex items-center space-x-2">
                                            <p class="text-sm text-gray-600">{{ goal.match }}</p>
                                            <span class="text-xs bg-gray-100 px-2 py-1 rounded">{{ goal.date }}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 flex justify-between items-center">
                            <div class="text-sm text-gray-500">
                                Showing {{ goalPaginationStart + 1 }} to {{ goalPaginationEnd }} of {{ goals.length }}
                                goals
                            </div>
                            <div class="flex space-x-1">
                                <button @click="prevGoalPage" :disabled="goalCurrentPage === 1"
                                    class="px-3 py-1 border rounded text-sm flex items-center space-x-1"
                                    :class="goalCurrentPage === 1 ? 'opacity-50 cursor-not-allowed' : 'hover:bg-gray-50'">
                                    <ChevronLeft class="h-4 w-4" />
                                    <span>Previous</span>
                                </button>

                                <button v-for="page in goalTotalPages" :key="page" @click="goToGoalPage(page)" :class="[
                                    'px-3 py-1 border rounded text-sm',
                                    goalCurrentPage === page ? 'bg-blue-600 text-white' : 'hover:bg-gray-50'
                                ]">
                                    {{ page }}
                                </button>

                                <button @click="nextGoalPage" :disabled="goalCurrentPage === goalTotalPages"
                                    class="px-3 py-1 border rounded text-sm flex items-center space-x-1"
                                    :class="goalCurrentPage === goalTotalPages ? 'opacity-50 cursor-not-allowed' : 'hover:bg-gray-50'">
                                    <span>Next</span>
                                    <ChevronRight class="h-4 w-4" />
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="border-t px-4 py-3 flex justify-end">
                        <button @click="saveGoalSelections"
                            class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 flex items-center space-x-2">
                            <Save class="h-4 w-4" />
                            <span>Save Selections ({{ selectedGoals.length }}/3)</span>
                        </button>
                    </div>
                </div>

                <!-- Category 3: Coach of the Season -->
                <div class="bg-white shadow rounded-lg overflow-hidden">
                    <div class="flex items-center justify-between p-4 bg-green-50">
                        <div>
                            <h3 class="text-lg font-medium text-gray-900">Coach of the Season</h3>
                            <p class="text-sm text-gray-500">Select 3 coaches from the preliminary list of 8</p>
                        </div>
                        <div class="flex items-center space-x-2">
                            <span class="text-sm font-medium text-blue-600">{{ selectedCoaches.length }}/3
                                selected</span>
                            <span class="px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                Completed
                            </span>
                        </div>
                    </div>

                    <div class="p-4">
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                            <!-- Coach cards -->
                            <div v-for="coach in coaches" :key="coach.id"
                                :class="['border rounded-md p-3', isCoachSelected(coach) ? 'bg-blue-50 border-blue-300' : 'hover:bg-gray-50']">
                                <div class="flex items-center space-x-3">
                                    <div
                                        class="h-12 w-12 rounded-full bg-white flex items-center justify-center overflow-hidden border">
                                        <img :src="`${images_url + coach.team.logo_url}`"
                                            :alt="`${coach.team.name} logo`" class="h-10 w-10 object-contain" />
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex justify-between">
                                            <h4 class="font-medium">{{ coach.name }}</h4>
                                            <button @click="toggleCoachSelection(coach)"
                                                :class="isCoachSelected(coach) ? 'text-blue-600 hover:text-blue-800' : 'text-gray-400 hover:text-blue-600'">
                                                <Check v-if="isCoachSelected(coach)" class="h-5 w-5" />
                                                <Plus v-else class="h-5 w-5" />
                                            </button>
                                        </div>
                                        <p class="text-sm text-gray-600">{{ coach.team.name }}</p>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="border-t px-4 py-3 flex justify-end">
                        <button @click="saveCoachSelections"
                            class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 flex items-center space-x-2">
                            <Save class="h-4 w-4" />
                            <span>Save Selections ({{ selectedCoaches.length }}/3)</span>
                        </button>
                    </div>
                </div>


            </div>

            <!-- Submit all nominations -->
            <div class="mt-8 bg-white shadow rounded-lg p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <h3 class="text-lg font-medium text-gray-900">Your Nomination Progress</h3>
                        <p class="text-sm text-gray-500">Complete all category nominations before final submission</p>
                    </div>
                </div>

                <div class="mt-4">
                    <div class="w-full bg-gray-200 rounded-full h-2.5">
                        <div class="bg-green-600 h-2.5 rounded-full" style="width: 30%"></div>
                    </div>
                    <div class="mt-2 grid grid-cols-2 gap-4">
                        <div>
                            <h4 class="text-sm font-medium text-gray-700 mb-2">Men's Categories</h4>
                            <ul class="space-y-1 text-sm">
                                <li class="flex items-center">
                                    <Check class="h-4 w-4 text-green-500 mr-1" />
                                    Best Player of the Season - Men (3/10)
                                </li>

                                <li class="flex items-center">
                                    <Plus class="h-4 w-4 text-gray-400 mr-1" />
                                    Goal of the Season (0/3)
                                </li>
                                <li class="flex items-center">
                                    <Plus class="h-4 w-4 text-gray-400 mr-1" />
                                    Coach of the Season (3/3)
                                </li>
                                <li class="flex items-center">
                                    <Check class="h-4 w-4 text-green-500 mr-1" />
                                    Best 11-Team of the Season
                                </li>
                                <li class="flex items-center">
                                    <Plus class="h-4 w-4 text-gray-400 mr-1" />
                                    Young Player of the Season (0/5)
                                </li>
                                <li class="flex items-center">
                                    <Plus class="h-4 w-4 text-gray-400 mr-1" />
                                    Goalkeeper of the Season (0/3)
                                </li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="text-sm font-medium text-gray-700 mb-2">Women's Categories</h4>
                            <ul class="space-y-1 text-sm">
                                <li class="flex items-center">
                                    <Plus class="h-4 w-4 text-gray-400 mr-1" />
                                    Best Player of the Season - Women (0/3)
                                </li>
                                <li class="flex items-center">
                                    <Check class="h-4 w-4 text-green-500 mr-1" />
                                    Coach of the Season (3/3)
                                </li>
                                <li class="flex items-center">
                                    <Plus class="h-4 w-4 text-gray-400 mr-1" />
                                    Referee of the Season
                                </li>



                            </ul>
                        </div>
                    </div>


                </div>
            </div>
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

<script setup>
import { Head, usePage } from '@inertiajs/vue3';
import { computed, ref } from 'vue';
import { Check, Plus, ChevronLeft, ChevronRight, Save } from 'lucide-vue-next'
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

// ========== BEST PLAYER CATEGORY ==========

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

// Selected player IDs
const selectedPlayerIds = ref([1, 3, 6]) // Initially selected players

// Pagination
const currentPage = ref(1)
const perPage = ref(6)

// Computed properties
const selectedPlayers = computed(() => {
    return players.value.filter(player => selectedPlayerIds.value.includes(player.id))
})

const paginationStart = computed(() => {
    return (currentPage.value - 1) * perPage.value
})

const paginationEnd = computed(() => {
    return Math.min(paginationStart.value + perPage.value, players.value.length)
})

const paginatedPlayers = computed(() => {
    return players.value.slice(paginationStart.value, paginationEnd.value)
})

const totalPages = computed(() => {
    return Math.ceil(players.value.length / perPage.value)
})

// Methods
const isSelected = (player) => {
    return selectedPlayerIds.value.includes(player.id)
}

const togglePlayerSelection = (player) => {
    const index = selectedPlayerIds.value.indexOf(player.id)

    if (index === -1) {
        // Check if we already have 10 players selected
        if (selectedPlayerIds.value.length >= 10) {
            alert('You can only select up to 10 players')
            return
        }
        selectedPlayerIds.value.push(player.id)
    } else {
        selectedPlayerIds.value.splice(index, 1)
    }
}

const goToPage = (page) => {
    currentPage.value = page
}

const prevPage = () => {
    if (currentPage.value > 1) {
        currentPage.value--
    }
}

const nextPage = () => {
    if (currentPage.value < totalPages.value) {
        currentPage.value++
    }
}

const saveSelections = () => {
    alert(`Saved ${selectedPlayerIds.value.length} player selections!`)
}

// ========== GOAL OF THE SEASON CATEGORY ==========

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

// Goal selection
const selectedGoalIds = ref([])
const goalCurrentPage = ref(1)
const goalPerPage = ref(4)

// Computed properties for goals
const selectedGoals = computed(() => {
    return goals.value.filter(goal => selectedGoalIds.value.includes(goal.id))
})

const goalPaginationStart = computed(() => {
    return (goalCurrentPage.value - 1) * goalPerPage.value
})

const goalPaginationEnd = computed(() => {
    return Math.min(goalPaginationStart.value + goalPerPage.value, goals.value.length)
})

const paginatedGoals = computed(() => {
    return goals.value.slice(goalPaginationStart.value, goalPaginationEnd.value)
})

const goalTotalPages = computed(() => {
    return Math.ceil(goals.value.length / goalPerPage.value)
})

// Methods for goals
const isGoalSelected = (goal) => {
    return selectedGoalIds.value.includes(goal.id)
}

const toggleGoalSelection = (goal) => {
    const index = selectedGoalIds.value.indexOf(goal.id)

    if (index === -1) {
        // Check if we already have 3 goals selected
        if (selectedGoalIds.value.length >= 3) {
            alert('You can only select up to 3 goals')
            return
        }
        selectedGoalIds.value.push(goal.id)
    } else {
        selectedGoalIds.value.splice(index, 1)
    }
}

const goToGoalPage = (page) => {
    goalCurrentPage.value = page
}

const prevGoalPage = () => {
    if (goalCurrentPage.value > 1) {
        goalCurrentPage.value--
    }
}

const nextGoalPage = () => {
    if (goalCurrentPage.value < goalTotalPages.value) {
        goalCurrentPage.value++
    }
}

const saveGoalSelections = () => {
    alert(`Saved ${selectedGoalIds.value.length} goal selections!`)
}

// ========== COACH OF THE SEASON CATEGORY ==========

// Dummy coaches data
const coaches = ref([
    { id: 1, name: 'Vincent Mashami', team: { name: 'APR FC', logo_url: teamLogos['APR FC'] }, wins: 18, draws: 5, losses: 3 },
    { id: 2, name: 'Francis Haringingo', team: { name: 'AS Kigali', logo_url: teamLogos['AS Kigali'] }, wins: 14, draws: 9, losses: 3 },
    { id: 3, name: 'André Casa Mbungo', team: { name: 'Rayon Sports', logo_url: teamLogos['Rayon Sports'] }, wins: 15, draws: 6, losses: 5 },
    { id: 4, name: 'Jimmy Mulisa', team: { name: 'Police FC', logo_url: teamLogos['Police FC'] }, wins: 12, draws: 8, losses: 6 },
    { id: 5, name: 'Etienne Ndayiragije', team: { name: 'Musanze FC', logo_url: teamLogos['Musanze FC'] }, wins: 10, draws: 7, losses: 9 },
    { id: 6, name: 'Guy Bukasa', team: { name: 'Gasogi United', logo_url: teamLogos['Gasogi United'] }, wins: 9, draws: 6, losses: 11 }
])

// Coach selection
const selectedCoachIds = ref([1, 2, 3]) // Initially selected coaches

// Computed properties for coaches
const selectedCoaches = computed(() => {
    return coaches.value.filter(coach => selectedCoachIds.value.includes(coach.id))
})

// Methods for coaches
const isCoachSelected = (coach) => {
    return selectedCoachIds.value.includes(coach.id)
}

const toggleCoachSelection = (coach) => {
    const index = selectedCoachIds.value.indexOf(coach.id)

    if (index === -1) {
        // Check if we already have 3 coaches selected
        if (selectedCoachIds.value.length >= 3) {
            alert('You can only select up to 3 coaches')
            return
        }
        selectedCoachIds.value.push(coach.id)
    } else {
        selectedCoachIds.value.splice(index, 1)
    }
}

const saveCoachSelections = () => {
    alert(`Saved ${selectedCoachIds.value.length} coach selections!`)
}

// Additional categories could be added here with similar structure...
</script>
