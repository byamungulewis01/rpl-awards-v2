<script setup>
import { ref, computed, watch } from 'vue';
import imagePath from '@/lib/image';
import { Head, useForm } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import HeroWithCountdown from '@/Components/HeroWithCountdown.vue';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from '@/Components/ui/dialog';
import NewsSlider from '@/Components/NewsSlider.vue';
import NewsArchive from '@/Components/NewsArchive.vue';
const props = defineProps(
    {
        categories: Array,
        vote_amount: Number,
        news: {
            type: Array,
            required: true
        }
    }
)

// State management for categories, candidates and votes
const categories = ref(props.categories || []);
const loading = ref(false);
const voteCount = ref(1);
const totalAmount = ref(props.vote_amount);
const selectedCandidate = ref(null);
const showThankYou = ref(false);
const selectedCategory = ref(null);
const showCandidateDialog = ref(false);

// Set default category if available
if (categories.value.length > 0) {
    selectedCategory.value = categories.value[0];
}

// Update total amount when vote count changes
watch(voteCount, (newCount) => {
    totalAmount.value = newCount * props.vote_amount;
});

const handleCategorySelect = (category) => {
    selectedCategory.value = category;
    selectedCandidate.value = null;
    voteCount.value = 1;
};

const handleVoteChange = (value) => {
    const newCount = Math.min(Math.max(1, voteCount.value + value), 100);
    voteCount.value = newCount;
};

const handleCandidateSelect = (candidate) => {
    selectedCandidate.value = candidate;
    showCandidateDialog.value = true;
};

// Use Inertia form for submission
const form = useForm({
    candidateId: '',
    categoryId: '',
    votes: 1,
});

const resetFormData = () => {
    // Reset form inputs
    voteCount.value = 1;
    form.categoryId = '';
    totalAmount.value = props.vote_amount;

    // Reset Inertia form
    form.reset();
};

const handleVoteSubmit = () => {
    // Update form data
    form.candidateId = selectedCandidate.value.id;
    form.categoryId = selectedCategory.value.id;
    form.votes = voteCount.value;


    showCandidateDialog.value = false;
    showThankYou.value = true;
    // resetFormData();

    // Submit the form
    // form.post(route('voting.process'), {
    //     preserveScroll: true,
    //     onSuccess: () => {
    //         showCandidateDialog.value = false;
    //         showThankYou.value = true;
    //         resetFormData();
    //     },
    //     onError: () => {
    //         // Handle errors if needed
    //     }
    // });
};

</script>

