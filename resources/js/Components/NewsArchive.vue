<script setup>
import imagePath from '@/lib/image';

const props = defineProps({
    archiveNews: {
        type: Array,
        default: () => [
            // {
            //     id: 5,
            //     title: 'Women\'s League Final Results',
            //     description: 'The women\'s football league concluded with an exciting final match between the top teams.',
            //     image: '/img/news/archive1.jpg',
            //     date: 'April 15, 2025',
            // },
            // {
            //     id: 6,
            //     title: 'Football Federation Announces New Sponsorship',
            //     description: 'A major financial boost for Rwandan football as a new sponsorship deal is announced.',
            //     image: '/img/news/archive2.jpg',
            //     date: 'April 10, 2025',
            // },
            // {
            //     id: 7,
            //     title: 'International Friendly Match Announced',
            //     description: 'Rwanda to play international friendly against neighboring country next month.',
            //     image: '/img/news/archive3.jpg',
            //     date: 'April 5, 2025',
            // },

        ]
    }
});

</script>

<template>
    <div id="archive" class="bg-gray-50 py-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

            <div class="text-center mb-8">
                <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                    Ububiko bw'Amakuru
                </h2>
                <p class="mt-2 text-lg text-gray-500">
                    Reba amakuru n'ibikorwa byacu byashize
                </p>
            </div>

            <!-- News Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                <div v-for="item in archiveNews" :key="item.id"
                    class="bg-white rounded-lg overflow-hidden shadow-md transform transition-transform hover:scale-105">
                    <div class="relative">
                        <div v-if="!item.image.includes('/api/placeholder')" class="h-48 w-full bg-gray-200">
                            <img :src="imagePath(item.image)" :alt="item.title" class="h-full w-full object-cover" />
                        </div>
                        <div v-else class="h-48 w-full bg-gray-200 flex items-center justify-center">
                            <div class="text-gray-400">Image Placeholder</div>
                        </div>
                    </div>

                    <div class="p-5">
                        <div class="text-gray-500 text-sm mb-1">{{ item.date }}</div>
                        <h3 class="text-xl font-bold mb-2 text-gray-900">{{ item.title }}</h3>
                        <p class="text-gray-600 mb-4 line-clamp-2">{{ item.description }}</p>
                        <a href="#" class="text-sky-500 hover:text-sky-700 font-medium inline-flex items-center">
                            Read more
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" fill="none" viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M9 5l7 7-7 7" />
                            </svg>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Empty State -->
            <div v-if="archiveNews.length === 0" class="text-center py-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 mx-auto text-gray-400" fill="none"
                    viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                        d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z" />
                </svg>
                <h3 class="mt-2 text-lg font-medium text-gray-900">Nta makuru yabonetse</h3>
                <p class="mt-1 text-gray-500">Nta makuru ari muri iki cyiciro kuri ubu.</p>

            </div>
        </div>
    </div>
</template>
