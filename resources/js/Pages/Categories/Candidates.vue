<script setup>
import { ref, computed, onMounted } from 'vue';
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
    Card,
    CardContent,
    CardDescription,
    CardFooter,
    CardHeader,
    CardTitle,
} from "@/Components/ui/card";

import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "@/Components/ui/select";

import { Badge } from "@/Components/ui/badge";
import { Checkbox } from "@/Components/ui/checkbox";
import {
    Edit,
    Plus,
    Trash2,
    Image as ImageIcon,
    ArrowUp,
    ArrowDown,
    EyeOff,
    Eye,
    LineChart,
    Trophy
} from 'lucide-vue-next';
import imagePath from '@/lib/image';

const props = defineProps({
    category: Object,
    candidates: Array
});

// Combined create/edit candidate dialog
const showCandidateDialog = ref(false);
const isEditMode = ref(false);
const imagePreview = ref(null);

// Stats dialog
const showStatsDialog = ref(false);
const currentCandidate = ref(null);

const form = useForm({
    id: null,
    category_id: props.category?.id,
    name: '',
    image: null,
    order: 1,
    status: 'active',
    stats: null,
});

// Stats form
const statsForm = useForm({
    id: null,
    stats: {
        goals: 0,
        assists: 0,
        appearances: 0,
        cleanSheets: 0,
        wins: 0,
        draws: 0,
        losses: 0,
    }
});

// Reset form and clear any errors
const resetForm = () => {
    form.reset();
    form.clearErrors();
    imagePreview.value = null;
};

// Open dialog for creating a new candidate
const openCreateDialog = () => {
    resetForm();
    isEditMode.value = false;
    form.category_id = props.category.id;

    // Set default order to be the last position + 1
    if (props.candidates && props.candidates.length > 0) {
        const maxOrder = Math.max(...props.candidates.map(c => c.order || 0));
        form.order = maxOrder + 1;
    } else {
        form.order = 1;
    }

    showCandidateDialog.value = true;
};

// Open dialog for editing an existing candidate
const openEditDialog = (candidate) => {
    resetForm();
    isEditMode.value = true;

    // Fill form with candidate data
    form.id = candidate.id;
    form.category_id = props.category.id;
    form.name = candidate.name;
    form.order = candidate.order || 1;
    form.status = candidate.status || 'active';
    form.stats = candidate.stats || null;

    // Set image preview if image exists
    if (candidate.image) {
        imagePreview.value = imagePath(`/${candidate.image}`);
    }

    showCandidateDialog.value = true;
};

// Open stats dialog for a candidate
const openStatsDialog = (candidate) => {
    currentCandidate.value = candidate;
    statsForm.id = candidate.id;

    // Initialize with existing stats or set defaults
    if (candidate.stats) {
        statsForm.stats = {
            goals: candidate.stats.goals || 0,
            assists: candidate.stats.assists || 0,
            appearances: candidate.stats.appearances || 0,
            cleanSheets: candidate.stats.cleanSheets || 0,
            wins: candidate.stats.wins || 0,
            draws: candidate.stats.draws || 0,
            losses: candidate.stats.losses || 0,
        };
    } else {
        // Set default values
        statsForm.stats = {
            goals: 0,
            assists: 0,
            appearances: 0,
            cleanSheets: 0,
            wins: 0,
            draws: 0,
            losses: 0,

        };
    }

    showStatsDialog.value = true;
};

// Submit stats form
const submitStatsForm = () => {
    statsForm.post(route('candidates.updateStats', statsForm.id), {
        onSuccess: () => {
            showStatsDialog.value = false;
            router.visit(route('categories.show', props.category.id), {
                only: ['candidates']
            });
        },
        onError: (errors) => {
            console.log('Validation errors:', errors);
        }
    });
};

// Handle form submission (create or update)
const submitForm = () => {
    if (isEditMode.value) {
        form.post(route('candidates.update', form.id), {
            onSuccess: () => {
                showCandidateDialog.value = false;
                resetForm();
                router.visit(route('categories.show', props.category.id), {
                    only: ['candidates']
                });
            },
            onError: (errors) => {
                console.log('Validation errors:', errors);
            }
        });
    } else {
        form.post(route('candidates.store'), {
            onSuccess: () => {
                showCandidateDialog.value = false;
                resetForm();
                router.visit(route('categories.show', props.category.id), {
                    only: ['candidates']
                });
            },
            onError: (errors) => {
                console.log('Validation errors:', errors);
            }
        });
    }
};

// Handle image upload
const handleImageUpload = (e) => {
    const file = e.target.files[0];
    if (file) {
        form.image = file;

        // Create preview URL
        const reader = new FileReader();
        reader.onload = (e) => {
            imagePreview.value = e.target.result;
        };
        reader.readAsDataURL(file);
    }
};