<template>

    <Head title="Voting" />
    <PublicLayout title="Vote for the best in Rwandan football">

        <HeroWithCountdown :targetDate="new Date('2025-05-30')" :votePrice="200" />
        <NewsSlider :news="news" />
        <!-- Categories and Voting Section -->
        <div id="categories" class="bg-gray-50 py-12">
            <div class="max-w-[85rem] mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-6">
                    <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                        Ibyiciro by'Ibihembo
                    </h2>
                    <p class="mt-4 text-lg text-gray-500">
                        Hitamo icyiciro kugirango utangire gutora
                    </p>
                </div>

                <div v-if="loading" class="flex justify-center py-12">
                    <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-sky-500"></div>
                </div>

                <template v-else>
                    <!-- Category Tabs -->
                    <div class="flex flex-wrap justify-center gap-3 mb-8">
                        <button v-for="category in categories" :key="category.id"
                            @click="handleCategorySelect(category)" :class="`px-6 py-3 rounded-full text-sm md:text-base font-medium transition-all duration-300 ${selectedCategory?.id === category.id
                                ? 'bg-sky-500 text-white shadow-lg transform scale-105'
                                : 'bg-white text-sky-700 hover:bg-sky-50 shadow'
                                }`">
                            {{ category.name }}
                        </button>
                    </div>

                    <!-- Candidates Grid -->
                    <div v-if="selectedCategory" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                        <template v-if="selectedCategory.candidates && selectedCategory.candidates.length > 0">
                            <div v-for="candidate in selectedCategory.candidates" :key="candidate.id" :class="`bg-white rounded-xl shadow-md overflow-hidden transform transition-all duration-300 hover:shadow-xl cursor-pointer ${selectedCandidate?.id === candidate.id
                                ? 'ring-4 ring-sky-500 scale-105'
                                : 'hover:-translate-y-1'
                                }`" @click="handleCandidateSelect(candidate)">
                                <div class="relative">
                                    <div class="bg-sky-50 relative">
                                        <img :src="imagePath(`/${candidate.image}`)" :alt="candidate.name"
                                            class="w-full h-full object-cover" />
                                        <div
                                            class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black via-black/10 to-transparent h-32">
                                        </div>
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

        <!-- <NewsArchive /> -->




        <!-- Candidate Dialog using shadcn-vue Dialog component -->
        <Dialog :open="showCandidateDialog" @update:open="showCandidateDialog = $event">
            <DialogContent class="sm:max-w-4xl p-0 overflow-hidden">
                <div class="flex flex-col md:flex-row">
                    <!-- Left: Candidate Image -->
                    <div class="hidden md:block w-full md:w-1/2 bg-sky-50">
                        <div class="relative h-full">
                            <img v-if="selectedCandidate" :src="imagePath(`/${selectedCandidate.image}`)"
                                :alt="selectedCandidate?.name" class="w-full h-full object-cover" />
                        </div>
                    </div>

                    <!-- Right: Candidate Details and Vote Counter -->
                    <div class="w-full md:w-1/2 p-6">
                        <DialogHeader>
                            <DialogTitle class="text-2xl font-bold text-gray-900">
                                {{ selectedCandidate?.name }}
                            </DialogTitle>
                            <DialogDescription class="text-sky-600 font-medium">
                                {{ selectedCategory?.name }}
                            </DialogDescription>
                        </DialogHeader>

                        <div class="mt-6">
                            <!-- Player Stats Section -->
                            <div class="mb-6 bg-sky-50 p-4 rounded-lg">
                                <!-- Player Stats -->
                                <template v-if="selectedCategory?.id === 1">
                                    <h4 class="font-medium text-gray-800 mb-3">Imibare y'Umukinnyi</h4>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div class="bg-white p-3 rounded shadow-sm">
                                            <div class="text-sm text-gray-500">Ibitego</div>
                                            <div class="text-xl font-bold text-sky-700">{{
                                                selectedCandidate?.stats?.goals || '0' }}</div>
                                        </div>
                                        <div class="bg-white p-3 rounded shadow-sm">
                                            <div class="text-sm text-gray-500">Assists</div>
                                            <div class="text-xl font-bold text-sky-700">{{
                                                selectedCandidate?.stats?.assists || '0' }}</div>
                                        </div>
                                        <div class="bg-white p-3 rounded shadow-sm">
                                            <div class="text-sm text-gray-500">Imikino</div>
                                            <div class="text-xl font-bold text-sky-700">{{
                                                selectedCandidate?.stats?.matches || '0' }}</div>
                                        </div>

                                    </div>
                                </template>

                                <!-- Coach Stats -->
                                <template v-else-if="selectedCategory?.id === 3">
                                    <h4 class="font-medium text-gray-800 mb-3">Imibare y'Umutoza</h4>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div class="bg-white p-3 rounded shadow-sm">
                                            <div class="text-sm text-gray-500">Intsinzi</div>
                                            <div class="text-xl font-bold text-sky-700">{{
                                                selectedCandidate?.stats?.wins || '0' }}</div>
                                        </div>
                                        <div class="bg-white p-3 rounded shadow-sm">
                                            <div class="text-sm text-gray-500">Uko Banganyije</div>
                                            <div class="text-xl font-bold text-sky-700">{{
                                                selectedCandidate?.stats?.draws || '0' }}</div>
                                        </div>
                                        <div class="bg-white p-3 rounded shadow-sm">
                                            <div class="text-sm text-gray-500">Gutsindwa</div>
                                            <div class="text-xl font-bold text-sky-700">{{
                                                selectedCandidate?.stats?.losses || '0' }}</div>
                                        </div>
                                        <div class="bg-white p-3 rounded shadow-sm">
                                            <div class="text-sm text-gray-500">Ijanisha ry'Intsinzi</div>
                                            <div class="text-xl font-bold text-sky-700">{{
                                                selectedCandidate?.stats?.winRate || '0' }}%</div>
                                        </div>
                                    </div>
                                </template>

                                <!-- Goal of the Season Stats -->
                                <template v-else-if="selectedCategory?.id === 2">
                                    <h4 class="font-medium text-gray-800 mb-3">Ibisobanuro by'Igitego</h4>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div class="bg-white p-3 rounded shadow-sm">
                                            <div class="text-sm text-gray-500">Umukino</div>
                                            <div class="text-xl font-bold text-sky-700">{{
                                                selectedCandidate?.stats?.match || 'Ntabwo Ihari' }}</div>
                                        </div>
                                        <div class="bg-white p-3 rounded shadow-sm">
                                            <div class="text-sm text-gray-500">Iminota</div>
                                            <div class="text-xl font-bold text-sky-700">{{
                                                selectedCandidate?.stats?.minute || 'Ntabwo Ihari' }}</div>
                                        </div>
                                        <div class="bg-white p-3 rounded shadow-sm col-span-2">
                                            <div class="text-sm text-gray-500">Ubwoko bw'Igitego</div>
                                            <div class="text-xl font-bold text-sky-700">{{
                                                selectedCandidate?.stats?.goalType || 'Gisanzwe' }}</div>
                                        </div>
                                    </div>
                                </template>
                            </div>

                            <!-- Vote Counter -->
                            <div class="bg-white p-4 rounded-lg shadow mb-6 border border-gray-100">
                                <div class="flex items-center justify-between mb-4">
                                    <span class="block text-gray-800 font-medium">Umubare w'amajwi</span>
                                    <div class="flex items-center">
                                        <button @click="handleVoteChange(-1)"
                                            class="flex items-center justify-center w-8 h-8 rounded-full bg-sky-100 text-sky-700 hover:bg-sky-200 transition">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20"
                                                fill="currentColor">
                                                <path fill-rule="evenodd"
                                                    d="M3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                                                    clip-rule="evenodd" />
                                            </svg>
                                        </button>

                                        <div class="w-12 mx-3 text-center">
                                            <span class="text-xl font-bold text-sky-700">{{ voteCount }}</span>
                                        </div>

                                        <button @click="handleVoteChange(1)"
                                            class="flex items-center justify-center w-8 h-8 rounded-full bg-sky-100 text-sky-700 hover:bg-sky-200 transition">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20"
                                                fill="currentColor">
                                                <path fill-rule="evenodd"
                                                    d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z"
                                                    clip-rule="evenodd" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Vote Button -->
                            <button @click="handleVoteSubmit"
                                class="w-full py-3 bg-sky-500 text-white font-medium rounded-lg shadow-md hover:bg-sky-600 transition-all duration-300">
                                Tora Nonaha
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
                        <strong>{{ selectedCategory?.name }}</strong>. Amajwi {{ voteCount }} yanditswe.
                    </p>

                    <button @click="() => { showThankYou = false; resetFormData(); }"
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
