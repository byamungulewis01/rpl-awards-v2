<script setup>
import { ref } from 'vue';
import imagePath from '@/lib/image';
import { Head, } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';


const props = defineProps(
    {
        categories: Array,
    }
)

// State management for categories, candidates and votes
const categories = ref(props.categories || []);
const loading = ref(false);
const selectedCandidate = ref(null);
const selectedCategory = ref(null);
const showCandidateDialog = ref(false);
const voteError = ref(null); // Add this to track vote errors
const showZoomedImage = ref(false);
const zoomedImageSrc = ref('');
const zoomedImageVotes = ref(0);

// Set default category if available
if (categories.value.length > 0) {
    selectedCategory.value = categories.value[0];
}

const handleCategorySelect = (category) => {
    selectedCategory.value = category;
    selectedCandidate.value = null;
};

const handleCandidateSelect = (candidate) => {
    selectedCandidate.value = candidate;
    voteError.value = null; // Clear any previous errors
    showCandidateDialog.value = true;
};

const zoomImage = (imageSrc, votes, event) => {
    event.stopPropagation();
    zoomedImageSrc.value = imageSrc;
    zoomedImageVotes.value = votes;
    showZoomedImage.value = true;
};

const closeZoom = () => {
    showZoomedImage.value = false;
    zoomedImageSrc.value = '';
    zoomedImageVotes.value = 0;
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
                    <div v-if="selectedCategory" class="grid grid-cols-1 sm:grid-cols-4 lg:grid-cols-8 gap-6">
                        <template v-if="selectedCategory.candidates && selectedCategory.candidates.length > 0">
                            <div v-for="candidate in selectedCategory.candidates" :key="candidate.id" :class="`bg-white rounded-xl shadow-md overflow-hidden transform transition-all duration-300 hover:shadow-xl cursor-pointer ${selectedCandidate?.id === candidate.id
                                ? 'ring-4 ring-sky-500 scale-105'
                                : 'hover:-translate-y-1'
                                }`" @click="handleCandidateSelect(candidate)">
                                <div class="relative">
                                    <div class="bg-sky-50 relative">
                                        <img :src="imagePath(`/${candidate.image}`)" :alt="candidate.name"
                                            class="w-full h-full object-cover" @click.stop="zoomImage(imagePath(`/${candidate.image}`), candidate.votes_count, $event)" />
                                        <div
                                            class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black via-black/10 to-transparent h-32">
                                        </div>
                                        <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black via-black/10 to-transparent h-32">
                                            <p class="text-white text-center text-3xl font-bold">{{ candidate.votes_count }}</p>
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

        <!-- Image Zoom Modal -->
        <div v-if="showZoomedImage" @click="closeZoom" class="fixed inset-0 bg-black bg-opacity-75 flex items-center justify-center z-50">
            <div class="max-w-4xl max-h-[90vh] relative">
                <div class="absolute bottom-4 mx-4 right-0 text-right rounded-md border-2 border-white p-2">
                    <p class="text-white text-2xl font-bold">Votes: {{ zoomedImageVotes }}</p>
                </div>
                <img :src="zoomedImageSrc" class="max-w-full max-h-[90vh] object-contain" />
                <button @click="closeZoom" class="absolute top-4 right-4 text-white hover:text-gray-300">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
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
