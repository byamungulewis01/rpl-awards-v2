<script setup>
import { ref, onMounted } from 'vue';
import { Link } from '@inertiajs/vue3';
import imagePath from '@/lib/image';

const props = defineProps({
    news: {
        type: Array,
        required: true
    }
});

const news = ref(props.news);
</script>

<template>
    <div id="news" class="relative bg-gray-50 py-14">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-8">
                <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                    Amakuru y'irushanwa
                </h2>
            </div>

            <!-- News Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <div v-for="item in news" :key="item.id"
                    class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition-shadow duration-300 h-full">
                    <div class="relative h-48">
                        <img :src="imagePath(item.image)" :alt="item.title" class="w-full h-full object-cover" />
                        <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
                    </div>
                    <div class="p-6">
                        <h3 class="text-xl font-bold text-gray-900 mb-3 line-clamp-2">{{ item.title }}</h3>
                        <p class="text-gray-600 mb-4 line-clamp-3">
                            {{ item.short_description }}
                        </p>
                        <Link :href="route('news.show', item.slug)"
                            class="text-sky-600 hover:text-sky-700 font-medium flex items-center">
                        Soma Byinshi
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-1" viewBox="0 0 20 20"
                            fill="currentColor">
                            <path fill-rule="evenodd"
                                d="M12.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-2.293-2.293a1 1 0 010-1.414z"
                                clip-rule="evenodd" />
                        </svg>
                        </Link>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.line-clamp-2 {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.line-clamp-3 {
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
</style>
