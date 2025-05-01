<script setup>
import { ref, onMounted } from 'vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Input } from "@/Components/ui/input";
import { Label } from "@/Components/ui/label";
import { Button } from '@/Components/ui/button';
import {
    Dialog,
    DialogContent,
    DialogHeader,
    DialogTitle,
    DialogFooter,
} from "@/Components/ui/dialog";
import {
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
} from "@/Components/ui/table";
import {
    Card,
    CardContent,
    CardDescription,
    CardFooter,
    CardHeader,
    CardTitle,
} from "@/Components/ui/card";

import { Badge } from "@/Components/ui/badge";
import { Edit, Plus, Trash2, ListPlus } from 'lucide-vue-next';
import { Textarea } from '@/Components/ui/textarea';

const props = defineProps({
    categories: Array,
});

// State for active tab (league)

// Combined create/edit category dialog
const showCategoryDialog = ref(false);
const isEditMode = ref(false);
const form = useForm({
    id: null,
    name: '',
    league: '',
    description: '',
    status: 'active',
});

const resetForm = () => {
    form.reset();
    form.clearErrors();
};

const openCreateDialog = (league_id = null) => {
    resetForm();
    isEditMode.value = false;

    showCategoryDialog.value = true;
};

const openEditDialog = (category) => {
    resetForm();
    isEditMode.value = true;

    // Fill form with category data
    form.id = category.id;
    form.name = category.name;
    form.league = category.league,
        form.description = category.description;
    form.status = category.status;

    showCategoryDialog.value = true;
};

const submitForm = () => {
    if (isEditMode.value) {
        form.put(route('categories.update', form.id), {
            onSuccess: () => {
                showCategoryDialog.value = false;
                resetForm();
                router.visit(route('categories.index'), {
                    only: ['categories']
                });
            },
            onError: (errors) => {
                console.log('Validation errors:', errors);
            }
        });
    } else {
        form.post(route('categories.store'), {
            onSuccess: () => {
                showCategoryDialog.value = false;
                resetForm();
                router.visit(route('categories.index'), {
                    only: ['categories']
                });
            },
            onError: (errors) => {
                console.log('Validation errors:', errors);
            }
        });
    }
};

const confirmDelete = (categoryId) => {
    if (confirm('Are you sure you want to delete this category?')) {
        useForm().delete(route('categories.destroy', categoryId), {
            onSuccess: () => {
                router.visit(route('categories.index'), {
                    only: ['categories']
                });
            }
        });
    }
};

const getStatusColor = (status) => {
    switch (status) {
        case 'active':
            return 'bg-green-100 text-green-800';
        case 'inactive':
            return 'bg-red-100 text-red-800';
        default:
            return 'bg-gray-100 text-gray-800';
    }
};


</script>

