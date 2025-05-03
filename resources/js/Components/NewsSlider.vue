<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import imagePath from '@/lib/image';

const props = defineProps({
    news: {
        type: Array,
        default: () => [
            {
                id: 1,
                title: 'Rwanda Premier League igihe gutanga ibihembo kubakinnyi bitwaye neza',
                description: "Rwanda Premier League (RPL) igiye guhemba abakinnyi bitwaye neza mu mwakaw'imikino wa 2024/2025. Ni ibihembo bigiye gutangwa ku nshuro ya kabiriyikurikiranya nyuma yaho umwaka w'imikino wa 2023/2024 hari hahembwe abakinnyibitwaye neza. \nIbi bihembo bizatangirwa mu birori byiza bibereye ijisho bizitabirwa n'abakinnyi, abayobozi b'amakipe, abatoza, abayobora amashyirahamwe y'imikino itandukanye mu Rwanda, abayobozi mu nego za leta zitandukanye, abikorera ndetse n'itangazamakuru. Abakinnyi bazahembwa bazaba bari mu byiciro bitandukanye ariby:\n- Umukinnyi mwiza wa shampiyona\n- Umukinnyi watsinze ibitego byinshi\n- Umukinnyi mwiza ukiri muto\n- Umunyezamu mwiza\n- Igitego cyiza\n- Abakinnyi 11 beza ba shampiyona\n- Umutoza mwiza\n- Umusifuzi mwiza\nUsibye ibi byiciro bizahembwa mubagabo, uyu mwaka hazanahembwa abakinnyi bezamu cyiciro cy'abari n'abategarugori mu rwego rwo kuzamura urwego rw'irushanwaryabo. Muri iki kiciro hazahembwa:\n- Umukinnyi mwiza wa shampiyona\n- Umukinnyi watsinze ibitego byinshi\n- Umutoza mwiza\n- Umusifuzi mwiza. \nBiteganyijwe ko abasaga 500 aribo bazitabira ibi birori biteganyijwe kuzaba ku itari ya30 Gicurasi 2025.",
                image: '/img/awards1.jpg'
            },
            {
                id: 2,
                title: "Abakunzi b'umupira w'amaguru bazagira uruhare mu gutora abakinnyi bazahembwa muri RPL Awards 2025",
                description: "Mu birori byo guhemba abakinnyi bitwaye neza mu mwaka w'imikino wa 2024/2025 byiswe Rwanda Premier League Awards 2025, abakunzi b'umupira w'amaguru mu Rwanda ndetse no ku isi hose nabo bazagira uruhare mukwitorera abazahabwa ibhembobitandukanye. \nBitandukanye n'umwaka ushize aho akana k'impuguke ariko kagize uruhare 100% mu gutora abatsindiye ibihembo mu mwaka w'imikino wa 2023/2024, kuri iyi nshuro, abafana babyifuza bazatora hakoreshejwe uburyo bw'ikoranabuhanga banyuze ku rubugarwa www.rplawards.rw ndetse no kuri USSD bazagira uruhare mu gutora abakinnyi mu byiciro byose bihatanirwa. \nAmajwi y'abakunzi b'umupira azahesha uzatsinda amahirwe ku kigero cya 15%. Ibibyakozwe mu rwego rwo kugira ngo abafana nabo bihitiremo nk'abakurikiranye imikinoya shampiyona. \nMu rwego rwo kugabanya amarangamutima muri iki gikorwa hashyizweho amafarangamake atuma utora aha agaciro iki gikorwa kandi agahesha umukinnyi koko abonaubikwiriye.\nBiteganyijwe ko abasaga 500 aribo bazitabira ibi birori biteganyijwe kuzaba ku itari ya30 Gicurasi 2025 aho hazahembwa ibyiciro 9 mu bagabo ndetse na 4 mu barin'abategarugori.",
                image: '/img/fans.jpeg'
            },
            {
                id: 3,
                title: 'Rwanda Premier League Awards 2025 izagaragaramo abahanzi',
                description: "Mu birori byo guhemba abakinnyi bitwaye neza muri uyu mwaka w'imikino wa 2024/2025, hazagaragaramo abahanzi bazasusurutsa abazaba bitabiriye ibi birori. \nNi ibirori bizarangwa no guhuza cyane umuco nyarwanda aho hazitabira itorero gakondo, hazanitabira kandi abana bazagaragaza impano zabo ndetse n'amwe mumazi y'abahanzibakunzwe mu Rwanda.\nNi ibirori biteganyijwe kuzaba kuwa 30 Gicurasi 2025 bikazitabirwa n'abagera kuir 500.",
                image: '/img/rwandan-traditional-dance.jpg'
            },
        ]
    },
    autoSlide: {
        type: Boolean,
        default: true
    },
    interval: {
        type: Number,
        default: 5000
    }
});

