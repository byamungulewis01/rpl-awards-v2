<script setup>
import { ref, computed, watch } from 'vue'
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from '@/Components/ui/dialog'
import { Button } from '@/Components/ui/button'
import { ScrollArea } from '@/Components/ui/scroll-area'
import { Badge } from '@/Components/ui/badge'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/Components/ui/tabs'
import { Head, usePage } from '@inertiajs/vue3'
import { InfoIcon } from 'lucide-vue-next'
import PublicLayout from '@/Layouts/PublicLayout.vue'

// State management
const activeLeague = ref('men')
const selectedCategory = ref(null)
const selectedNominee = ref(null)
const voteCount = ref(1)
const showSuccessModal = ref(false)
const searchQuery = ref('')

const page = usePage();
const images_url = computed(() => page.props.images_url);

// Dummy data for categories (enhanced)
const mensCategories = ref([
    // Men's categories
    {
        id: 1,
        league: 'men',
        name: 'Best Player of the Season',
        nominees: 10,
        description: 'The most outstanding male player throughout the 2025 Rwanda Premier League season.',
        type: 'player', // Type of nominee (player, coach, team, referee, etc.)
        icon: 'trophy'
    },
    {
        id: 3,
        league: 'men',
        name: 'Goal of the Season',
        nominees: 5,
        description: 'The most spectacular goal scored in the men\'s league during the 2025 season.',
        type: 'goal', // Special type for goals
        icon: 'target'
    },
    {
        id: 4,
        league: 'men',
        name: 'Coach of the Season',
        nominees: 6,
        description: 'The best performing coach in the men\'s league during the 2025 season.',
        type: 'coach',
        icon: 'users'
    },
    {
        id: 5,
        league: 'men',
        name: 'Best 11-Team of the Season',
        nominees: 33,
        description: 'The best eleven players forming the ideal team for the 2025 season.',
        type: 'player',
        icon: 'users'
    },
    {
        id: 6,
        league: 'men',
        name: 'Young Player of the Season',
        nominees: 8,
        description: 'The most promising young talent (U-23) in the men\'s league.',
        type: 'player',
        icon: 'sparkles'
    },
    {
        id: 7,
        league: 'men',
        name: 'Goalkeeper of the Season',
        nominees: 6,
        description: 'The best performing goalkeeper in the men\'s league for the 2025 season.',
        type: 'player',
        icon: 'hand'
    },
    {
        id: 9,
        league: 'men',
        name: 'Referee of the Season',
        nominees: 5,
        description: 'The most consistent and fair referee in the men\'s league for the 2025 season.',
        type: 'referee',
        icon: 'whistle'
    },
])
const womensCategories = ref([
    {
        id: 10,
        league: 'women',
        name: 'Best Player of the Season',
        nominees: 8,
        description: 'The most outstanding female player throughout the 2025 Rwanda Premier League season.',
        type: 'player',
        icon: 'trophy'
    },
    {
        id: 12,
        league: 'women',
        name: 'Coach of the Season',
        nominees: 4,
        description: 'The best performing coach in the women\'s league during the 2025 season.',
        type: 'coach',
        icon: 'users'
    },
    {
        id: 13,
        league: 'women',
        name: 'Referee of the Season',
        nominees: 3,
        description: 'The most consistent and fair referee in the women\'s league for the 2025 season.',
        type: 'referee',
        icon: 'whistle'
    }
])

// Enhanced team data with logos
const teams = ref([
    {
        id: 1,
        name: 'APR FC',
        logo: 'apr-fc-logo.png',
    },
    {
        id: 2,
        name: 'Rayon Sports',
        logo: 'rayon-sports-logo.jpeg',
    },
    {
        id: 3,
        name: 'Police FC',
        logo: 'police-fc-logo.png',
    },
    {
        id: 4,
        name: 'AS Kigali',
        logo: 'as-kigali-logo.png',
    },
    {
        id: 5,
        name: 'Gasogi United',
        logo: 'gasogi-united-logo.png',
    },
    {
        id: 6,
        name: 'Marines FC',
        logo: 'marines-fc-logo.png',
    },
    {
        id: 7,
        name: 'Mukura Victory',
        logo: 'mukura-victory-logo.png',
    }
])

