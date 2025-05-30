<script setup>
import { router, Link } from '@inertiajs/vue3';
import imagePath from '@/lib/image';
import { ref } from 'vue';

defineProps({
    title: {
        type: String,
        default: 'Rwanda Premier League Awards 2025',
    },
});

const isMenuOpen = ref(false);

const toggleMenu = () => {
    isMenuOpen.value = !isMenuOpen.value;
};

const closeMenu = () => {
    isMenuOpen.value = false;
};

</script>

<template>
    <header class="bg-white shadow-sm border-b sticky top-0 z-40">
        <div class="max-w-[85rem] mx-auto px-4 py-4 sm:px-6 lg:px-8 flex items-center justify-between">
            <div class="flex items-center space-x-4">
                <Link :href="route('welcome')">
                <img :src="imagePath('/img/RPL-LOGO.png')" alt="Rwanda Premier League" class="h-12" />
                </Link>
                <div>
                    <h1 class="text-2xl font-bold text-blue-600">RPL 2025 Awards</h1>
                    <p class="text-sm text-gray-500">{{ title }}</p>
                </div>
            </div>

            <!-- Desktop Navigation -->
            <!-- <nav class="hidden md:flex items-center space-x-6">
                <Link :href="route('welcome')" class="text-gray-700 hover:text-sky-600 font-medium transition-colors">
                    Ahabanza
                </Link>
                <Link :href="route('welcome') + '#news'" class="text-gray-700 hover:text-sky-600 font-medium transition-colors">
                    Amakuru
                </Link>
                <Link :href="route('welcome') + '#archive'" class="text-gray-700 hover:text-sky-600 font-medium transition-colors">
                    Ububiko
                </Link>
                <Link :href="route('welcome') + '#contact-us'" class="text-gray-700 hover:text-sky-600 font-medium transition-colors">
                    Twandikire
                </Link>
            </nav> -->
            <nav v-if="$page.props.auth?.user && ['inspector', 'admin', 'super_admin'].includes($page.props.auth?.user?.role)"
                class="hidden md:flex items-center space-x-6">
                <Link :href="route('inspector')" class="text-gray-700 hover:text-sky-600 font-medium transition-colors">
                Public Results
                </Link>
                <Link :href="route('results')" class="text-gray-700 hover:text-sky-600 font-medium transition-colors">
                Coach Captain Results
                </Link>
            </nav>

            <!-- Auth / Logo -->
            <div class="hidden md:flex items-center space-x-4">
                <div v-if="$page.props.auth?.user" class="flex items-center space-x-6">
                    <span class="text-sm text-gray-700">Welcome, {{ $page.props.auth?.user?.name || 'User' }}</span>
                    <button class="px-3 py-1 text-sm font-medium bg-red-400 text-white rounded-md hover:bg-red-600"
                        @click="router.post(route('logout'))">
                        Logout
                    </button>
                </div>
                <img v-else :src="imagePath('/img/rpl-awards.png')" alt="RPL Award Logo" class="h-10" />
            </div>

            <!-- Mobile menu button -->
            <template
                v-if="$page.props.auth?.user && ['inspector', 'admin', 'super_admin'].includes($page.props.auth?.user?.role)">
                <div class="md:hidden flex items-center">
                    <button @click="toggleMenu" class="text-gray-700 hover:text-sky-600 focus:outline-none">
                        <svg v-if="!isMenuOpen" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                        <svg v-else xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>
            </template>
        </div>

        <!-- Mobile menu -->
        <template
            v-if="$page.props.auth?.user && ['inspector', 'admin', 'super_admin'].includes($page.props.auth?.user?.role)">
            <div v-if="isMenuOpen"
                class="md:hidden bg-white border-t border-gray-200 absolute w-full shadow-lg animate-fade-in-down z-30">
                <div class="px-4 py-2">
                    <div v-if="$page.props.auth?.user" class="py-3 border-b border-gray-200">
                        <span class="text-sm text-gray-700">Welcome, {{ $page.props.auth?.user?.name || 'User' }}</span>
                        <button
                            class="mt-2 px-3 py-1 text-sm font-medium bg-red-400 text-white rounded-md hover:bg-red-600"
                            @click="router.post(route('logout'))">
                            Logout
                        </button>
                    </div>
                    <div v-if="$page.props.auth?.user && ['inspector', 'admin', 'super_admin'].includes($page.props.auth?.user?.role)"
                        class="flex flex-col space-y-4 py-4">
                        <Link :href="route('inspector')"
                            class="text-gray-700 hover:text-sky-600 font-medium transition-colors">
                        Public Results
                        </Link>
                        <Link :href="route('results')"
                            class="text-gray-700 hover:text-sky-600 font-medium transition-colors">
                        Coach Captain Results
                        </Link>
                    </div>
                    <!-- <div class="flex flex-col space-y-4 py-4">
                         <Link :href="route('welcome')"
                             class="px-2 py-2 text-left text-gray-700 hover:bg-sky-50 hover:text-sky-600 rounded-md transition-colors">
                             Ahabanza
                         </Link>
                         <Link :href="route('news.index')"
                             class="px-2 py-2 text-left text-gray-700 hover:bg-sky-50 hover:text-sky-600 rounded-md transition-colors">
                             Amakuru
                         </Link>
                         <Link :href="route('welcome') + '#archive'"
                             class="px-2 py-2 text-left text-gray-700 hover:bg-sky-50 hover:text-sky-600 rounded-md transition-colors">
                             Ububiko
                         </Link>
                         <Link :href="route('welcome') + '#contact-us'"
                             class="px-2 py-2 text-left text-gray-700 hover:bg-sky-50 hover:text-sky-600 rounded-md transition-colors">
                             Twandikire
                         </Link>
                     </div> -->
                </div>
            </div>
        </template>
    </header>
    <div class="min-h-screen bg-slate-50">
        <main class="">
            <slot />
        </main>
    </div>

    <footer class="bg-gray-800 text-white py-8">
        <div class="max-w-[85rem] mx-auto px-4">
            <div class="flex flex-col md:flex-row justify-between items-center">
                <div class="mb-4 md:mb-0">
                    <div class="flex items-center space-x-4">
                        <img :src="imagePath('/img/rpl-awards-white.png')" alt="Rwanda Premier League" class="h-12" />
                    </div>
                </div>
                <div class="text-center md:text-right">
                    <p class="text-gray-300 text-sm mb-2">© 2025 Rwanda Premier League. All rights reserved.</p>
                    <div class="flex space-x-4 justify-center md:justify-end">
                        <!-- <a href="#" class="text-gray-300 hover:text-white">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round" class="lucide-facebook">
                                <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z">
                                </path>
                            </svg>
                        </a> -->
                        <a href="https://x.com/rplawards" target="_blank" class="text-gray-300 hover:text-white">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round" class="lucide-twitter">
                                <path
                                    d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z">
                                </path>
                            </svg>
                        </a>
                        <a href="https://www.instagram.com/rplawards/" target="_blank"
                            class="text-gray-300 hover:text-white">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round" class="lucide-instagram">
                                <rect width="20" height="20" x="2" y="2" rx="5" ry="5"></rect>
                                <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                                <line x1="17.5" x2="17.51" y1="6.5" y2="6.5"></line>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
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
</style>
