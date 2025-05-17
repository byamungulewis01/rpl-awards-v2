<script setup>
import { ref, onMounted } from 'vue';
import imagePath from '@/lib/image';

const sponsors = [
    {
        name: 'Skol Malt',
        logo: 'sponsers/skol-malt.png'
    },
    {
        name: 'Rwanda Airports',
        logo: 'sponsers/rwanda-airports.png'
    },
    {
        name: 'Be One Gin',
        logo: 'sponsers/be-one-gin.png'
    },
    {
        name: 'Rwanda Forestic Institute',
        logo: 'sponsers/rwanda-forestic.png'
    },
    {
        name: 'Kwesa',
        logo: 'sponsers/kwesa.png'
    },
    {
        name: 'Start Time',
        logo: 'sponsers/start-times.png'
    },
    {
        name: 'Centrika',
        logo: 'sponsers/centrika.png'
    },
    {
        name: 'Allione',
        logo: 'sponsers/allione.png'
    },

];

const sliderRef = ref(null);
const isHovered = ref(false);

// Duplicate sponsors for infinite scroll effect
const duplicatedSponsors = ref([...sponsors, ...sponsors]);

onMounted(() => {
    if (sliderRef.value) {
        const slider = sliderRef.value;
        const slideWidth = slider.offsetWidth / 2;
        slider.scrollLeft = 0;
    }
});

const handleScroll = () => {
    if (!sliderRef.value || isHovered.value) return;

    const slider = sliderRef.value;
    if (slider.scrollLeft >= slider.scrollWidth / 2) {
        slider.scrollLeft = 0;
    }
};
</script>

<template>
    <div class="bg-white py-12">
        <div class="max-w-[85rem] mx-auto px-4 sm:px-6 lg:px-8">
            <h2 class="text-3xl font-extrabold text-gray-900 text-center mb-8">
                Abaterankunga
            </h2>

            <div
                ref="sliderRef"
                class="relative overflow-hidden"
                @mouseenter="isHovered = true"
                @mouseleave="isHovered = false"
            >
                <div
                    class="flex animate-scroll"
                    :class="{ 'pause-animation': isHovered }"
                >
                    <div
                        v-for="(sponsor, index) in duplicatedSponsors"
                        :key="index"
                        class="flex-shrink-0 px-4"
                    >
                        <div class="bg-white rounded-lg p-4 shadow-sm hover:shadow-md transition-shadow duration-300">
                            <img
                                :src="imagePath(`/${sponsor.logo}`)"
                                :alt="sponsor.name"
                                class="h-16 w-auto object-contain"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.animate-scroll {
    animation: scroll 30s linear infinite;
    width: max-content;
}

.pause-animation {
    animation-play-state: paused;
}

@keyframes scroll {
    0% {
        transform: translateX(0);
    }
    100% {
        transform: translateX(-50%);
    }
}
</style>
