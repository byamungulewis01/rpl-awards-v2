<script setup>
import { ref, computed, watch } from 'vue';
import imagePath from '@/lib/image'; // Assuming this is your image path helper
import { Head } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import HeroWithCountdown from '@/Components/HeroWithCountdown.vue';
import FaqComponent from '@/Components/FaqComponent.vue';


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
const showThankYou = ref(false);
const selectedLeague = ref('men'); // Default to men's league
const selectedCategory = ref(null);

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
    // Reset selection and votes when changing category
    selectedCandidate.value = null;
    voteCount.value = 1;
};

const handleVoteChange = (value) => {
    // Limit min vote to 1 and max to 100
    const newCount = Math.min(Math.max(1, voteCount.value + value), 100);
    voteCount.value = newCount;
};

const handleCandidateSelect = (candidate) => {
    selectedCandidate.value = candidate;
    // Add scroll to vote counter section
    setTimeout(() => {
        document.getElementById('vote-counter')?.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }, 100);
};

const handleProceedToPayment = () => {
    showPaymentModal.value = true;
};

const handlePaymentSubmit = (e) => {
    e.preventDefault();
    paymentLoading.value = true;

    setTimeout(() => {
        showPaymentModal.value = false;
        showThankYou.value = true;
        paymentLoading.value = false;
    }, 2000); // 2000ms = 2 seconds
};


// const handlePaymentSubmit = (e) => {
//     e.preventDefault();
//     loading.value = true;

//     // Submit the vote to the backend using Inertia
//     Inertia.post(route('votes.store'), {
//         candidate_id: selectedCandidate.value.id,
//         category_id: selectedCategory.value.id,
//         vote_count: voteCount.value,
//         amount: totalAmount.value,
//         phone_number: phoneNumber.value,
//         payment_method: paymentMethod.value
//     }, {
//         onSuccess: () => {
//             loading.value = false;
//             showPaymentModal.value = false;
//             showThankYou.value = true;

//             // Reset after thank you message
//             setTimeout(() => {
//                 showThankYou.value = false;
//                 selectedCandidate.value = null;
//                 voteCount.value = 1;
//             }, 5000);
//         },
//         onError: (errors) => {
//             loading.value = false;
//             // Handle errors here
//             console.error(errors);
//         }
//     });

// };

const handleCloseModal = () => {
    showPaymentModal.value = false;
};

const scrollToCategories = () => {
    document.getElementById('categories')?.scrollIntoView({ behavior: 'smooth' });
};
</script>

