<script setup>
import { ref, computed, watch } from 'vue';
import imagePath from '@/lib/image';
import { Head, router, useForm } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from '@/Components/ui/dialog';

const props = defineProps(
    {
        categories: Array,
    }
)

// State management for categories, candidates and votes
const categories = ref(props.categories || []);
const loading = ref(false);
const selectedCandidate = ref(null);
const showThankYou = ref(false);
const selectedCategory = ref(null);
const showCandidateDialog = ref(false);
const voteError = ref(null);

// Set default category if available
if (categories.value.length > 0) {
    selectedCategory.value = categories.value[0];
}

// Computed property to get voted candidates count
const votedCount = computed(() => {
    return categories.value.filter(category => category.hasVoted).length;
});

const totalCategories = computed(() => {
    return categories.value.length;
});

const handleCategorySelect = (category) => {
    selectedCategory.value = category;
    selectedCandidate.value = null;
};

const handleCandidateSelect = (candidate) => {
    selectedCandidate.value = candidate;
    voteError.value = null;
    showCandidateDialog.value = true;
};

// Use Inertia form for submission
const form = useForm({
    candidateId: '',
    categoryId: '',
});

const resetFormData = () => {
    form.categoryId = '';
    form.candidateId = '';
    voteError.value = null;
    form.reset();
};

const handleVoteSubmit = () => {
    voteError.value = null;

    form.candidateId = selectedCandidate.value.id;
    form.categoryId = selectedCategory.value.id;

    form.post(route('voting.store'), {
        preserveScroll: true,
        onSuccess: () => {
            showCandidateDialog.value = false;
            showThankYou.value = true;
            resetFormData();
        },
        onError: (errors) => {
            if (errors.duplicate) {
                voteError.value = errors.duplicate;
            } else if (errors.error) {
                voteError.value = errors.error;
            } else {
                voteError.value = 'Hari ikibazo cyabaye. Ongera ugerageze.';
            }
        }
    });
};

</script>

