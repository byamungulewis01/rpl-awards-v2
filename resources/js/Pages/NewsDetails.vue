<template>

    <Head :title="news.title" />
    <PublicLayout title="Vote for the best in Rwandan football">
        <div class="min-h-screen bg-gray-50">


            <!-- Main Content -->
            <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                <!-- Article Header -->
                <div class="mb-8">
                    <h1 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
                        {{ news.title }}
                    </h1>

                </div>

                <!-- Featured Image -->
                <div class="relative h-96 mb-8 rounded-xl overflow-hidden">
                    <img :src="imagePath(news.image)" :alt="news.title" class="w-full h-full object-cover" />
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
                </div>

                <!-- Article Content -->
                <div class="prose prose-lg max-w-none prose-headings:text-gray-900 prose-headings:font-bold prose-h1:text-4xl prose-h2:text-3xl prose-h3:text-2xl prose-h4:text-xl prose-p:text-gray-700 prose-p:leading-relaxed prose-a:text-sky-600 prose-a:no-underline hover:prose-a:text-sky-700 prose-strong:font-bold prose-strong:text-gray-900 prose-em:italic prose-blockquote:border-l-4 prose-blockquote:border-gray-300 prose-blockquote:pl-4 prose-blockquote:italic prose-blockquote:text-gray-600 prose-ul:ml-4 prose-ul:list-disc prose-ul:list-outside prose-ol:ml-4 prose-ol:list-decimal prose-ol:list-outside prose-li:text-gray-700 prose-li:pl-2 prose-li:my-1 prose-img:rounded-lg prose-img:shadow-md prose-code:text-sm prose-code:bg-gray-100 prose-code:px-1 prose-code:py-0.5 prose-code:rounded prose-pre:bg-gray-800 prose-pre:text-gray-100 prose-pre:p-4 prose-pre:rounded-lg prose-table:border-collapse prose-th:border prose-th:border-gray-300 prose-th:bg-gray-100 prose-th:p-2 prose-td:border prose-td:border-gray-300 prose-td:p-2">
                    <div class="text-gray-700" v-html="news.long_description"></div>
                </div>

                <!-- Share Section -->
                <div class="mt-12 pt-8 border-t border-gray-200">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Sangira</h3>
                    <div class="flex space-x-4">
                        <button @click="shareOnFacebook" class="text-blue-600 hover:text-blue-700">
                            <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3z"></path>
                            </svg>
                        </button>
                        <button @click="shareOnTwitter" class="text-sky-500 hover:text-sky-600">
                            <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                                <path
                                    d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z">
                                </path>
                            </svg>
                        </button>
                        <button @click="shareOnWhatsApp" class="text-green-600 hover:text-green-700">
                            <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                                <path
                                    d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z">
                                </path>
                            </svg>
                        </button>
                    </div>
                </div>


            </div>
        </div>
    </PublicLayout>
</template>

<script setup>
import { router } from '@inertiajs/vue3';
import imagePath from '@/lib/image';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import { Head } from '@inertiajs/vue3';


const props = defineProps({
    news: {
        type: Object,
        required: true
    },
    relatedNews: {
        type: Array,
        default: () => []
    }
});

const formatDate = (date) => {
    if (!date) return '';
    return new Date(date).toLocaleDateString('rw-RW', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
};

const goBack = () => {
    router.visit('/news');
};

const navigateToNews = (id) => {
    router.visit(`/news/${id}`);
};

const shareOnFacebook = () => {
    const url = encodeURIComponent(window.location.href);
    window.open(`https://www.facebook.com/sharer/sharer.php?u=${url}`, '_blank');
};

const shareOnTwitter = () => {
    const text = encodeURIComponent(props.news.title);
    const url = encodeURIComponent(window.location.href);
    window.open(`https://twitter.com/intent/tweet?text=${text}&url=${url}`, '_blank');
};

const shareOnWhatsApp = () => {
    const text = encodeURIComponent(`${props.news.title} ${window.location.href}`);
    window.open(`https://wa.me/?text=${text}`, '_blank');
};
</script>

<style scoped>
.line-clamp-2 {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
</style>