<template>

    <Head title="Voting" />
    <PublicLayout title="Vote for the best in Rwandan football">

        <HeroWithCountdown :targetDate="new Date('2025-06-30')" :votePrice="200" />

        <!-- How it works -->
        <div class="bg-white py-12">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center">
                    <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                        How it works
                    </h2>
                    <p class="mt-4 text-lg text-gray-500">
                        Vote for your favorite candidates in three simple steps
                    </p>
                </div>

                <div class="mt-10">
                    <div class="grid grid-cols-1 gap-8 md:grid-cols-3">
                        <div
                            class="bg-gray-50 p-6 rounded-lg shadow-md hover:shadow-lg transition duration-300 transform hover:-translate-y-1">
                            <div
                                class="flex justify-center items-center h-12 w-12 rounded-md bg-sky-500 text-white mx-auto">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
                                </svg>
                            </div>
                            <h3 class="mt-3 text-lg font-medium text-gray-900 text-center">Choose Your Category</h3>
                            <p class="mt-2 text-base text-gray-500 text-center">
                                Select from multiple award categories for men's and women's leagues
                            </p>
                        </div>

                        <div
                            class="bg-gray-50 p-6 rounded-lg shadow-md hover:shadow-lg transition duration-300 transform hover:-translate-y-1">
                            <div
                                class="flex justify-center items-center h-12 w-12 rounded-md bg-sky-500 text-white mx-auto">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                </svg>
                            </div>
                            <h3 class="mt-3 text-lg font-medium text-gray-900 text-center">Select Your Candidate
                            </h3>
                            <p class="mt-2 text-base text-gray-500 text-center">
                                Browse through the nominees and vote for your favorite
                            </p>
                        </div>

                        <div
                            class="bg-gray-50 p-6 rounded-lg shadow-md hover:shadow-lg transition duration-300 transform hover:-translate-y-1">
                            <div
                                class="flex justify-center items-center h-12 w-12 rounded-md bg-sky-500 text-white mx-auto">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                            </div>
                            <h3 class="mt-3 text-lg font-medium text-gray-900 text-center">Pay & Submit</h3>
                            <p class="mt-2 text-base text-gray-500 text-center">
                                Choose your vote quantity and pay securely with MTN or Airtel Money
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Categories and Voting Section -->
        <div id="categories" class="bg-gray-50 py-12">
            <div class="max-w-[85rem] mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-6">
                    <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                        Award Categories
                    </h2>
                    <p class="mt-4 text-lg text-gray-500">
                        Select a category to start voting
                    </p>
                </div>

                <!-- League Filter Tabs -->
                <div class="mb-8 flex justify-center">
                    <div class="inline-flex bg-white rounded-lg p-1 shadow">
                        <button @click="handleLeagueSelect('men')" :class="`px-4 py-2 rounded-md text-sm font-medium transition-all duration-300 ${selectedLeague === 'men'
                            ? 'bg-sky-500 text-white'
                            : 'text-gray-500 hover:text-sky-700'}`">
                            MEN
                        </button>

                        <button @click="handleLeagueSelect('women')" :class="`px-4 py-2 rounded-md text-sm font-medium transition-all duration-300 ${selectedLeague === 'women'
                            ? 'bg-pink-500 text-white'
                            : 'text-gray-500 hover:text-pink-700'}`">
                            WOMEN
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
                        <div v-for="candidate in selectedCategory.candidates" :key="candidate.id" :class="`bg-white rounded-xl shadow-md overflow-hidden transform transition-all duration-300 hover:shadow-xl ${selectedCandidate?.id === candidate.id
                            ? 'ring-4 ring-sky-500 scale-105'
                            : 'hover:-translate-y-1'
                            }`" @click="handleCandidateSelect(candidate)">
                            <div class="relative">
                                <div class=" bg-sky-50 relative">
                                    <img :src="imagePath(`/${candidate.image}`)" :alt="candidate.name"
                                        class="w-full h-full object-cover" />
                                    <div
                                        class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black via-black/10 to-transparent h-32">
                                    </div>

                                    <!-- Candidate info on image -->
                                    <div class="absolute bottom-0 left-0 w-full p-4 text-white">
                                        <div class="bg-sky-700 text-white text-xs px-2 py-1 rounded float-end">Via USSD <strong>*192*{{ candidate.code }}#</strong></div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div v-else class="text-center py-8 bg-white rounded-lg shadow-sm">
                        <div class="text-gray-500 text-lg">Please select a category to view candidates</div>
                    </div>
                </template>
            </div>
        </div>

        <!-- Vote Counter Section -->
        <div v-if="selectedCandidate" id="vote-counter" class="bg-white py-12 border-t border-gray-200">
            <div class="max-w-3xl mx-auto px-4">
                <div class="bg-sky-50 rounded-xl p-6 shadow-lg">
                    <div class="text-center mb-6">
                        <h3 class="text-2xl font-bold text-gray-900">Your Selection</h3>
                        <p class="text-sky-600 font-medium">{{ selectedCategory?.name }}</p>
                    </div>

                    <div class="flex items-center justify-center gap-6 mb-8">
                        <div>
                            <div class="text-xl font-bold text-gray-900">{{ selectedCandidate.name }}</div>
                            <div class="text-gray-600">{{ selectedCandidate.team }}</div>
                        </div>
                    </div>

                    <div
                        class="flex flex-col md:flex-row items-center justify-between bg-white p-4 rounded-lg shadow mb-6">
                        <div class="mb-4 md:mb-0">
                            <span class="block text-sm text-gray-500 mb-1">Number of votes</span>
                            <div class="flex items-center">
                                <button @click="handleVoteChange(-1)"
                                    class="flex items-center justify-center w-10 h-10 rounded-full bg-sky-100 text-sky-700 hover:bg-sky-200 transition">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20"
                                        fill="currentColor">
                                        <path fill-rule="evenodd" d="M3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                                            clip-rule="evenodd" />
                                    </svg>
                                </button>

                                <div class="w-16 mx-3 text-center">
                                    <span class="text-2xl font-bold text-sky-700">{{ voteCount }}</span>
                                </div>

                                <button @click="handleVoteChange(1)"
                                    class="flex items-center justify-center w-10 h-10 rounded-full bg-sky-100 text-sky-700 hover:bg-sky-200 transition">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20"
                                        fill="currentColor">
                                        <path fill-rule="evenodd"
                                            d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z"
                                            clip-rule="evenodd" />
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <div>
                            <span class="block text-sm text-gray-500 mb-1">Total amount</span>
                            <div class="text-2xl font-bold text-sky-700">{{ totalAmount }} RWF</div>
                        </div>
                    </div>

                    <div class="text-center">
                        <button @click="handleProceedToPayment"
                            class="px-8 py-3 bg-sky-500 text-white font-medium rounded-lg shadow-md hover:bg-sky-600 transition-all duration-300 transform hover:scale-105">
                            Proceed to Payment
                        </button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Contact Us Section -->
        <div id="contact-us" class="bg-white py-12 border-t border-gray-200">
            <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-8">
                    <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                        Contact Us
                    </h2>
                    <p class="mt-4 text-lg text-gray-500">
                        Have questions about voting or need assistance? Reach out to our support team.
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
                            <h3 class="text-lg font-medium text-gray-900 text-center mb-2">Email</h3>
                            <p class="text-gray-600 text-center">support@rwandapl.rw</p>
                            <div class="mt-4 text-center">
                                <a href="mailto:support@rwandapl.rw"
                                    class="text-sky-600 hover:text-sky-800 font-medium">Send
                                    Email</a>
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
                            <h3 class="text-lg font-medium text-gray-900 text-center mb-2">Phone</h3>
                            <p class="text-gray-600 text-center">+250 788 123 456</p>
                            <div class="mt-4 text-center">
                                <a href="tel:+250788123456" class="text-sky-600 hover:text-sky-800 font-medium">Call
                                    Now</a>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Form - Left side on desktop, bottom on mobile -->
                    <div class="w-full lg:w-2/3 bg-white rounded-lg shadow-md p-6 md:p-8">
                        <h3 class="text-xl font-bold text-gray-900 mb-6">Send us a message</h3>
                        <form>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                <div>
                                    <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Your
                                        Name</label>
                                    <input type="text" id="name" name="name"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-sky-500 focus:border-sky-500"
                                        placeholder="Enter your name" required>
                                </div>
                                <div>
                                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Your
                                        Email</label>
                                    <input type="email" id="email" name="email"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-sky-500 focus:border-sky-500"
                                        placeholder="Enter your email" required>
                                </div>
                            </div>
                            <div class="mb-6">
                                <label for="subject"
                                    class="block text-sm font-medium text-gray-700 mb-1">Subject</label>
                                <input type="text" id="subject" name="subject"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-sky-500 focus:border-sky-500"
                                    placeholder="Enter subject" required>
                            </div>
                            <div class="mb-6">
                                <label for="message"
                                    class="block text-sm font-medium text-gray-700 mb-1">Message</label>
                                <textarea id="message" name="message" rows="4"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-sky-500 focus:border-sky-500"
                                    placeholder="Your message..." required></textarea>
                            </div>
                            <div>
                                <button type="submit"
                                    class="w-full md:w-auto px-6 py-3 bg-sky-500 text-white font-medium rounded-md shadow hover:bg-sky-600 transition">Send
                                    Message</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <FaqComponent />
        <!-- Payment Modal -->
        <div v-if="showPaymentModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
            <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4 overflow-hidden animate-scale-in">
                <div class="bg-sky-500 px-6 py-4 flex justify-between items-center">
                    <h3 class="text-lg font-medium text-white">Payment Details</h3>
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
                                <div class="text-gray-600">Candidate</div>
                                <div class="font-medium">{{ selectedCandidate?.name }}</div>
                            </div>
                            <div>
                                <div class="text-gray-600">Votes</div>
                                <div class="font-medium text-right">{{ voteCount }}</div>
                            </div>
                        </div>
                        <div class="flex justify-between items-center mb-4 pb-4 border-b border-gray-200">
                            <div class="text-gray-800 font-medium">Total Amount</div>
                            <div class="text-xl font-bold text-sky-600">{{ totalAmount }} RWF</div>
                        </div>
                    </div>

                    <form @submit="handlePaymentSubmit">
                        <div class="mb-6">
                            <label class="block text-gray-700 mb-2">Select Payment Method</label>
                            <div class="flex gap-4">
                                <div @click="paymentMethod = 'mtn'" :class="`flex-1 border rounded-lg p-4 cursor-pointer ${paymentMethod === 'mtn' ? 'border-sky-500 bg-sky-50' : 'border-gray-300'
                                    }`">
                                    <div class="flex items-center justify-center h-8 mb-2">
                                        <div class="bg-yellow-500 text-yellow-900 font-bold px-2 py-1 rounded">MTN
                                        </div>
                                    </div>
                                    <div class="text-center text-sm">MTN Mobile Money</div>
                                </div>

                                <div @click="paymentMethod = 'airtel'" :class="`flex-1 border rounded-lg p-4 cursor-pointer ${paymentMethod === 'airtel' ? 'border-sky-500 bg-sky-50' : 'border-gray-300'
                                    }`">
                                    <div class="flex items-center justify-center h-8 mb-2">
                                        <div class="bg-red-500 text-white font-bold px-2 py-1 rounded">AIRTEL</div>
                                    </div>
                                    <div class="text-center text-sm">Airtel Money</div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-6">
                            <label for="phone" class="block text-gray-700 mb-2">Phone Number</label>
                            <input type="tel" id="phone" placeholder="07X XXX XXXX" v-model="phoneNumber"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-sky-500 focus:border-sky-500"
                                required />
                            <p class="mt-1 text-sm text-gray-500">
                                Enter your {{ paymentMethod === 'mtn' ? 'MTN' : 'Airtel' }} phone number
                            </p>
                        </div>

                        <button type="submit"
                            class="w-full bg-sky-500 text-white py-3 rounded-lg font-medium hover:bg-sky-600 transition"
                            :disabled="paymentLoading">
                            <span v-if="paymentLoading" class="flex items-center justify-center">
                                <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white"
                                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor"
                                        stroke-width="4">
                                    </circle>
                                    <path class="opacity-75" fill="currentColor"
                                        d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"></path>
                                </svg>
                                Processing...
                            </span>
                            <span v-else>Pay {{ totalAmount }} RWF</span>
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Payment Prompt Modal -->
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

                    <h3 class="text-2xl font-bold text-gray-900 mb-2">Payment Pending</h3>
                    <p class="text-gray-600 mb-6">
                        A payment prompt message was sent to your mobile phone <strong>({{ phoneNumber }})</strong>.
                        Please proceed with the payment to complete your vote for <strong>{{ selectedCandidate?.name
                            }}</strong>.
                    </p>

                    <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-6">
                        <p class="text-yellow-800 font-medium">
                            If you didn't receive the prompt message, please dial:
                        </p>
                        <p class="text-lg font-bold text-yellow-900 mt-2">
                            {{ paymentMethod === 'mtn' ? '*182*7*1*PIN#' : '*500*7*1*PIN#' }}
                        </p>
                        <p class="text-xs text-yellow-700 mt-1">
                            Replace PIN with your {{ paymentMethod === 'mtn' ? 'MTN Mobile Money' : 'Airtel Money' }}
                            PIN code
                        </p>
                    </div>

                    <div class="flex flex-col space-y-2">
                        <span class="text-gray-500">Transaction Amount</span>
                        <span class="text-2xl font-bold text-blue-700">{{ totalAmount }} RWF</span>
                    </div>

                    <button @click="() => showThankYou = false"
                        class="mt-6 w-full bg-gray-200 text-gray-800 py-2 rounded-lg font-medium hover:bg-gray-300 transition">
                        Close
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