// Enhanced nominees data
const allNominees = ref([
    // Players
    {
        id: 1,
        name: 'Jean-Claude Kamali',
        team_id: 1, // APR FC
        votes: 1245,
        type: 'player',
        jersey_number: 10,
        categories: [1, 5], // Category IDs this nominee belongs to
        league: 'men'
    },
    {
        id: 2,
        name: 'Emmanuel Hakizimana',
        team_id: 2, // Rayon Sports
        votes: 982,
        type: 'player',
        jersey_number: 7,
        categories: [1, 5, 6],
        league: 'men'
    },
    {
        id: 3,
        name: 'Patrick Sibomana',
        team_id: 3, // Police FC
        votes: 876,
        type: 'player',
        jersey_number: 9,
        categories: [1, 5],
        league: 'men'
    },
    {
        id: 4,
        name: 'Eric Nsabimana',
        team_id: 4, // AS Kigali
        votes: 743,
        type: 'player',
        jersey_number: 6,
        categories: [1, 5, 6],
        league: 'men'
    },
    // Coaches
    {
        id: 20,
        name: 'Vincent Mashami',
        team_id: 1, // APR FC
        votes: 512,
        type: 'coach',
        categories: [4],
        league: 'men'
    },
    {
        id: 21,
        name: 'Andre Casa Mbungo',
        team_id: 2, // Rayon Sports
        votes: 487,
        type: 'coach',
        categories: [4],
        league: 'men'
    },
    // Referees
    {
        id: 30,
        name: 'Louis Hakizimana',
        votes: 320,
        type: 'referee',
        categories: [9],
        league: 'men'
    },
    {
        id: 31,
        name: 'Salima Mukansanga',
        votes: 420,
        type: 'referee',
        categories: [9],
        league: 'men'
    },
    // Goals
    {
        id: 40,
        name: 'Bicycle Kick vs. Police FC',
        player_name: 'Jacques Tuyisenge',
        team_id: 2, // Rayon Sports
        votes: 890,
        type: 'goal',
        match: 'Rayon Sports vs Police FC',
        date: '15 Mar 2025',
        categories: [3],
        league: 'men'
    },
    {
        id: 41,
        name: 'Long Range Strike vs. APR',
        player_name: 'Eric Nsabimana',
        team_id: 4, // AS Kigali
        votes: 756,
        type: 'goal',
        match: 'AS Kigali vs APR FC',
        date: '2 Apr 2025',
        categories: [3],
        league: 'men'
    }
])

// Get nominees for the selected category
const categoryNominees = computed(() => {
    if (!selectedCategory.value) return []

    return allNominees.value.filter(nominee =>
        nominee.categories.includes(selectedCategory.value.id) &&
        nominee.league === activeLeague.value &&
        (searchQuery.value === '' || nominee.name.toLowerCase().includes(searchQuery.value.toLowerCase()))
    )
})

// Get team data for a nominee
const getTeam = (teamId) => {
    return teams.value.find(team => team.id === teamId) || null
}

// Functions
const selectCategory = (category) => {
    selectedCategory.value = category
    selectedNominee.value = null
    voteCount.value = 1
    searchQuery.value = ''
}

const selectNominee = (nominee) => {
    selectedNominee.value = nominee
}

const closeModal = () => {
    selectedCategory.value = null
    selectedNominee.value = null
}

const incrementVotes = () => {
    voteCount.value++
}

const decrementVotes = () => {
    if (voteCount.value > 1) {
        voteCount.value--
    }
}

const submitVote = () => {
    // In a real application, this would send the vote to the server
    // For now, we'll just show the success modal
    showSuccessModal.value = true
    selectedCategory.value = null
    selectedNominee.value = null
}

