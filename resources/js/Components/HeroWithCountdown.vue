<template>
    <div class="relative text-center py-10 md:py-20 bg-gradient-to-r from-sky-800 to-sky-950 overflow-hidden"
        :style="{ height: ['200px', '300px', '400px', '550px'][props.responsiveHeight || 3] || props.fixedHeight || '550px' }">
        <!-- Background image with overlay -->
        <div class="absolute inset-0 z-0">
            <div class="absolute inset-0 bg-black opacity-55"></div>
            <img :src="imagePath('/amahoro-stadium.jpg')" alt="Rwanda Premier League"
                class="w-full h-full object-cover" />
        </div>

        <div class="relative z-10 flex flex-col justify-center h-full">
            <div class="max-w-sm sm:max-w-lg md:max-w-2xl lg:max-w-3xl mx-auto px-4">
                <div class="animate-fade-in-down">
                    <h1 class="text-3xl sm:text-4xl md:text-5xl lg:text-7xl font-extrabold text-white mb-2 md:mb-4">
                        Rwanda Premier League Awards 2025
                    </h1>
                    <p class="text-sm sm:text-base md:text-lg text-sky-200 mb-4">
                        Tora Umukinnyi | Umutoza | Igitego byaranze Umwaka w'Imikino wa 2024/2025 Muri Rwanda Premier
                        League.
                    </p>
                </div>

                <!-- Countdown Timer -->
                <div class="mt-4 md:mt-6 animate-fade-in-up">
                    <p class="text-base md:text-lg font-semibold text-white mb-3">Bizarangira</p>
                    <div class="flex justify-center">
                        <div class="grid grid-cols-4 gap-2 md:gap-4">
                            <!-- Days -->
                            <div
                                class="bg-white bg-opacity-10 backdrop-filter backdrop-blur-lg rounded-lg px-2 py-2 md:px-4 md:py-3 text-center">
                                <div class="text-xl md:text-3xl lg:text-4xl font-bold text-white mb-0">{{ timeLeft.days
                                }}</div>
                                <div class="text-xs text-sky-200 uppercase tracking-wider">Iminsi</div>
                            </div>

                            <!-- Hours -->
                            <div
                                class="bg-white bg-opacity-10 backdrop-filter backdrop-blur-lg rounded-lg px-2 py-2 md:px-4 md:py-3 text-center">
                                <div class="text-xl md:text-3xl lg:text-4xl font-bold text-white mb-0">{{ timeLeft.hours
                                }}</div>
                                <div class="text-xs text-sky-200 uppercase tracking-wider">Amasaha</div>
                            </div>

                            <!-- Minutes -->
                            <div
                                class="bg-white bg-opacity-10 backdrop-filter backdrop-blur-lg rounded-lg px-2 py-2 md:px-4 md:py-3 text-center">
                                <div class="text-xl md:text-3xl lg:text-4xl font-bold text-white mb-0">{{
                                    timeLeft.minutes }}</div>
                                <div class="text-xs text-sky-200 uppercase tracking-wider">Iminita</div>
                            </div>

                            <!-- Seconds -->
                            <div
                                class="bg-white bg-opacity-10 backdrop-filter backdrop-blur-lg rounded-lg px-2 py-2 md:px-4 md:py-3 text-center">
                                <div class="text-xl md:text-3xl lg:text-4xl font-bold text-white mb-0">{{
                                    timeLeft.seconds }}</div>
                                <div class="text-xs text-sky-200 uppercase tracking-wider">Amasegonda</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-6 md:mt-8 flex flex-wrap justify-center gap-2 md:gap-4 animate-fade-in-up">
                    <div
                        class="w-full md:w-auto flex flex-col md:flex-row justify-center md:space-x-4 space-y-3 md:space-y-0">

                        <button @click="scrollToCategories"
                            class="flex items-center justify-center px-5 md:px-8 py-2 md:py-3 border border-transparent text-sm font-medium rounded-md text-white bg-sky-600 hover:bg-sky-700 md:text-lg shadow-lg transition-all duration-300 hover:scale-105">
                            Tora nonaha
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 md:h-5 md:w-5 ml-2"
                                viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd"
                                    d="M16.707 10.293a1 1 0 010 1.414l-6 6a1 1 0 01-1.414 0l-6-6a1 1 0 111.414-1.414L9 14.586V3a1 1 0 012 0v11.586l4.293-4.293a1 1 0 011.414 0z"
                                    clip-rule="evenodd" />
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import imagePath from '@/lib/image';

// Define props with defaults
const props = defineProps({
    responsiveHeight: {
        type: Number,
        default: 3 // Index in the height array [200px, 300px, 400px, 550px]
    },
    fixedHeight: {
        type: String,
        default: null // Override responsive height if provided
    },
    votePrice: {
        type: Number,
        default: 200
    },
    targetDate: {
        type: Date,
        default: () => {
            // Default to 45 days from now if not provided
            const date = new Date();
            date.setDate(date.getDate() + 45);
            return date;
        }
    }
});

// Reactive state
const endDate = ref(props.targetDate);
const timerId = ref(null);
const timeLeft = ref({
    days: '45',
    hours: '12',
    minutes: '34',
    seconds: '56'
});

// Methods
const calculateTimeLeft = () => {
    const now = new Date();
    const difference = endDate.value.getTime() - now.getTime();

    if (difference <= 0) {
        // Timer has ended
        clearInterval(timerId.value);
        timeLeft.value = {
            days: '00',
            hours: '00',
            minutes: '00',
            seconds: '00'
        };
        return;
    }

    // Calculate remaining time
    const days = Math.floor(difference / (1000 * 60 * 60 * 24));
    const hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((difference % (1000 * 60)) / 1000);

    // Update state with padded numbers
    timeLeft.value = {
        days: String(days).padStart(2, '0'),
        hours: String(hours).padStart(2, '0'),
        minutes: String(minutes).padStart(2, '0'),
        seconds: String(seconds).padStart(2, '0')
    };
};

const scrollToCategories = () => {
    const categoriesSection = document.getElementById('categories');
    if (categoriesSection) {
        categoriesSection.scrollIntoView({ behavior: 'smooth' });
    }
};

// Lifecycle hooks
onMounted(() => {
    // Calculate initial time
    calculateTimeLeft();

    // Update every second
    timerId.value = setInterval(calculateTimeLeft, 1000);
});

onBeforeUnmount(() => {
    // Clean up timer when component is destroyed
    if (timerId.value) {
        clearInterval(timerId.value);
    }
});
</script>

<style scoped>
.animate-fade-in-down {
    animation: fadeInDown 1s ease-out forwards;
}

.animate-fade-in-up {
    animation: fadeInUp 1s ease-out forwards;
    animation-delay: 0.3s;
    opacity: 0;
}

@keyframes fadeInDown {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>
