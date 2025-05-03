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
    }
)

// State management for categories, candidates and votes
const categories = ref(props.categories || []);
const loading = ref(false);
const paymentLoading = ref(false);
const voteCount = ref(1);
const totalAmount = ref(200);
const selectedCandidate = ref(null);
const showPaymentModal = ref(false);
const paymentMethod = ref('mtn');
const phoneNumber = ref('');
const phoneNumberError = ref('');
const isPhoneNumberValid = ref(true);
const showThankYou = ref(false);
const selectedLeague = ref('men'); // Default to men's league
const selectedCategory = ref(null);
const showCandidateDialog = ref(false);

// Set default category if available
if (categories.value.length > 0) {
    const defaultCategory = categories.value.find(cat => cat.league === selectedLeague.value);
    if (defaultCategory) {
        selectedCategory.value = defaultCategory;
    }
}

// Filtered categories based on selected league
const filteredCategories = computed(() => {
    return categories.value.filter(category => category.league === selectedLeague.value);
});

// Update total amount when vote count changes
watch(voteCount, (newCount) => {
    totalAmount.value = newCount * 200;
});

const handleLeagueSelect = (league) => {
    selectedLeague.value = league;

    // Reset selection when changing league
    const firstCategoryInLeague = categories.value.find(cat => cat.league === league);
    if (firstCategoryInLeague) {
        selectedCategory.value = firstCategoryInLeague;
    } else {
        selectedCategory.value = null;
    }

    selectedCandidate.value = null;
    voteCount.value = 1;
};

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

const handleProceedToPayment = () => {
    showPaymentModal.value = true;
    showCandidateDialog.value = false;
    // Reset phone validation when opening modal
    phoneNumberError.value = '';
    isPhoneNumberValid.value = true;
};

// Validate phone number format
const validatePhoneNumber = () => {
    // Reset validation state
    phoneNumberError.value = '';
    isPhoneNumberValid.value = true;

    // Check if phone number starts with '07' and is exactly 10 digits
    const phoneRegex = /^07\d{8}$/;

    if (!phoneNumber.value) {
        phoneNumberError.value = 'Nimero ya Telephone irakenewe';
        isPhoneNumberValid.value = false;
        return false;
    } else if (!phoneRegex.test(phoneNumber.value)) {
        phoneNumberError.value = 'Nimere ya Telephone igomba kuba itangizwa na 07';
        isPhoneNumberValid.value = false;
        return false;
    }

    return true;
};

// Use Inertia form for submission
const form = useForm({
    candidateId: '',
    votes: 1,
    phoneNumber: '',
    paymentMethod: 'mtn',
    amount: 200
});

const resetFormData = () => {
    // Reset form inputs
    phoneNumber.value = '';
    voteCount.value = 1;
    totalAmount.value = 200;

    // Reset validation states
    phoneNumberError.value = '';
    isPhoneNumberValid.value = true;

    // Reset Inertia form
    form.reset();
};

const handlePaymentSubmit = (e) => {
    e.preventDefault();

    // Validate phone number before proceeding
    if (!validatePhoneNumber()) {
        return;
    }

    // Update form data
    form.candidateId = selectedCandidate.value.id;
    form.votes = voteCount.value;
    form.phoneNumber = phoneNumber.value;
    form.paymentMethod = paymentMethod.value;
    form.amount = totalAmount.value;

    // Show loading
    paymentLoading.value = true;

    // Submit the form
    form.post(route('voting.process'), {
        preserveScroll: true,
        onSuccess: () => {
            showPaymentModal.value = false;
            showThankYou.value = true;
            paymentLoading.value = false;
            resetFormData();

        },
        onError: () => {
            paymentLoading.value = false;
            // If there's a phone number error from the server
            if (form.errors.phoneNumber) {
                phoneNumberError.value = form.errors.phoneNumber;
                isPhoneNumberValid.value = false;
            }
        }
    });
};

const handleCloseModal = () => {
    showPaymentModal.value = false;
};