<template>

    <Head title="Voting" />
    <PublicLayout title="Vote for the best in Rwandan football">

        <div id="categories" class="bg-gray-50 py-12">
            <div class="max-w-[85rem] mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-6">
                    <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                        Ibyiciro by'Ibihembo
                    </h2>
                    <p class="mt-4 text-lg text-gray-500">
                        Hitamo icyiciro kugirango utangire gutora
                    </p>

                    <!-- Voting Progress -->
                    <div class="mt-6 max-w-md mx-auto">
                        <div class="bg-white p-4 rounded-lg shadow-sm border">
                            <div class="flex items-center justify-between mb-2">
                                <span class="text-sm font-medium text-gray-700">Uho ugejeje utora</span>
                                <span class="text-sm font-medium text-sky-600">{{ votedCount }}/{{ totalCategories
                                    }}</span>
                            </div>
                            <div class="w-full bg-gray-200 rounded-full h-2">
                                <div class="bg-sky-500 h-2 rounded-full transition-all duration-300"
                                    :style="`width: ${totalCategories > 0 ? (votedCount / totalCategories) * 100 : 0}%`">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div v-if="loading" class="flex justify-center py-12">
                    <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-sky-500"></div>
                </div>

                <template v-else>
                    <!-- Category Tabs -->
                    <div class="flex flex-wrap justify-center gap-3 mb-8">
                        <button v-for="category in categories" :key="category.id"
                            @click="handleCategorySelect(category)" :class="`px-6 py-3 rounded-full text-sm md:text-base font-medium transition-all duration-300 relative ${selectedCategory?.id === category.id
                                ? 'bg-sky-500 text-white shadow-lg transform scale-105'
                                : 'bg-white text-sky-700 hover:bg-sky-50 shadow'
                                }`">
                            {{ category.name }}

                            <!-- Vote indicator -->
                            <span v-if="category.hasVoted"
                                class="absolute -top-1 -right-1 h-3 w-3 bg-green-500 rounded-full border-2 border-white">
                            </span>
                        </button>
                    </div>

                    <!-- Candidates Grid -->
                    <div v-if="selectedCategory" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                        <template v-if="selectedCategory.candidates && selectedCategory.candidates.length > 0">
                            <div v-for="candidate in selectedCategory.candidates" :key="candidate.id" :class="`bg-white rounded-xl shadow-md overflow-hidden transform transition-all duration-300 cursor-pointer relative ${candidate.isVoted
                                ? 'ring-4 ring-green-500 shadow-lg'
                                : selectedCandidate?.id === candidate.id
                                    ? 'ring-4 ring-sky-500 scale-105'
                                    : 'hover:shadow-xl hover:-translate-y-1'
                                }`" @click="handleCandidateSelect(candidate)">

                                <!-- Voted Badge -->
                                <div v-if="candidate.isVoted"
                                    class="absolute top-3 right-3 z-10 bg-green-500 text-white text-xs font-bold px-2 py-1 rounded-full flex items-center gap-1">
                                    <svg class="h-3 w-3" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd"
                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                            clip-rule="evenodd" />
                                    </svg>
                                    WAMUTOYE
                                </div>

                                <div class="relative">
                                    <div class="bg-sky-50 relative">
                                        <img :src="imagePath(`/${candidate.image}`)" :alt="candidate.name"
                                            class="w-full h-full object-cover" />
                                        <div
                                            class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black via-black/10 to-transparent h-32">
                                        </div>

                                        <!-- Candidate name overlay -->
                                        <!-- <div class="absolute bottom-4 left-4 right-4">
                                            <h3 class="text-white font-bold text-lg leading-tight">{{ candidate.name }}
                                            </h3>
                                        </div> -->
                                    </div>
                                </div>
                            </div>
                        </template>
                        <template v-else>
                            <div class="col-span-full py-10 flex justify-center">
                                <div class="text-center p-8 max-w-lg">
                                    <div class="mb-4">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-gray-400 mx-auto"
                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                                d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                                        </svg>
                                    </div>
                                    <h3 class="text-xl font-bold text-gray-900 mb-2">Nta mukandida ubashije kuboneka
                                    </h3>
                                    <p class="text-gray-600">Nta mukandida wabonetse muri iki cyiciro. Uzagaruke nyuma
                                        gusura iyi paji.</p>
                                    <div class="mt-4 text-sm text-gray-500">No candidates available in this category
                                        yet. Please check back later.</div>
                                </div>
                            </div>
                        </template>
                    </div>

                    <div v-else class="text-center py-8 bg-white rounded-lg shadow-sm">
                        <div class="text-gray-500 text-lg">Hitamo icyiciro kugira ngo urebe abakandida</div>
                    </div>
                </template>
            </div>
        </div>

        <!-- Candidate Dialog -->
        <Dialog :open="showCandidateDialog" @update:open="showCandidateDialog = $event">
            <DialogContent class="sm:max-w-4xl p-0 overflow-hidden">
                <div class="flex flex-col md:flex-row">
                    <!-- Left: Candidate Image -->
                    <div class="hidden md:block w-full md:w-1/2 bg-sky-50">
                        <div class="relative h-full">
                            <img v-if="selectedCandidate" :src="imagePath(`/${selectedCandidate.image}`)"
                                :alt="selectedCandidate?.name" class="w-full h-full object-cover" />

                            <!-- Voted overlay for dialog -->
                            <div v-if="selectedCandidate?.isVoted"
                                class="absolute inset-0 bg-green-500 bg-opacity-20 flex items-center justify-center">
                                <div
                                    class="bg-green-500 text-white px-4 py-2 rounded-lg font-bold flex items-center gap-2">
                                    <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd"
                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                            clip-rule="evenodd" />
                                    </svg>
                                    WAMAZE KUMUTORA
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right: Candidate Details and Vote Counter -->
                    <div class="w-full md:w-1/2 p-6">
                        <DialogHeader>
                            <DialogTitle class="text-2xl font-bold text-gray-900 flex items-center gap-2">
                                {{ selectedCandidate?.name }}
                                <span v-if="selectedCandidate?.isVoted"
                                    class="inline-flex items-center px-2 py-1 text-xs font-medium bg-green-100 text-green-800 rounded-full">
                                    <svg class="h-3 w-3 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd"
                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                            clip-rule="evenodd" />
                                    </svg>
                                    WAMUTOYE
                                </span>
                            </DialogTitle>
                            <DialogDescription class="text-sky-600 font-medium">
                                {{ selectedCategory?.name }}
                            </DialogDescription>
                        </DialogHeader>

                        <div class="mt-6">
                            <!-- Player Stats Section -->
                            <div class="mb-6 bg-sky-50 p-4 rounded-lg">
                                <h4 class="font-medium text-gray-800 mb-3">Imibare y'Umukandida (Statistics)</h4>
                                <div class="grid grid-cols-2 gap-4">
                                    <div v-if="selectedCandidate?.stats?.appearances"
                                        class="bg-white p-3 rounded shadow-sm">
                                        <div class="text-sm text-gray-500">Imikino</div>
                                        <div class="text-xl font-bold text-sky-700">{{
                                            selectedCandidate?.stats?.appearances ||
                                            '0' }}</div>
                                    </div>
                                    <div v-if="selectedCandidate?.stats?.goals" class="bg-white p-3 rounded shadow-sm">
                                        <div class="text-sm text-gray-500">Ibitego</div>
                                        <div class="text-xl font-bold text-sky-700">{{ selectedCandidate?.stats?.goals
                                            || '0' }}
                                        </div>
                                    </div>
                                    <div v-if="selectedCandidate?.stats?.assists"
                                        class="bg-white p-3 rounded shadow-sm">
                                        <div class="text-sm text-gray-500">Assists</div>
                                        <div class="text-xl font-bold text-sky-700">{{ selectedCandidate?.stats?.assists
                                            || '0'
                                            }}</div>
                                    </div>
                                    <div v-if="selectedCandidate?.stats?.wins" class="bg-white p-3 rounded shadow-sm">
                                        <div class="text-sm text-gray-500">Intsinzi</div>
                                        <div class="text-xl font-bold text-sky-700">{{ selectedCandidate?.stats?.wins ||
                                            '0' }}
                                        </div>
                                    </div>
                                    <div v-if="selectedCandidate?.stats?.draws" class="bg-white p-3 rounded shadow-sm">
                                        <div class="text-sm text-gray-500">Ukunganya</div>
                                        <div class="text-xl font-bold text-sky-700">{{ selectedCandidate?.stats?.draws
                                            || '0' }}
                                        </div>
                                    </div>
                                    <div v-if="selectedCandidate?.stats?.losses" class="bg-white p-3 rounded shadow-sm">
                                        <div class="text-sm text-gray-500">Gutsindwa</div>
                                        <div class="text-xl font-bold text-sky-700">{{ selectedCandidate?.stats?.losses
                                            || '0'
                                            }}</div>
                                    </div>
                                    <div v-if="selectedCandidate?.stats?.cleanSheets"
                                        class="bg-white p-3 rounded shadow-sm">
                                        <div class="text-sm text-gray-500">Clean Sheet</div>
                                        <div class="text-xl font-bold text-sky-700">{{
                                            selectedCandidate?.stats?.cleanSheets ||
                                            '0' }}</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Error Alert -->
                            <div v-if="voteError" class="bg-red-50 border border-red-200 rounded-lg p-4 mb-6">
                                <div class="flex items-center">
                                    <svg class="h-5 w-5 text-red-400 mr-2" xmlns="http://www.w3.org/2000/svg"
                                        viewBox="0 0 20 20" fill="currentColor">
                                        <path fill-rule="evenodd"
                                            d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z"
                                            clip-rule="evenodd" />
                                    </svg>
                                    <span class="text-sm text-red-800 font-medium">{{ voteError }}</span>
                                </div>
                            </div>

                            <!-- Info Alert - Updated for vote changing -->
                            <div class="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
                                <div class="flex items-center">
                                    <svg class="h-5 w-5 text-blue-400 mr-2" xmlns="http://www.w3.org/2000/svg"
                                        viewBox="0 0 20 20" fill="currentColor">
                                        <path fill-rule="evenodd"
                                            d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z"
                                            clip-rule="evenodd" />
                                    </svg>
                                    <span class="text-sm text-blue-800">
                                        <template v-if="selectedCandidate?.isVoted">
                                            <strong>Icyitonderwa:</strong> Wamaze gutora uyu mukandida. Niba ushaka
                                            guhindura itora ryawe, kanda "Tora Nonaha" uyu mukandida uziko wishyiraho.
                                        </template>
                                        <template v-else>
                                            <strong>Icyitonderwa:</strong> Mushobora guhindura itora ryawe rimwe gusa
                                            muri buri cyiciro.
                                        </template>
                                    </span>
                                </div>
                            </div>

                            <!-- Vote Button -->
                            <button @click="handleVoteSubmit" :disabled="form.processing" :class="`w-full py-3 font-medium rounded-lg shadow-md transition-all duration-300 flex items-center justify-center gap-2 ${form.processing
                                ? 'bg-sky-400 cursor-not-allowed'
                                : selectedCandidate?.isVoted
                                    ? 'bg-orange-500 hover:bg-orange-600 active:transform active:scale-95'
                                    : 'bg-sky-500 hover:bg-sky-600 active:transform active:scale-95'
                                } text-white`">

                                <!-- Loading Spinner -->
                                <div v-if="form.processing" class="flex items-center gap-2">
                                    <svg class="animate-spin h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg"
                                        fill="none" viewBox="0 0 24 24">
                                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor"
                                            stroke-width="4"></circle>
                                        <path class="opacity-75" fill="currentColor"
                                            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                                        </path>
                                    </svg>
                                    <span>{{ selectedCandidate?.isVoted ? 'Kuvugurura...' : 'Gutora...' }}</span>
                                </div>

                                <!-- Default Button Text -->
                                <span v-else>
                                    {{ selectedCandidate?.isVoted ? 'Hindura Itora' : 'Tora Nonaha' }}
                                </span>
                            </button>
                        </div>
                    </div>
                </div>
            </DialogContent>
        </Dialog>

        <!-- Thank You Dialog -->
        <div v-if="showThankYou" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
            <div class="bg-white rounded-lg shadow-xl max-w-lg w-full mx-4 overflow-hidden animate-bounce-in">
                <div class="p-6 text-center">
                    <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-green-100 mb-6">
                        <svg class="h-10 w-10 text-green-600" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </div>

                    <h3 class="text-2xl font-bold text-gray-900 mb-2">Murakoze gutora!</h3>
                    <p class="text-gray-600 mb-6">
                        Ijwi ryawe ryakiriwe. Murakoze gutora <strong>{{ selectedCandidate?.name }}</strong> mu icyiciro
                        <strong>{{ selectedCategory?.name }}</strong>.
                    </p>

                    <button
                        @click="() => { showThankYou = false; resetFormData(); router.visit(route('voting'), { only: ['categories'] }); }"
                        class="mt-6 w-full bg-sky-500 text-white py-3 rounded-lg font-medium hover:bg-sky-600 transition">
                        Funga
                    </button>
                </div>
            </div>
        </div>

    </PublicLayout>
</template>

<style scoped>
.animate-fade-in-down {
    animation: fadeInDown 0.5s ease-in-out;
}

@keyframes fadeInDown {
    0% {
        opacity: 0;
        transform: translateY(-20px);
    }

    100% {
        opacity: 1;
        transform: translateY(0);
    }
}

.animate-scale-in {
    animation: scaleIn 0.5s ease-in-out;
}

@keyframes scaleIn {
    0% {
        transform: scale(0.8);
        opacity: 0;
    }

    100% {
        transform: scale(1);
        opacity: 1;
    }
}

.animate-bounce-in {
    animation: bounceIn 0.5s ease-in-out;
}

@keyframes bounceIn {
    0% {
        transform: scale(0.5);
        opacity: 0;
    }

    50% {
        transform: scale(1.05);
        opacity: 1;
    }

    100% {
        transform: scale(1);
    }
}
</style>