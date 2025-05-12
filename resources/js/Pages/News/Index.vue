<template>

    <Head title="News" />

    <AuthenticatedLayout>
        <Card>

            <CardHeader class="pb-3">
                <div class="flex justify-between items-center">
                    <div>
                        <CardTitle class="text-2xl">News Articles</CardTitle>
                    </div>
                    <Link :href="route('news.create')">
                    <Button variant="default" class="flex items-center gap-2">
                        <Plus class="w-4 h-4" /> Add News
                    </Button>
                    </Link>
                </div>
            </CardHeader>
            <CardContent>
                <div class="rounded-md border">
                    <Table>
                        <TableHeader class="bg-blue-50">
                            <TableRow>
                                <TableHead class="font-bold">Image</TableHead>
                                <TableHead class="font-bold">Title</TableHead>
                                <TableHead class="font-bold">Short Description</TableHead>
                                <TableHead class="font-bold text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            <TableRow v-for="(article, index) in news" :key="article.id">

                                <TableCell>
                                    <img :src="article.image" class="h-12 w-12 object-cover rounded" />
                                </TableCell>
                                <TableCell class="font-medium">{{ article.title }}</TableCell>
                                <TableCell>{{ article.short_description }}</TableCell>
                                <TableCell class="text-right">
                                    <div class="flex justify-end gap-2">
                                        <Link :href="route('news.edit', article.id)">
                                        <Button variant="outline" size="icon" class="h-8 w-8">
                                            <Edit class="h-4 w-4" />
                                        </Button>
                                        </Link>
                                        <Button variant="outline" size="icon" class="h-8 w-8 text-red-500"
                                            @click="confirmDelete(article.id)">
                                            <Trash2 class="h-4 w-4" />
                                        </Button>
                                    </div>
                                </TableCell>
                            </TableRow>
                            <TableRow v-if="news.length === 0">
                                <TableCell colspan="5" class="text-center py-8 text-gray-500">
                                    No news articles found. Try adding a new article.
                                </TableCell>
                            </TableRow>
                        </TableBody>
                    </Table>
                </div>
            </CardContent>
        </Card>
    </AuthenticatedLayout>
</template>

<script setup>
import { ref } from 'vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Card, CardHeader, CardTitle, CardContent } from '@/Components/ui/card';
import { Table, TableHeader, TableRow, TableHead, TableBody, TableCell } from '@/Components/ui/table';
import { Button } from '@/Components/ui/button';
import { Edit, Plus, Trash2 } from 'lucide-vue-next';

const props = defineProps({ news: Array });

const confirmDelete = (id) => {
    if (confirm('Are you sure you want to delete this news article?')) {
        router.delete(route('news.destroy', id));
    }
};
</script>
