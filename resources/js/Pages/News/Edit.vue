<template>
    <Head title="Edit News Article" />

    <AuthenticatedLayout>
        <Card class="max-w-2xl mx-auto mt-10">
            <CardHeader>
                <CardTitle>Edit News Article</CardTitle>
            </CardHeader>
            <form @submit.prevent="submit">
                <CardContent class="space-y-4">
                    <div>
                        <Input v-model="form.title" placeholder="Title" required />
                        <InputError :message="form.errors.title" />
                    </div>

                    <div>
                        <div v-if="props.article.image" class="mb-2">
                            <img :src="props.article.image" alt="Current image" class="h-24 w-24 object-cover rounded" />
                        </div>
                        <Input type="file" @change="e => form.image = e.target.files[0]" accept="image/*" />
                        <InputError :message="form.errors.image" />
                        <p class="text-xs text-gray-500 mt-1">Leave empty to keep current image</p>
                    </div>
                    <div>
                        <Textarea v-model="form.short_description" placeholder="Short Description" required />
                        <InputError :message="form.errors.short_description" />
                    </div>
                    <div>
                        <QuillEditor
                            v-model:content="form.long_description"
                            contentType="html"
                            theme="snow"
                            toolbar="full"
                            :options="{
                                modules: {
                                    toolbar: [
                                        ['bold', 'italic', 'underline', 'strike'],
                                        ['blockquote', 'code-block'],
                                        [{ 'header': 1 }, { 'header': 2 }],
                                        [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                                        [{ 'script': 'sub'}, { 'script': 'super' }],
                                        [{ 'indent': '-1'}, { 'indent': '+1' }],
                                        [{ 'direction': 'rtl' }],
                                        [{ 'size': ['small', false, 'large', 'huge'] }],
                                        [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                                        [{ 'color': [] }, { 'background': [] }],
                                        [{ 'font': [] }],
                                        [{ 'align': [] }],
                                        ['clean'],
                                        ['link', 'image']
                                    ]
                                }
                            }"
                            class="h-96 mb-4"
                        />
                        <InputError :message="form.errors.long_description" />
                    </div>
                </CardContent>
                <CardFooter class="flex justify-end gap-2">
                    <Link :href="route('news.index')">
                        <Button type="button" variant="outline">Cancel</Button>
                    </Link>
                    <Button type="submit" :disabled="form.processing">Update Article</Button>
                </CardFooter>
            </form>
        </Card>
    </AuthenticatedLayout>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Card, CardHeader, CardTitle, CardContent, CardFooter } from '@/Components/ui/card';
import { Input } from '@/Components/ui/input';
import { Textarea } from '@/Components/ui/textarea';
import { Button } from '@/Components/ui/button';
import InputError from '@/Components/InputError.vue';
import { QuillEditor } from '@vueup/vue-quill';
import '@vueup/vue-quill/dist/vue-quill.snow.css';

const props = defineProps({
    article: {
        type: Object,
        required: true
    }
});

const form = useForm({
    title: props.article.title,
    image: null,
    short_description: props.article.short_description,
    long_description: props.article.long_description,
    _method: 'PUT'
});

const submit = () => {
    form.post(route('news.update', props.article.id), {
        onSuccess: () => form.reset(),
    });
};
</script>
