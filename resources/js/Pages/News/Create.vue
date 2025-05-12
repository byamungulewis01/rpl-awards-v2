<template>
    <Head title="Create News Article" />

    <AuthenticatedLayout>
        <Card class="max-w-4xl mx-auto mt-10">
            <CardHeader>
                <CardTitle>Create News Article</CardTitle>
            </CardHeader>
            <form @submit.prevent="submit">
                <CardContent class="space-y-4">
                    <div>
                        <Input v-model="form.title" placeholder="Title" required />
                        <InputError :message="form.errors.title" />
                    </div>

                    <div>
                        <Input type="file" @change="e => form.image = e.target.files[0]" accept="image/*" required />
                        <InputError :message="form.errors.image" />
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
                    <Button type="submit" :disabled="form.processing">Create Article</Button>
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

const form = useForm({
    title: '',
    image: null,
    short_description: '',
    long_description: ''
});

const submit = () => {
    form.post(route('news.store'), {
        onSuccess: () => form.reset(),
    });
};
</script>