// Icon mapping
const getCategoryIcon = (iconName) => {
    const icons = {
        'trophy': '<path d="M8.21 13.89 7 23l5-3 5 3-1.21-9.12"></path><path d="M15 7h4a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-4"></path><path d="M9 7H5a2 2 0 0 0-2 2 2 2 0 0 0 2 2h4"></path><path d="M12 2v8"></path><path d="M12 17v4"></path>',
        'target': '<circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="6"></circle><circle cx="12" cy="12" r="2"></circle>',
        'users': '<path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M22 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path>',
        'sparkles': '<path d="m12 3-1.912 5.813a2 2 0 0 1-1.275 1.275L3 12l5.813 1.912a2 2 0 0 1 1.275 1.275L12 21l1.912-5.813a2 2 0 0 1 1.275-1.275L21 12l-5.813-1.912a2 2 0 0 1-1.275-1.275L12 3Z"></path><path d="M5 3v4"></path><path d="M19 17v4"></path><path d="M3 5h4"></path><path d="M17 19h4"></path>',
        'hand': '<path d="M18 11V6a2 2 0 0 0-2-2v0a2 2 0 0 0-2 2v0"></path><path d="M14 10V4a2 2 0 0 0-2-2v0a2 2 0 0 0-2 2v2"></path><path d="M10 10.5V6a2 2 0 0 0-2-2v0a2 2 0 0 0-2 2v8"></path><path d="M18 8a2 2 0 1 1 4 0v6a8 8 0 0 1-8 8h-2c-2.8 0-4.5-.86-5.99-2.34l-3.6-3.6a2 2 0 0 1 2.83-2.82L7 15"></path>',
        'whistle': '<path d="M20 10.5c0-1.1-.77-2-1.714-2H8a1 1 0 0 1-1-1V6a3 3 0 0 1 3-3h5c.565 0 1.238.278 1.6.854"></path><path d="m11.3 8.9 9.351 5.073c.155.089.3.158.349.299a1 1 0 0 1 0 .656c-.05.14-.194.21-.349.298L11.3 20.6a1 1 0 0 1-1.374-.372L5.5 11.443c-.376-.686-.175-1.343.348-1.815.523-.472 1.271-.508 1.947-.13L9 10"></path><path d="M4 8h3"></path><path d="M5 5.5L7.5 8"></path><circle cx="9" cy="15" r="1"></circle>'
    }
    return icons[iconName] || icons['trophy']
}

