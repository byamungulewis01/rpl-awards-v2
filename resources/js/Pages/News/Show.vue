<script setup>
import { Head } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import imagePath from '@/lib/image';

const props = defineProps({
    article: {
        type: Object,
        required: true
    }
});
</script>

<template>
    <Head :title="article.title" />
    <PublicLayout :title="article.title">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <!-- Article Header -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-4">{{ article.title }}</h1>
                <div class="text-gray-500 text-sm">
                    {{ new Date(article.created_at).toLocaleDateString('rw-RW', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric'
                    }) }}
                </div>
            </div>

            <!-- Featured Image -->
            <div class="mb-8 rounded-xl overflow-hidden">
                <img :src="imagePath(article.image)" :alt="article.title" class="w-full h-auto" />
            </div>

            <!-- Article Content -->
            <div class="prose prose-lg max-w-none">
                <div class="whitespace-pre-line text-gray-700">
                    {{ article.long_description }}
                </div>
            </div>

            <!-- Back Button -->
            <div class="mt-12">
                <Link :href="route('news.index')"
                      class="inline-flex items-center text-sky-600 hover:text-sky-700">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M9.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L7.414 9H15a1 1 0 110 2H7.414l2.293 2.293a1 1 0 010 1.414z" clip-rule="evenodd" />
                    </svg>
                    Garuka ku Makuru
                </Link>
            </div>
        </div>
    </PublicLayout>
</template>
