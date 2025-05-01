<template>
    <div id="faq" class="bg-gray-50 py-12 border-t border-gray-200">
        <div class="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-10">
                <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                    Frequently Asked Questions
                </h2>
                <p class="mt-4 text-lg text-gray-500">
                    Everything you need to know about the voting process
                </p>
            </div>

            <div class="space-y-4">
                <div v-for="(item, index) in faqItems" :key="index"
                    class="bg-white rounded-lg shadow-md overflow-hidden transition-all duration-300">
                    <button
                        class="w-full px-6 py-4 text-left focus:outline-none focus:ring-2 focus:ring-sky-500 focus:ring-opacity-50 flex justify-between items-center"
                        @click="toggleItem(index)">
                        <span class="text-lg font-medium text-gray-900">{{ item.question }}</span>
                        <svg xmlns="http://www.w3.org/2000/svg"
                            class="h-5 w-5 text-sky-500 transition-transform duration-300"
                            :class="{ 'transform rotate-180': openIndex === index }" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                        </svg>
                    </button>
                    <transition enter-active-class="transition duration-300 ease-out"
                        enter-from-class="transform scale-y-0 opacity-0"
                        enter-to-class="transform scale-y-100 opacity-100"
                        leave-active-class="transition duration-200 ease-in"
                        leave-from-class="transform scale-y-100 opacity-100"
                        leave-to-class="transform scale-y-0 opacity-0">
                        <div v-show="openIndex === index" class="px-6 pb-4 origin-top">
                            <p class="text-gray-600">
                                {{ item.answer }}
                            </p>
                        </div>
                    </transition>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue';

const openIndex = ref(0);

const faqItems = [
    {
        question: 'How does the voting system work?',
        answer: 'Each vote costs 200 RWF. You can cast multiple votes for your favorite candidate to increase their chances of winning. Simply select the category, choose your candidate, adjust the number of votes, and complete the payment using either MTN Mobile Money or Airtel Money.'
    },
    {
        question: 'Is there a limit to how many votes I can cast?',
        answer: 'You can cast up to 100 votes in a single transaction. There\'s no limit to the number of transactions you can make throughout the voting period.'
    },
    {
        question: 'When does voting close?',
        answer: 'Voting for the Rwanda Premier League Awards 2025 will close on June 15, 2025, at 11:59 PM (Rwanda time). The award ceremony will be held on June 30, 2025.'
    },
    {
        question: 'How are the nominees selected?',
        answer: 'Nominees are selected based on their performance throughout the 2024-2025 Rwanda Premier League season. A committee of coaches, sports journalists, and league officials creates the initial shortlist before opening it to public voting.'
    },
    {
        question: 'What happens if my payment fails?',
        answer: 'If your payment fails, no votes will be registered, and no money will be deducted from your account. You can try again or use an alternative payment method. If money was deducted but no confirmation was received, please contact our support team with your transaction details.'
    },
    {
        question: 'Can I vote for multiple candidates in the same category?',
        answer: 'Yes, you can vote for multiple candidates in the same category. Each vote is processed as a separate transaction, allowing you to support different candidates across all categories.'
    }
];

const toggleItem = (index) => {
    // Close the current open item if clicking the same item again
    if (openIndex.value === index) {
        openIndex.value = null;
    } else {
        openIndex.value = index;
    }
};
</script>

<style scoped>
/* Optional additional styling can go here */
.origin-top {
    transform-origin: top;
}
</style>