const currentSlide = ref(0);
const timer = ref(null);
const showDialog = ref(false);
const selectedNews = ref(null);

const nextSlide = () => {
    currentSlide.value = (currentSlide.value + 1) % props.news.length;
};

const prevSlide = () => {
    currentSlide.value = (currentSlide.value - 1 + props.news.length) % props.news.length;
};

const goToSlide = (index) => {
    currentSlide.value = index;
};

const startAutoSlide = () => {
    if (props.autoSlide) {
        timer.value = setInterval(() => {
            nextSlide();
        }, props.interval);
    }
};

const stopAutoSlide = () => {
    if (timer.value) {
        clearInterval(timer.value);
    }
};

const openDialog = (item) => {
    selectedNews.value = item;
    showDialog.value = true;
    stopAutoSlide(); // Pause auto-slide when dialog is open
};

const closeDialog = () => {
    showDialog.value = false;
    startAutoSlide(); // Resume auto-slide when dialog is closed
};

onMounted(() => {
    startAutoSlide();
});

onBeforeUnmount(() => {
    stopAutoSlide();
});
</script>

<template>
    <div id="news" class="relative bg-white overflow-hidden py-14">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-6">
                <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                    Amakuru y'irushanwa
                </h2>
            </div>

            <div class="relative overflow-hidden rounded-xl shadow-xl">
                <!-- Slides -->
                <div class="relative h-96 md:h-[32rem]">
                    <div v-for="(item, index) in news" :key="item.id"
                        class="absolute inset-0 transition-opacity duration-500 ease-in-out"
                        :class="index === currentSlide ? 'opacity-100 z-10' : 'opacity-0 z-0'">
                        <div class="relative h-full w-full">
                            <!-- Fallback for placeholder images -->
                            <div v-if="!item.image.includes('/api/placeholder')"
                                class="h-full w-full bg-gray-200 flex items-center justify-center">
                                <img :src="imagePath(item.image)" :alt="item.title"
                                    class="h-full w-full object-cover" />
                            </div>
                            <div v-else class="h-full w-full bg-gray-200 flex items-center justify-center">
                                <div class="text-gray-400">Image Placeholder</div>
                            </div>

                            <!-- Gradient overlay -->
                            <div class="absolute inset-0 bg-gradient-to-t from-black via-black/50 to-transparent"></div>

                            <!-- Content overlay -->
                            <div class="absolute bottom-0 left-0 right-0 p-6 text-white">
                                <h3 class="text-2xl font-bold mb-2">{{ item.title }}</h3>
                                <p class="text-lg text-gray-200">
                                    {{ item.description.length > 100 ? item.description.substring(0, 100) + '...' :
                                    item.description }}
                                </p>
                                <button @click="openDialog(item)"
                                    class="mt-4 px-6 py-2 bg-sky-500 hover:bg-sky-600 rounded-lg font-medium transition-all">
                                    Soma Byinshi
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Navigation arrows -->
                <button @click="prevSlide"
                    class="absolute left-2 top-1/2 transform -translate-y-1/2 w-10 h-10 rounded-full bg-black/40 hover:bg-black/60 flex items-center justify-center text-white z-20">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
                    </svg>
                </button>
                <button @click="nextSlide"
                    class="absolute right-2 top-1/2 transform -translate-y-1/2 w-10 h-10 rounded-full bg-black/40 hover:bg-black/60 flex items-center justify-center text-white z-20">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                    </svg>
                </button>

                <!-- Dots navigation -->
                <div class="absolute bottom-4 left-0 right-0 flex justify-center gap-2 z-20">
                    <button v-for="(_, index) in news" :key="index" @click="goToSlide(index)"
                        class="w-3 h-3 rounded-full transition-all duration-300"
                        :class="index === currentSlide ? 'bg-white scale-125' : 'bg-white/50 hover:bg-white/70'">
                    </button>
                </div>
            </div>
        </div>

        <!-- Dialog (Modal) for Read More -->
        <div v-if="showDialog" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
            @click.self="closeDialog">
            <div class="bg-white rounded-lg shadow-xl max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto">
                <div class="p-6">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-bold text-gray-900">{{ selectedNews.title }}</h3>
                        <button @click="closeDialog" class="text-gray-500 hover:text-gray-700">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>


                    <div class="text-gray-700 text-sm whitespace-pre-line">
                        <p>{{ selectedNews?.description }}</p>
                    </div>

                    <div class="mt-6 flex justify-end">
                        <button @click="closeDialog"
                            class="px-4 py-2 bg-gray-200 hover:bg-gray-300 rounded-lg font-medium">
                            Funga
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