const handleCloseDialog = () => {
    showCandidateDialog.value = false;
};
</script>

<template>

    <Head title="Voting" />
    <PublicLayout title="Vote for the best in Rwandan football">

        <HeroWithCountdown :targetDate="new Date('2025-06-30')" :votePrice="200" />
        <NewsSlider :autoSlide="true" :interval="5000" />
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

                <!-- League Filter Tabs -->
                <div class="mb-8 flex justify-center">
                    <div class="inline-flex bg-white rounded-lg p-1 shadow">
                        <button @click="handleLeagueSelect('men')" :class="`px-4 py-2 rounded-md text-sm font-medium transition-all duration-300 ${selectedLeague === 'men'
                            ? 'bg-sky-500 text-white'
                            : 'text-gray-500 hover:text-sky-700'}`">
                            ABAGABO
                        </button>

                        <button @click="handleLeagueSelect('women')" :class="`px-4 py-2 rounded-md text-sm font-medium transition-all duration-300 ${selectedLeague === 'women'
                            ? 'bg-pink-500 text-white'
                            : 'text-gray-500 hover:text-pink-700'}`">
                            ABAGORE
                        </button>
                    </div>
                </div>

                <div v-if="loading" class="flex justify-center py-12">
                    <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-sky-500"></div>
                </div>

                <template v-else>
                    <!-- Category Tabs -->
                    <div class="flex flex-wrap justify-center gap-3 mb-8">
                        <button v-for="category in filteredCategories" :key="category.id"
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

                                        <!-- Candidate info on image -->
                                        <div class="absolute bottom-0 left-0 w-full p-4 text-white">
                                            <div class="bg-sky-700 text-white text-xs px-2 py-1 rounded float-end">Via
                                                USSD
                                                <strong>*192*{{ candidate.code }}#</strong>
                                            </div>
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

        <NewsArchive />

        <!-- Contact Us Section -->
        <div id="contact-us" class="bg-white py-12 border-t border-gray-200">
            <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-8">
                    <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                        Twandikire
                    </h2>
                    <p class="mt-4 text-lg text-gray-500">
                        Ufite ibibazo ku matora cyangwa ukeneye ubufasha? Vugisha ikipe yacu y'ubufasha.
                    </p>
                </div>

                <div class="flex flex-col lg:flex-row gap-8">
                    <!-- Contact Cards - Right side on desktop, top on mobile -->
                    <div class="w-full lg:w-1/3 space-y-6">
                        <div class="bg-gray-50 p-6 rounded-lg shadow-md hover:shadow-lg transition duration-300">
                            <div
                                class="flex justify-center items-center h-12 w-12 rounded-md bg-sky-500 text-white mx-auto mb-4">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                </svg>
                            </div>
                            <h3 class="text-lg font-medium text-gray-900 text-center mb-2">Imeyili</h3>
                            <p class="text-gray-600 text-center">support@rwandapl.rw</p>
                            <div class="mt-4 text-center">
                                <a href="mailto:support@rwandapl.rw"
                                    class="text-sky-600 hover:text-sky-800 font-medium">Ohereza
                                    Imeyili</a>
                            </div>
                        </div>

                        <div class="bg-gray-50 p-6 rounded-lg shadow-md hover:shadow-lg transition duration-300">
                            <div
                                class="flex justify-center items-center h-12 w-12 rounded-md bg-sky-500 text-white mx-auto mb-4">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                </svg>
                            </div>
                            <h3 class="text-lg font-medium text-gray-900 text-center mb-2">Telefoni</h3>
                            <p class="text-gray-600 text-center">+250 788 123 456</p>
                            <div class="mt-4 text-center">
                                <a href="tel:+250788123456" class="text-sky-600 hover:text-sky-800 font-medium">Hamagara
                                    Ubu</a>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Form - Left side on desktop, bottom on mobile -->
                    <div class="w-full lg:w-2/3 bg-white rounded-lg shadow-md p-6 md:p-8">
                        <h3 class="text-xl font-bold text-gray-900 mb-6">Dutumire ubutumwa</h3>
                        <form>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                <div>
                                    <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Izina
                                        Ryawe</label>
                                    <input type="text" id="name" name="name"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-sky-500 focus:border-sky-500"
                                        placeholder="Andika izina ryawe" required>
                                </div>
                                <div>
                                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Imeyili
                                        Yawe</label>
                                    <input type="email" id="email" name="email"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-sky-500 focus:border-sky-500"
                                        placeholder="Andika imeyili yawe" required>
                                </div>
                            </div>
                            <div class="mb-6">
                                <label for="subject"
                                    class="block text-sm font-medium text-gray-700 mb-1">Insanganyamatsiko</label>
                                <input type="text" id="subject" name="subject"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-sky-500 focus:border-sky-500"
                                    placeholder="Andika insanganyamatsiko" required>
                            </div>
                            <div class="mb-6">
                                <label for="message"
                                    class="block text-sm font-medium text-gray-700 mb-1">Ubutumwa</label>
                                <textarea id="message" name="message" rows="4"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-sky-500 focus:border-sky-500"
                                    placeholder="Ubutumwa bwawe..." required></textarea>
                            </div>
                            <div>
                                <button type="submit"
                                    class="w-full md:w-auto px-6 py-3 bg-sky-500 text-white font-medium rounded-md shadow hover:bg-sky-600 transition">Ohereza
                                    Ubutumwa</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

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

                                <div class="flex justify-between items-center">
                                    <span class="block text-gray-500">Igiteranyo</span>
                                    <div class="text-xl font-bold text-sky-700">{{ totalAmount }} RWF</div>
                                </div>

                                <div class="bg-sky-50 mt-4 p-3 rounded text-sm text-sky-700">
                                    <div class="flex items-center">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none"
                                            viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                        </svg>
                                        Ikindi, tora unyuze kuri USSD: <strong class="ml-1">*192*{{
                                            selectedCandidate?.code
                                            }}#</strong>
                                    </div>
                                </div>
                            </div>

                            <!-- Vote Button -->
                            <button @click="handleProceedToPayment"
                                class="w-full py-3 bg-sky-500 text-white font-medium rounded-lg shadow-md hover:bg-sky-600 transition-all duration-300">
                                Tora Nonaha
                            </button>
                        </div>
                    </div>
                </div>
            </DialogContent>
        </Dialog>


        <!-- Payment Modal -->
        <div v-if="showPaymentModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
            <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4 overflow-hidden animate-scale-in">
                <div class="bg-sky-500 px-6 py-4 flex justify-between items-center">
                    <h3 class="text-lg font-medium text-white">Ibisobanuro by'Ubwishyu</h3>
                    <button @click="handleCloseModal" class="text-white hover:text-sky-200">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>

                <div class="p-6">
                    <div class="mb-6">
                        <div class="flex justify-between items-center mb-4 pb-4 border-b border-gray-200">
                            <div>
                                <div class="text-gray-600">Umukandida</div>
                                <div class="font-medium">{{ selectedCandidate?.name }}</div>
                            </div>
                            <div>
                                <div class="text-gray-600">Amajwi</div>
                                <div class="font-medium text-right">{{ voteCount }}</div>
                            </div>
                        </div>
                        <div class="flex justify-between items-center mb-4 pb-4 border-b border-gray-200">
                            <div class="text-gray-800 font-medium">Igiteranyo cy'Amafaranga</div>
                            <div class="text-xl font-bold text-sky-600">{{ totalAmount }} RWF</div>
                        </div>
                    </div>

                    <form @submit="handlePaymentSubmit">
                        <div class="mb-6">
                            <label class="block text-gray-700 mb-2">Hitamo Uburyo bwo Kwishyura</label>
                            <div class="flex gap-4">
                                <div @click="paymentMethod = 'mtn'" :class="`flex-1 border rounded-lg p-4 cursor-pointer ${paymentMethod === 'mtn' ? 'border-sky-500 bg-sky-50' : 'border-gray-300'
                                    }`">
                                    <div class="flex items-center justify-center h-16">
                                        <!-- MTN MoMo Image -->
                                        <img :src="imagePath('/img/mtn-momo.jpg')" alt="MoMo from MTN"
                                            class="h-full object-contain rounded-lg">
                                    </div>
                                </div>

                                <div @click="paymentMethod = 'airtel'" :class="`flex-1 border rounded-lg p-4 cursor-pointer ${paymentMethod === 'airtel' ? 'border-red-500 bg-red-50' : 'border-gray-300'
                                    }`">
                                    <div class="flex items-center justify-center h-16">
                                        <!-- Airtel Money Image -->
                                        <img :src="imagePath('/img/airtel-money.jpg')" alt="Airtel Money"
                                            class="h-full object-contain rounded-lg">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-6">
                            <label for="phone" class="block text-gray-700 mb-2">Nimero ya Telefoni</label>
                            <input type="tel" id="phone" placeholder="07XXXXXXXX" v-model="phoneNumber"
                                @input="validatePhoneNumber"
                                :class="`w-full px-4 py-2 border rounded-lg focus:ring-sky-500 focus:border-sky-500 ${!isPhoneNumberValid ? 'border-red-500 bg-red-50' : 'border-gray-300'}`"
                                required />
                            <p v-if="phoneNumberError" class="mt-1 text-sm text-red-600">
                                {{ phoneNumberError }}
                            </p>
                            <p v-else class="mt-1 text-sm text-gray-500">
                                Andika nimero yawe ya telefoni ya {{ paymentMethod === 'mtn' ? 'MTN' : 'Airtel' }}
                            </p>
                        </div>

                        <button type="submit"
                            class="w-full bg-sky-500 text-white py-3 rounded-lg font-medium hover:bg-sky-600 transition"
                            :disabled="paymentLoading || !isPhoneNumberValid">
                            <span v-if="paymentLoading" class="flex items-center justify-center">
                                <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white"
                                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor"
                                        stroke-width="4">
                                    </circle>
                                    <path class="opacity-75" fill="currentColor"
                                        d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"></path>
                                </svg>
                                Birimo gutunganywa...
                            </span>
                            <span v-else>Ishyura {{ totalAmount }} RWF</span>
                        </button>
                    </form>
                </div>
            </div>
        </div>


        <div v-if="showThankYou" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
            <div class="bg-white rounded-lg shadow-xl max-w-lg w-full mx-4 overflow-hidden animate-bounce-in">
                <div class="p-6 text-center">
                    <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-blue-100 mb-6">
                        <svg class="h-10 w-10 text-blue-600" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>

                    <h3 class="text-2xl font-bold text-gray-900 mb-2">Ubwishyu Butegerejwe</h3>
                    <p class="text-gray-600 mb-6">
                        Ubutumwa bwo kwishyura bwoherejwe kuri telefoni yawe .
                        komeza ubwishyu kugira ngo urangize gutora <strong>{{ selectedCandidate?.name
                            }}</strong>.
                    </p>

                    <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-6">
                        <p class="text-yellow-800 font-medium">
                            Niba utahawe ubutumwa bugufi, kanda:
                        </p>
                        <p class="text-lg font-bold text-yellow-900 mt-2">
                            *182*7*1*PIN#
                        </p>
                        <p class="text-xs text-yellow-700 mt-1">Simbuza PIN na kode yawe ya PIN ya {{ paymentMethod ===
                            'mtn' ?
                            'MTN Mobile Money' : 'Airtel Money' }}</p>
                    </div>

                    <div class="flex flex-col space-y-2">
                        <span class="text-gray-500">Umubare w'Amafaranga</span>
                        <span class="text-2xl font-bold text-blue-700">{{ totalAmount }} RWF</span>
                    </div>

                    <button @click="() => { showThankYou = false; resetFormData(); }"
                        class="mt-6 w-full bg-gray-200 text-gray-800 py-3 rounded-lg font-medium hover:bg-gray-300 transition">
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