// Delete confirmation
const confirmDelete = (candidateId) => {
    if (confirm('Are you sure you want to delete this candidate?')) {
        useForm().delete(route('candidates.destroy', candidateId), {
            onSuccess: () => {
                router.visit(route('categories.show', props.category.id), {
                    only: ['candidates']
                });
            }
        });
    }
};

// Move candidate up in order
const moveUp = (candidate) => {
    const candidateForm = useForm({
        id: candidate.id,
        category_id: props.category.id,
        order: candidate.order - 1
    });

    candidateForm.post(route('candidates.updateOrder', candidate.id), {
        onSuccess: () => {
            router.visit(route('categories.show', props.category.id), {
                only: ['candidates']
            });
        }
    });
};

// Move candidate down in order
const moveDown = (candidate) => {
    const candidateForm = useForm({
        id: candidate.id,
        category_id: props.category.id,
        order: candidate.order + 1
    });

    candidateForm.post(route('candidates.updateOrder', candidate.id), {
        onSuccess: () => {
            router.visit(route('categories.show', props.category.id), {
                only: ['candidates']
            });
        }
    });
};

// Toggle candidate status
const toggleStatus = (candidate) => {
    const newStatus = candidate.status === 'active' ? 'inactive' : 'active';

    const candidateForm = useForm({
        id: candidate.id,
        category_id: props.category.id,
        status: newStatus
    });

    candidateForm.post(route('candidates.updateStatus', candidate.id), {
        onSuccess: () => {
            router.visit(route('categories.show', props.category.id), {
                only: ['candidates']
            });
        }
    });
};

// Sort candidates by order
const sortedCandidates = computed(() => {
    if (!props.candidates) return [];
    return [...props.candidates].sort((a, b) => (a.order || 0) - (b.order || 0));
});

// Get award badge information
const hasAnyAward = (candidate) => {
    if (!candidate.stats || !candidate.stats.awards) return false;
    const awards = candidate.stats.awards;
    return awards.bestPlayer || awards.goalOfSeason || awards.coach || awards.youngPlayer;
};

const getAwardLabel = (candidate) => {
    if (!candidate.stats || !candidate.stats.awards) return '';

    const awards = candidate.stats.awards;
    if (awards.bestPlayer) return 'Best Player';
    if (awards.goalOfSeason) return 'Goal of Season';
    if (awards.coach) return 'Coach';
    if (awards.youngPlayer) return 'Young Player';

    return '';
};
</script>