</script>
<template>

    <Head title="Voting" />
    <PublicLayout title="Vote for the best in Rwandan football">

        <!-- Hero section with animation -->
        <div class="relative text-center mb-10 py-10 overflow-hidden">
            <div class="relative z-10">
                <h1 class="text-3xl md:text-6xl font-bold text-blue-500 mb-4 animate-fade-in">
                    RPL 2025 AWARDS
                </h1>
                <p class="text-lg md:text-xl text-gray-700 max-w-2xl mx-auto">
                    Cast your vote for the best performers in the Rwanda Premier League
                    2025 season and help recognize exceptional talent.
                </p>
                <div class="mt-6 p-4 bg-yellow-50 rounded-lg inline-block border border-yellow-200 shadow-sm">
                    <p class="flex items-center text-amber-800">
                        <span class="mr-2">
                            <InfoIcon class="w-5 h-5" />
                        </span>
                        Each vote costs 200 RWF. You can vote multiple times to increase your favorite's chances!
                    </p>
                </div>
            </div>
            <!-- Decorative elements -->
            <div class="absolute top-0 left-0 w-full h-full opacity-5 pointer-events-none">
                <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" viewBox="0 0 24 24" fill="none"
                    stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                    class="text-blue-900 absolute top-6 left-10 transform -rotate-12">
                    <path d="M8.21 13.89 7 23l5-3 5 3-1.21-9.12"></path>
                    <path d="M15 7h4a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-4"></path>
                    <path d="M9 7H5a2 2 0 0 0-2 2 2 2 0 0 0 2 2h4"></path>
                    <path d="M12 2v8"></path>
                    <path d="M12 17v4"></path>
                </svg>
                <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" viewBox="0 0 24 24" fill="none"
                    stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                    class="text-blue-900 absolute bottom-10 right-16 transform rotate-15">
                    <polygon
                        points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
                    </polygon>
                </svg>
            </div>
        </div>

        <!-- League selection tabs -->
        <Tabs :default-value="activeLeague" class="mb-6" @update:value="tab => activeLeague = tab">
            <div class="flex justify-center mb-4">
                <TabsList class="grid w-full max-w-md grid-cols-2">
                    <TabsTrigger value="men" class="text-base font-medium">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            class="mr-2">
                            <circle cx="12" cy="5" r="3"></circle>
                            <path d="M12 8v9"></path>
                            <path d="m8 16 4 4 4-4"></path>
                        </svg>
                        Men's League
                    </TabsTrigger>
                    <TabsTrigger value="women" class="text-base font-medium">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            class="mr-2">
                            <circle cx="12" cy="5" r="3"></circle>
                            <line x1="12" x2="12" y1="8" y2="19"></line>
                            <circle cx="12" cy="16" r="3"></circle>
                        </svg>
                        Women's League
                    </TabsTrigger>
                </TabsList>
            </div>

            <!-- Categories content for each tab -->
            <TabsContent value="men">
                <div class="mb-12">
                    <h2 class="text-2xl font-semibold text-gray-800 mb-6 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            class="mr-2 text-blue-600">
                            <path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"></path>
                            <line x1="4" x2="4" y1="22" y2="15"></line>
                        </svg>
                        Men's League Categories
                    </h2>

                    <!-- Categories grid -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                        <div v-for="category in mensCategories" :key="category.id"
                            class="bg-white rounded-xl shadow-md hover:shadow-lg transition-all overflow-hidden border border-gray-100 cursor-pointer transform hover:-translate-y-1 hover:border-blue-200"
                            @click="selectCategory(category)">
                            <div class="p-6">
                                <div class="flex items-start justify-between mb-4">
                                    <div class="flex">
                                        <div
                                            class="mr-3 w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center text-blue-600">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round"
                                                v-html="getCategoryIcon(category.icon)">
                                            </svg>
                                        </div>
                                        <div>
                                            <h3 class="text-lg font-semibold text-gray-800">{{ category.name }}</h3>
                                            <Badge variant="secondary" class="mt-1">
                                                {{ category.nominees }} nominees
                                            </Badge>
                                        </div>
                                    </div>
                                </div>
                                <p class="text-gray-600 text-sm mb-4">{{ category.description }}</p>
                                <div class="flex justify-end">
                                    <button
                                        class="text-blue-600 hover:text-blue-800 font-medium text-sm flex items-center bg-blue-50 px-3 py-1 rounded-full">
                                        View Nominees
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round" class="ml-1">
                                            <path d="M5 12h14"></path>
                                            <path d="m12 5 7 7-7 7"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </TabsContent>

            <TabsContent value="women">
                <div class="mb-12">
                    <h2 class="text-2xl font-semibold text-gray-800 mb-6 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            class="mr-2 text-pink-600">
                            <path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"></path>
                            <line x1="4" x2="4" y1="22" y2="15"></line>
                        </svg>
                        Women's League Categories
                    </h2>

                    <!-- Categories grid -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                        <div v-for="category in womensCategories" :key="category.id"
                            class="bg-white rounded-xl shadow-md hover:shadow-lg transition-all overflow-hidden border border-gray-100 cursor-pointer transform hover:-translate-y-1 hover:border-pink-200"
                            @click="selectCategory(category)">
                            <div class="p-6">
                                <div class="flex items-start justify-between mb-4">
                                    <div class="flex">
                                        <div
                                            class="mr-3 w-10 h-10 bg-pink-100 rounded-full flex items-center justify-center text-pink-600">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round"
                                                v-html="getCategoryIcon(category.icon)">
                                            </svg>
                                        </div>
                                        <div>
                                            <h3 class="text-lg font-semibold text-gray-800">{{ category.name }}</h3>
                                            <Badge variant="secondary" class="mt-1">
                                                {{ category.nominees }} nominees
                                            </Badge>
                                        </div>
                                    </div>
                                </div>
                                <p class="text-gray-600 text-sm mb-4">{{ category.description }}</p>
                                <div class="flex justify-end">
                                    <button
                                        class="text-pink-600 hover:text-pink-800 font-medium text-sm flex items-center bg-pink-50 px-3 py-1 rounded-full">
                                        View Nominees
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round" class="ml-1">
                                            <path d="M5 12h14"></path>
                                            <path d="m12 5 7 7-7 7"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </TabsContent>
        </Tabs>

        <!-- Enhanced Nominee selection modal with scrollable content -->
        <Dialog :open="!!selectedCategory" @update:open="closeModal">
            <DialogContent class="sm:max-w-4xl max-h-[90vh] overflow-hidden flex flex-col">
                <DialogHeader class="border-b pb-4">
                    <DialogTitle class="text-xl font-bold flex items-center justify-center text-blue-700">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            v-if="selectedCategory" v-html="getCategoryIcon(selectedCategory?.icon)"
                            class="mr-2 text-blue-600">
                        </svg>
                        {{ selectedCategory?.name }} Nominees
                    </DialogTitle>
                    <DialogDescription class="text-center">
                        Select your favorite nominee and cast your vote
                    </DialogDescription>
                </DialogHeader>


                <!-- Scrollable nominees area -->
                <ScrollArea class="flex-grow">
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 p-4">
                        <!-- Dynamic nominee cards based on category type -->

                        <!-- Player type nominees -->
                        <template v-if="selectedCategory?.type === 'player'">
                            <div v-for="nominee in categoryNominees" :key="nominee.id"
                                class="border rounded-lg overflow-hidden hover:border-blue-400 transition-colors cursor-pointer bg-white"
                                :class="{ 'border-blue-500 ring-2 ring-blue-200': selectedNominee?.id === nominee.id }"
                                @click="selectNominee(nominee)">

                                <div class="p-3 relative">
                                    <!-- Team color bar at top -->
                                    <div v-if="nominee.team_id" class="absolute top-0 left-0 right-0 h-1 bg-blue-400">
                                    </div>

                                    <div class="flex items-center mb-3 mt-2">
                                        <!-- Jersey Number on the left -->
                                        <div v-if="nominee.jersey_number" class="mr-3">
                                            <span
                                                class="inline-flex items-center justify-center w-8 h-8 bg-blue-400 text-white rounded-full font-bold">
                                                {{ nominee.jersey_number }}
                                            </span>
                                        </div>

                                        <div class="flex-grow">
                                            <h4 class="font-semibold text-gray-800">{{ nominee.name }}</h4>

                                            <div class="flex items-center mt-1">
                                                <!-- Team logo -->
                                                <div v-if="nominee.team_id" class="w-5 h-5 mr-1">
                                                    <img v-if="getTeam(nominee.team_id)?.logo"
                                                        :src="`${images_url}/${getTeam(nominee.team_id).logo}`"
                                                        :alt="getTeam(nominee.team_id).name"
                                                        class="w-full h-full object-contain" />
                                                </div>

                                                <!-- Team name -->
                                                <p v-if="nominee.team_id" class="text-sm text-gray-600">
                                                    {{ getTeam(nominee.team_id)?.name }}
                                                </p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="flex justify-between items-center pt-2 border-t">
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round" class="text-amber-500">
                                                <polygon
                                                    points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
                                                </polygon>
                                            </svg>
                                            <span class="ml-1 text-sm">{{ nominee.votes }} votes</span>
                                        </div>

                                        <button v-if="selectedNominee?.id === nominee.id"
                                            class="text-xs px-2 py-1 bg-blue-600 text-white rounded-full">
                                            Selected
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </template>
                        <!-- Coach type nominees -->
                        <template v-else-if="selectedCategory?.type === 'coach'">
                            <div v-for="nominee in categoryNominees" :key="nominee.id"
                                class="border rounded-lg overflow-hidden hover:border-blue-400 transition-colors cursor-pointer bg-white"
                                :class="{ 'border-blue-500 ring-2 ring-blue-200': selectedNominee?.id === nominee.id }"
                                @click="selectNominee(nominee)">

                                <div class="p-3 relative">
                                    <!-- Team color bar at top -->
                                    <div v-if="nominee.team_id" class="absolute top-0 left-0 right-0 h-1 bg-gray-400">
                                    </div>

                                    <div class="flex items-center mb-3 mt-2">
                                        <div class="flex-grow">
                                            <h4 class="font-semibold text-gray-800">{{ nominee.name }}</h4>

                                            <div class="flex items-center">
                                                <!-- Team logo -->
                                                <div v-if="nominee.team_id" class="w-5 h-5 mr-1">
                                                    <img v-if="getTeam(nominee.team_id)?.logo"
                                                        :src="`${images_url}/${getTeam(nominee.team_id).logo}`"
                                                        :alt="getTeam(nominee.team_id).name"
                                                        class="w-full h-full object-contain" />
                                                </div>

                                                <!-- Team name -->
                                                <p v-if="nominee.team_id" class="text-sm text-gray-600">
                                                    {{ getTeam(nominee.team_id)?.name }} Coach
                                                </p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="flex justify-between items-center pt-2 border-t">
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round" class="text-amber-500">
                                                <polygon
                                                    points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
                                                </polygon>
                                            </svg>
                                            <span class="ml-1 text-sm">{{ nominee.votes }} votes</span>
                                        </div>

                                        <button v-if="selectedNominee?.id === nominee.id"
                                            class="text-xs px-2 py-1 bg-blue-600 text-white rounded-full">
                                            Selected
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </template>

                        <!-- Referee type nominees -->
                        <template v-else-if="selectedCategory?.type === 'referee'">
                            <div v-for="nominee in categoryNominees" :key="nominee.id"
                                class="border rounded-lg overflow-hidden hover:border-blue-400 transition-colors cursor-pointer bg-white"
                                :class="{ 'border-blue-500 ring-2 ring-blue-200': selectedNominee?.id === nominee.id }"
                                @click="selectNominee(nominee)">

                                <div class="p-3">
                                    <div class="flex items-center mb-3">

                                        <div class="flex-grow">
                                            <h4 class="font-semibold text-gray-800">{{ nominee.name }}</h4>
                                            <span
                                                class="text-xs bg-yellow-100 text-yellow-800 px-2 py-0.5 rounded mt-1 inline-block">
                                                Referee
                                            </span>
                                        </div>
                                    </div>

                                    <div class="flex justify-between items-center pt-2 border-t">
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round" class="text-amber-500">
                                                <polygon
                                                    points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
                                                </polygon>
                                            </svg>
                                            <span class="ml-1 text-sm">{{ nominee.votes }} votes</span>
                                        </div>

                                        <button v-if="selectedNominee?.id === nominee.id"
                                            class="text-xs px-2 py-1 bg-blue-600 text-white rounded-full">
                                            Selected
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </template>

                        <!-- Goal type nominees -->
                        <template v-else-if="selectedCategory?.type === 'goal'">
                            <div v-for="nominee in categoryNominees" :key="nominee.id"
                                class="border rounded-lg overflow-hidden hover:border-blue-400 transition-colors cursor-pointer bg-white"
                                :class="{ 'border-blue-500 ring-2 ring-blue-200': selectedNominee?.id === nominee.id }"
                                @click="selectNominee(nominee)">

                                <div class="p-3">
                                    <h4 class="font-semibold text-gray-800">{{ nominee.name }}</h4>

                                    <div class="flex items-center mt-1">
                                        <div class="flex items-center">
                                            <!-- Team logo -->
                                            <div v-if="nominee.team_id" class="w-5 h-5 mr-1">
                                                <img v-if="getTeam(nominee.team_id)?.logo"
                                                    :src="`${images_url}/${getTeam(nominee.team_id).logo}`"
                                                    :alt="getTeam(nominee.team_id).name"
                                                    class="w-full h-full object-contain" />
                                            </div>

                                            <p class="text-sm text-gray-600">
                                                {{ nominee.player_name }}
                                            </p>
                                        </div>
                                    </div>

                                    <div class="text-xs text-gray-500 mt-1">
                                        {{ nominee.match }} • {{ nominee.date }}
                                    </div>

                                    <div class="flex justify-between items-center pt-2 mt-1 border-t">
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round" class="text-amber-500">
                                                <polygon
                                                    points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
                                                </polygon>
                                            </svg>
                                            <span class="ml-1 text-sm">{{ nominee.votes }} votes</span>
                                        </div>

                                        <button v-if="selectedNominee?.id === nominee.id"
                                            class="text-xs px-2 py-1 bg-blue-600 text-white rounded-full">
                                            Selected
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </template>

                        <!-- Default nominee card for other types -->
                        <template v-else>
                            <div v-for="nominee in categoryNominees" :key="nominee.id"
                                class="border rounded-lg overflow-hidden hover:border-blue-400 transition-colors cursor-pointer bg-white"
                                :class="{ 'border-blue-500 ring-2 ring-blue-200': selectedNominee?.id === nominee.id }"
                                @click="selectNominee(nominee)">

                                <div class="p-3">
                                    <h4 class="font-semibold text-gray-800">{{ nominee.name }}</h4>

                                    <div class="flex justify-between items-center pt-2 mt-1 border-t">
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round" class="text-amber-500">
                                                <polygon
                                                    points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
                                                </polygon>
                                            </svg>
                                            <span class="ml-1 text-sm">{{ nominee.votes }} votes</span>
                                        </div>

                                        <button v-if="selectedNominee?.id === nominee.id"
                                            class="text-xs px-2 py-1 bg-blue-600 text-white rounded-full">
                                            Selected
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </template>
                    </div>
                </ScrollArea>

                <!-- Voting controls - sticky at bottom -->
                <div class="border-t bg-gray-50 p-4 sticky bottom-0">
                    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                        <div class="bg-white p-3 rounded-lg border shadow-sm flex-grow">
                            <div class="flex items-center justify-between flex-wrap gap-2">
                                <div>
                                    <p class="font-medium text-gray-700">Voting Fee:</p>
                                    <p class="text-sm text-gray-600">One vote = 200 RWF</p>
                                </div>
                                <div>
                                    <div class="flex items-center space-x-3">
                                        <button
                                            class="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center hover:bg-gray-300 transition-colors"
                                            @click="decrementVotes">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M5 12h14"></path>
                                            </svg>
                                        </button>
                                        <span class="text-lg font-medium w-8 text-center">{{ voteCount }}</span>
                                        <button
                                            class="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center hover:bg-gray-300 transition-colors"
                                            @click="incrementVotes">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M12 5v14"></path>
                                                <path d="M5 12h14"></path>
                                            </svg>
                                        </button>
                                    </div>
                                    <p class="text-right text-sm font-medium text-gray-700 mt-1">
                                        Total: {{ voteCount * 200 }} RWF
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="flex gap-3 sm:w-auto w-full justify-end">
                            <Button variant="outline" @click="closeModal" class="sm:w-auto w-1/3">Cancel</Button>
                            <Button :disabled="!selectedNominee" @click="submitVote"
                                class="bg-blue-600 hover:bg-blue-700 sm:w-auto w-2/3">
                                Cast {{ voteCount > 1 ? voteCount + ' Votes' : 'Your Vote' }}
                            </Button>
                        </div>
                    </div>
                </div>
            </DialogContent>
        </Dialog>

        <!-- Enhanced Success modal -->
        <Dialog :open="showSuccessModal" @update:open="showSuccessModal = false">
            <DialogContent class="sm:max-w-md">
                <div class="text-center py-6">
                    <div
                        class="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6 relative">
                        <svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            class="text-green-600">
                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                            <polyline points="22 4 12 14.01 9 11.01"></polyline>
                        </svg>

                        <!-- Decorative elements -->
                        <div
                            class="absolute -top-1 -right-1 w-6 h-6 bg-yellow-400 rounded-full flex items-center justify-center animate-bounce">
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round" class="text-white">
                                <polygon
                                    points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
                                </polygon>
                            </svg>
                        </div>
                        <div
                            class="absolute -bottom-1 -left-1 w-6 h-6 bg-blue-500 rounded-full flex items-center justify-center animate-pulse">
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round" class="text-white">
                                <path d="M8.21 13.89 7 23l5-3 5 3-1.21-9.12"></path>
                                <path d="M15 7h4a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-4"></path>
                                <path d="M9 7H5a2 2 0 0 0-2 2 2 2 0 0 0 2 2h4"></path>
                                <path d="M12 2v8"></path>
                                <path d="M12 17v4"></path>
                            </svg>
                        </div>
                    </div>
                    <h2 class="text-2xl font-bold text-gray-800 mb-2">Vote Successful!</h2>
                    <p class="text-gray-600 mb-6">
                        Thank you for supporting your favorite nominee in the RPL 2025 Awards.
                        Your vote has been registered successfully.
                    </p>
                    <div class="flex flex-col sm:flex-row gap-3 justify-center">
                        <Button @click="showSuccessModal = false" class="bg-blue-600 hover:bg-blue-700">Continue
                            Voting</Button>
                        <Button variant="outline" @click="showSuccessModal = false">Share on Social Media</Button>
                    </div>
                </div>
            </DialogContent>
        </Dialog>
    </PublicLayout>

</template>