<template>

    <Head title="Categories" />

    <AuthenticatedLayout>
        <Card>
            <CardHeader class="pb-3">
                <div class="flex justify-between items-center">
                    <div>
                        <CardTitle class="text-2xl">Awards Categories</CardTitle>
                    </div>
                    <Button @click="openCreateDialog()" variant="default" class="flex items-center gap-2">
                        <Plus class="w-4 h-4" />
                        Add Category
                    </Button>
                </div>
            </CardHeader>
            <CardContent>
                <!-- Categories Table -->
                <div class="rounded-md border">
                    <Table>
                        <TableHeader class="bg-blue-50">
                            <TableRow>
                                <TableHead class="font-bold">#</TableHead>
                                <TableHead class="font-bold">League</TableHead>
                                <TableHead class="font-bold">Name</TableHead>
                                <TableHead class="font-bold">Description</TableHead>
                                <TableHead class="font-bold">Status</TableHead>
                                <TableHead class="font-bold">Condidate</TableHead>
                                <TableHead class="font-bold text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            <TableRow v-for="(category, index) in categories" :key="category.id">
                                <TableCell>
                                    <Badge variant="outline">
                                        {{ index + 1 }}
                                    </Badge>
                                </TableCell>
                                <TableCell>{{ category.league.toUpperCase() }}</TableCell>
                                <TableCell class="font-medium">{{ category.name }}</TableCell>
                                <TableCell>{{ category.description }}</TableCell>
                                <TableCell>
                                    <Badge :class="getStatusColor(category.status)">
                                        {{ category.status.charAt(0).toUpperCase() + category.status.slice(1) }}
                                    </Badge>
                                </TableCell>
                                <TableCell>
                                    <Link :href="route('categories.show', category.id)">
                                    <Badge variant="outline" class="text-md">
                                        {{ category.candidates_count }} {{ category.candidates_count === 1 ? "Condidate"
                                            :
                                            "Condidates" }}
                                    </Badge>
                                    </Link>
                                </TableCell>

                                <TableCell class="text-right">
                                    <div class="flex justify-end gap-2">
                                        <Button variant="outline" size="icon" class="h-8 w-8"
                                            @click="openEditDialog(category)">
                                            <Edit class="h-4 w-4" />
                                        </Button>
                                        <Button variant="outline" size="icon" class="h-8 w-8 text-red-500"
                                            @click="confirmDelete(category.id)">
                                            <Trash2 class="h-4 w-4" />
                                        </Button>
                                    </div>
                                </TableCell>
                            </TableRow>
                            <TableRow v-if="categories.length === 0">
                                <TableCell colspan="7" class="text-center py-8 text-gray-500">
                                    No categories found. Try adding a new category.
                                </TableCell>
                            </TableRow>
                        </TableBody>
                    </Table>
                </div>
            </CardContent>
        </Card>

        <!-- Combined Create/Edit Category Dialog -->
        <Dialog :open="showCategoryDialog" @update:open="showCategoryDialog = $event">
            <DialogContent class="max-w-xl">
                <DialogHeader>
                    <DialogTitle>{{ isEditMode ? 'Edit Category' : 'Add New Category' }}</DialogTitle>
                </DialogHeader>
                <form @submit.prevent="submitForm">
                    <div class="grid gap-4 py-4">
                        <div class="grid gap-2">
                            <Label for="name">Name</Label>
                            <Input id="name" v-model="form.name" placeholder="Category Name" required />
                            <div v-if="form.errors.name" class="text-sm text-red-500">{{ form.errors.name }}</div>
                        </div>
                        <div class="grid gap-2">
                            <Label for="league">League</Label>
                            <select id="league" v-model="form.league"
                                class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                                required>
                                <option value="" disabled>Select a league</option>
                                <option value="men">Men</option>
                                <option value="women">Women</option>
                            </select>
                            <div v-if="form.errors.league" class="text-sm text-red-500">{{ form.errors.league }}
                            </div>
                        </div>

                        <div class="grid gap-2">
                            <Label for="description">Description</Label>
                            <Textarea id="description" v-model="form.description" placeholder="Description" required />
                            <div v-if="form.errors.description" class="text-sm text-red-500">
                                {{ form.errors.description }}
                            </div>
                        </div>

                        <div v-if="isEditMode" class="grid gap-2">
                            <Label for="status">Status</Label>
                            <select id="status" v-model="form.status"
                                class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50">
                                <option value="active">Active</option>
                                <option value="inactive">Inactive</option>
                            </select>
                            <div v-if="form.errors.status" class="text-sm text-red-500">{{ form.errors.status }}</div>
                        </div>
                    </div>
                    <DialogFooter>
                        <Button type="button" variant="outline" @click="showCategoryDialog = false">Cancel</Button>
                        <Button type="submit" :disabled="form.processing">
                            {{ isEditMode ? 'Update Category' : 'Create Category' }}
                            <span v-if="form.processing" class="ml-2">
                                <svg class="animate-spin h-5 w-5 text-white" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor"
                                        stroke-width="4"></circle>
                                    <path class="opacity-75" fill="currentColor"
                                        d="M4 12a8 8 0 1 1 16 0A8 8 0 0 1 4 12z"></path>
                                </svg>
                            </span>
                        </Button>
                    </DialogFooter>
                </form>
            </DialogContent>
        </Dialog>
    </AuthenticatedLayout>
</template>