<template>

    <Head :title="`${category.name} Candidates`" />

    <AuthenticatedLayout>
        <Card>
            <CardHeader class="pb-3">
                <div class="flex justify-between items-center">
                    <div>
                        <div class="flex items-center gap-2">
                            <Link :href="route('categories.index')" class="text-blue-500 hover:underline">
                            Categories
                            </Link>
                            <span class="text-gray-500">/</span>
                            <CardTitle class="text-2xl">{{ category.name }}</CardTitle>
                        </div>
                        <CardDescription>
                            League: {{ category.league.toUpperCase() }}
                        </CardDescription>
                    </div>
                    <Button @click="openCreateDialog()" variant="default" class="flex items-center gap-2">
                        <Plus class="w-4 h-4" />
                        Add Candidate
                    </Button>
                </div>
            </CardHeader>
            <CardContent>
                <!-- Grid of Candidate Cards -->
                <div v-if="sortedCandidates.length > 0" class="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4">
                    <Card v-for="candidate in sortedCandidates" :key="candidate.id"
                        :class="{ 'opacity-60': candidate.status === 'inactive' }" class="rounded-none">
                        <CardHeader class="pb-2 space-y-0 p-3">
                            <CardTitle class="text-md font-light flex justify-between items-center">
                                <Badge v-if="hasAnyAward(candidate)" class="bg-yellow-500 hover:bg-yellow-600">
                                    <Trophy class="h-3 w-3 mr-1" />
                                    {{ getAwardLabel(candidate) }}
                                </Badge>
                                <Badge :variant="candidate.status === 'active' ? 'default' : 'destructive'"
                                    class="text-xs">
                                    {{ candidate.status.toUpperCase() }}
                                </Badge>
                            </CardTitle>
                        </CardHeader>

                        <CardContent class="p-0">
                            <div class="relative mb-3 bg-gray-100 overflow-hidden">
                                <img v-if="candidate.image" :src="imagePath(`/${candidate.image}`)"
                                    :alt="candidate.name" class="w-full h-full object-cover object-center" />
                                <div v-else class="w-full h-full flex items-center justify-center">
                                    <ImageIcon class="w-12 h-12 text-gray-300" />
                                </div>

                                <div
                                    class="absolute top-2 left-2 bg-black/70 font-thin text-white text-xs px-2 py-1 rounded">
                                    ORDER: {{ candidate.order }}
                                </div>

                                <!-- Stats Badge -->
                                <div v-if="candidate.stats && candidate.stats.rating"
                                    class="absolute bottom-2 right-2 bg-green-500 font-medium text-white text-xs px-2 py-1 rounded">
                                    {{ candidate.stats.rating }}/10
                                </div>
                            </div>

                            <div class="px-3 pb-3">
                                <h3 class="font-medium text-md mb-1">{{ candidate.name }}</h3>
                                <div v-if="candidate.stats"
                                    class="text-xs text-gray-500 grid grid-cols-2 gap-x-2 gap-y-1">
                                    <div v-if="typeof candidate.stats.goals !== 'undefined'">
                                        <span class="font-medium">Goals:</span> {{ candidate.stats.goals }}
                                    </div>
                                    <div v-if="typeof candidate.stats.assists !== 'undefined'">
                                        <span class="font-medium">Assists:</span> {{ candidate.stats.assists }}
                                    </div>
                                    <div v-if="typeof candidate.stats.appearances !== 'undefined'">
                                        <span class="font-medium">Apps:</span> {{ candidate.stats.appearances }}
                                    </div>
                                    <div v-if="typeof candidate.stats.cleanSheets !== 'undefined'">
                                        <span class="font-medium">Clean Sheets:</span> {{ candidate.stats.cleanSheets }}
                                    </div>
                                    <div v-if="typeof candidate.stats.wins !== 'undefined'">
                                        <span class="font-medium">Wins:</span> {{ candidate.stats.wins }}
                                    </div>
                                    <div v-if="typeof candidate.stats.draws !== 'undefined'">
                                        <span class="font-medium">Draws:</span> {{ candidate.stats.draws }}
                                    </div>
                                    <div v-if="typeof candidate.stats.losses !== 'undefined'">
                                        <span class="font-medium">Losses:</span> {{ candidate.stats.losses }}
                                    </div>

                                </div>
                            </div>
                        </CardContent>

                        <CardFooter class="grid grid-cols-2 gap-2 p-2 border-t">
                            <div class="flex gap-1">
                                <Button variant="outline" size="icon" class="h-8 w-8" @click="moveUp(candidate)"
                                    :disabled="candidate.order <= 1">
                                    <ArrowUp class="h-4 w-4" />
                                </Button>
                                <Button variant="outline" size="icon" class="h-8 w-8" @click="moveDown(candidate)"
                                    :disabled="candidate.order >= sortedCandidates.length">
                                    <ArrowDown class="h-4 w-4" />
                                </Button>
                                <Button variant="outline" size="icon" class="h-8 w-8" @click="toggleStatus(candidate)">
                                    <EyeOff v-if="candidate.status === 'active'" class="h-4 w-4" />
                                    <Eye v-else class="h-4 w-4" />
                                </Button>
                            </div>
                            <div class="flex justify-end gap-1">
                                <Button variant="outline" size="icon" class="h-8 w-8 text-blue-500"
                                    @click="openStatsDialog(candidate)">
                                    <LineChart class="h-4 w-4" />
                                </Button>
                                <Button variant="outline" size="icon" class="h-8 w-8"
                                    @click="openEditDialog(candidate)">
                                    <Edit class="h-4 w-4" />
                                </Button>
                                <Button variant="outline" size="icon" class="h-8 w-8 text-red-500"
                                    @click="confirmDelete(candidate.id)">
                                    <Trash2 class="h-4 w-4" />
                                </Button>
                            </div>
                        </CardFooter>
                    </Card>
                </div>

                <!-- Empty State -->
                <div v-else class="text-center py-12 border border-dashed rounded-lg">
                    <div class="flex flex-col items-center justify-center space-y-3">
                        <ImageIcon class="w-12 h-12 text-gray-300" />
                        <div class="text-gray-500">No candidates found</div>
                        <Button variant="outline" @click="openCreateDialog()" class="flex items-center gap-2">
                            <Plus class="w-4 h-4" />
                            Add Your First Candidate
                        </Button>
                    </div>
                </div>
            </CardContent>
        </Card>

        <!-- Combined Create/Edit Candidate Dialog -->
        <Dialog :open="showCandidateDialog" @update:open="showCandidateDialog = $event">
            <DialogContent class="max-w-md">
                <DialogHeader>
                    <DialogTitle>{{ isEditMode ? 'Edit Candidate' : 'Add New Candidate' }}</DialogTitle>
                </DialogHeader>
                <form @submit.prevent="submitForm" enctype="multipart/form-data">
                    <div class="grid gap-4 py-4">
                        <!-- Name Field -->
                        <div class="grid gap-2">
                            <Label for="name">Name</Label>
                            <Input id="name" v-model="form.name" placeholder="Candidate Name" required />
                            <div v-if="form.errors.name" class="text-sm text-red-500">{{ form.errors.name }}</div>
                        </div>

                        <!-- Order Field -->
                        <div v-if="isEditMode" class="grid gap-2">
                            <Label for="order">Order</Label>
                            <Input type="number" id="order" v-model="form.order" min="1" placeholder="Display Order"
                                required />
                            <div v-if="form.errors.order" class="text-sm text-red-500">{{ form.errors.order }}</div>
                        </div>

                        <!-- Status Field -->
                        <div v-if="isEditMode" class="grid gap-2">
                            <Label for="status">Status</Label>
                            <Select v-model="form.status">
                                <SelectTrigger>
                                    <SelectValue placeholder="Select status" />
                                </SelectTrigger>
                                <SelectContent>
                                    <SelectItem value="active">Active</SelectItem>
                                    <SelectItem value="inactive">Inactive</SelectItem>
                                </SelectContent>
                            </Select>
                            <div v-if="form.errors.status" class="text-sm text-red-500">{{ form.errors.status }}</div>
                        </div>

                        <!-- Image Upload -->
                        <div class="grid gap-2">
                            <Label for="image">Poster Image</Label>
                            <div class="flex flex-col gap-3">
                                <div v-if="imagePreview"
                                    class="w-full aspect-video rounded-md overflow-hidden bg-gray-100">
                                    <img :src="imagePreview" alt="Preview"
                                        class="w-full h-full object-cover object-center" />
                                </div>
                                <div v-else
                                    class="w-full aspect-video rounded-md bg-gray-100 flex items-center justify-center">
                                    <ImageIcon class="w-12 h-12 text-gray-300" />
                                </div>
                                <Input id="image" type="file" @change="handleImageUpload" accept="image/*" />
                            </div>
                            <div v-if="form.errors.image" class="text-sm text-red-500">{{ form.errors.image }}</div>
                        </div>
                    </div>

                    <DialogFooter>
                        <Button type="button" variant="outline" @click="showCandidateDialog = false">Cancel</Button>
                        <Button type="submit" :disabled="form.processing">
                            {{ isEditMode ? 'Update Candidate' : 'Create Candidate' }}
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

        <!-- Stats Dialog -->
        <Dialog :open="showStatsDialog" @update:open="showStatsDialog = $event">
            <DialogContent class="max-w-md">
                <DialogHeader>
                    <DialogTitle>{{ currentCandidate?.name }} - Statistics</DialogTitle>
                </DialogHeader>
                <form @submit.prevent="submitStatsForm">
                    <div class="grid gap-6 py-4">
                        <!-- Performance Stats Section -->
                        <div>
                            <h3 class="text-lg font-medium mb-3">Performance Statistics</h3>
                            <div class="grid grid-cols-2 gap-4">
                                <div class="grid gap-2">
                                    <Label for="goals">Goals</Label>
                                    <Input id="goals" type="number" v-model="statsForm.stats.goals" min="0"
                                        placeholder="0" />
                                </div>
                                <div class="grid gap-2">
                                    <Label for="assists">Assists</Label>
                                    <Input id="assists" type="number" v-model="statsForm.stats.assists" min="0"
                                        placeholder="0" />
                                </div>
                                <div class="grid gap-2">
                                    <Label for="appearances">Appearances</Label>
                                    <Input id="appearances" type="number" v-model="statsForm.stats.appearances" min="0"
                                        placeholder="0" />
                                </div>
                                <div class="grid gap-2">
                                    <Label for="cleanSheets">Clean Sheets</Label>
                                    <Input id="cleanSheets" type="number" v-model="statsForm.stats.cleanSheets" min="0"
                                        placeholder="0" />
                                </div>
                            </div>
                        </div>

                        <!-- Match Results Section -->
                        <div>
                            <h3 class="text-lg font-medium mb-3">Match Results</h3>
                            <div class="grid grid-cols-3 gap-4">
                                <div class="grid gap-2">
                                    <Label for="wins">Wins</Label>
                                    <Input id="wins" type="number" v-model="statsForm.stats.wins" min="0"
                                        placeholder="0" />
                                </div>
                                <div class="grid gap-2">
                                    <Label for="draws">Draws</Label>
                                    <Input id="draws" type="number" v-model="statsForm.stats.draws" min="0"
                                        placeholder="0" />
                                </div>
                                <div class="grid gap-2">
                                    <Label for="losses">Losses</Label>
                                    <Input id="losses" type="number" v-model="statsForm.stats.losses" min="0"
                                        placeholder="0" />
                                </div>
                            </div>
                        </div>


                    </div>

                    <DialogFooter>
                        <Button type="button" variant="outline" @click="showStatsDialog = false">Cancel</Button>
                        <Button type="submit" :disabled="statsForm.processing">
                            Save Statistics
                            <span v-if="statsForm.processing" class="ml-2">
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