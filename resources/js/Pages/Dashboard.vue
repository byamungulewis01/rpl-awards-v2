<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head } from '@inertiajs/vue3';
import { computed, ref } from 'vue';
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/Components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/Components/ui/tabs';
import { Progress } from '@/Components/ui/progress';
import { Button } from '@/Components/ui/button';
import { Badge } from '@/Components/ui/badge';

// Dummy data based on the Rwanda Premier League Awards
const categories = ref([
  { id: 1, name: 'Best Player of the Season- Men', nominees: 30, finalists: 10, complete: 100 },
  { id: 2, name: 'Top Scorer (Men)', nominees: 3, finalists: 3, complete: 100 },
  { id: 3, name: 'Goal of the Season', nominees: 10, finalists: 3, complete: 100 },
  { id: 4, name: 'Coach of the Season (Men)', nominees: 6, finalists: 3, complete: 100 },
  { id: 5, name: 'Best 11-Team of the Season', nominees: 33, finalists: 11, complete: 60 },
  { id: 6, name: 'Young Player of the Season', nominees: 10, finalists: 3, complete: 100 },
  { id: 7, name: 'Goalkeeper of the Season', nominees: 8, finalists: 3, complete: 100 },
  { id: 8, name: 'Legacy Award', nominees: 5, finalists: 1, complete: 40 },
  { id: 9, name: 'Referee of the Season (Men)', nominees: 8, finalists: 3, complete: 80 },
  { id: 10, name: 'Best Player of the Season- Women', nominees: 5, finalists: 3, complete: 100 },
  { id: 11, name: 'Top Scorer (Women)', nominees: 3, finalists: 1, complete: 100 },
  { id: 12, name: 'Coach of the Season (Women)', nominees: 5, finalists: 3, complete: 100 },
  { id: 13, name: 'Referee of the Season (Women)', nominees: 6, finalists: 3, complete: 70 },
]);

// Some dummy men's player finalists
const menFinalists = ref([
  { name: 'Jean Bosco Mugiraneza', team: 'APR FC', votes: 1245, image: '/api/placeholder/60/60' },
  { name: 'Jacques Tuyisenge', team: 'Rayon Sports', votes: 1120, image: '/api/placeholder/60/60' },
  { name: 'Muhadjiri Hakizimana', team: 'AS Kigali', votes: 980, image: '/api/placeholder/60/60' },
  { name: 'Djabel Manishimwe', team: 'APR FC', votes: 875, image: '/api/placeholder/60/60' },
  { name: 'Hervé Rugwiro', team: 'Police FC', votes: 740, image: '/api/placeholder/60/60' },
]);

// Some dummy women's player finalists
const womenFinalists = ref([
  { name: 'Nibagwire Alice', team: 'Scandinavia WFC', votes: 645, image: '/api/placeholder/60/60' },
  { name: 'Mukeshimana Marie', team: 'Rayon Sports Women', votes: 580, image: '/api/placeholder/60/60' },
  { name: 'Uwamahoro Clementine', team: 'APR FC Women', votes: 490, image: '/api/placeholder/60/60' },
]);

// Stats summary
const stats = computed(() => {
  return {
    totalNominees: categories.value.reduce((total, cat) => total + cat.nominees, 0),
    totalFinalists: categories.value.reduce((total, cat) => total + cat.finalists, 0),
    totalCategories: categories.value.length,
    menCategories: 9,
    womenCategories: 4,
    completionRate: Math.floor(categories.value.reduce((total, cat) => total + cat.complete, 0) / categories.value.length)
  };
});

// Active category for mobile view
const activeCategory = ref(categories.value[0]);
</script>

<template>
  <Head title="RPL Awards Dashboard" />
  <AuthenticatedLayout>
    <div class="space-y-6 p-6">
      <!-- Header with title and stats -->
      <div class="flex flex-col space-y-2 md:flex-row md:justify-between md:space-y-0">
        <div>
          <h2 class="text-3xl font-bold tracking-tight">RPL 2025 Awards</h2>
          <p class="text-muted-foreground">Dashboard overview of the Rwanda Premier League Awards</p>
        </div>
        <div class="flex items-center space-x-2">
          <Button variant="outline">Export Report</Button>
          <Button>Manage Categories</Button>
        </div>
      </div>

      <!-- Stats cards -->
      <div class="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <Card>
          <CardHeader class="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle class="text-sm font-medium">Total Categories</CardTitle>
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-4 w-4 text-muted-foreground"><path d="M3 6h18"></path><path d="M7 12h10"></path><path d="M10 18h4"></path></svg>
          </CardHeader>
          <CardContent>
            <div class="text-2xl font-bold">{{ stats.totalCategories }}</div>
            <p class="text-xs text-muted-foreground">{{ stats.menCategories }} men + {{ stats.womenCategories }} women</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader class="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle class="text-sm font-medium">Total Nominees</CardTitle>
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-4 w-4 text-muted-foreground"><circle cx="12" cy="8" r="5"></circle><path d="M20 21a8 8 0 0 0-16 0"></path></svg>
          </CardHeader>
          <CardContent>
            <div class="text-2xl font-bold">{{ stats.totalNominees }}</div>
            <p class="text-xs text-muted-foreground">Across all categories</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader class="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle class="text-sm font-medium">Total Finalists</CardTitle>
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-4 w-4 text-muted-foreground"><path d="M8.21 13.89 7 23l9-9-8.99-8.99-1.77 1.78"></path><path d="m14 14.5 6.01-6.01"></path><path d="M22 2 2 22"></path></svg>
          </CardHeader>
          <CardContent>
            <div class="text-2xl font-bold">{{ stats.totalFinalists }}</div>
            <p class="text-xs text-muted-foreground">Final selection</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader class="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle class="text-sm font-medium">Completion Rate</CardTitle>
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-4 w-4 text-muted-foreground"><path d="M12 22c5.523 0 10-4.477 10-10S17.523 2 12 2 2 6.477 2 12s4.477 10 10 10z"></path><path d="m9 12 2 2 4-4"></path></svg>
          </CardHeader>
          <CardContent>
            <div class="text-2xl font-bold">{{ stats.completionRate }}%</div>
            <Progress :value="stats.completionRate" class="mt-2" />
          </CardContent>
        </Card>
      </div>

      <!-- Main content with tabs -->
      <Tabs default-value="categories" class="space-y-4">
        <TabsList>
          <TabsTrigger value="categories">Award Categories</TabsTrigger>
          <TabsTrigger value="men">Men's Finalists</TabsTrigger>
          <TabsTrigger value="women">Women's Finalists</TabsTrigger>
        </TabsList>

        <!-- Categories Tab -->
        <TabsContent value="categories" class="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Award Categories Status</CardTitle>
              <CardDescription>Overview of all RPL 2025 Award categories and their nomination status</CardDescription>
            </CardHeader>
            <CardContent>
              <div class="hidden md:block">
                <div class="grid grid-cols-12 gap-2 rounded-lg border p-4 text-sm font-medium">
                  <div class="col-span-5">Category</div>
                  <div class="col-span-2">Nominees</div>
                  <div class="col-span-2">Finalists</div>
                  <div class="col-span-3">Status</div>
                </div>
                <div v-for="category in categories" :key="category.id" class="grid grid-cols-12 gap-2 rounded-lg border p-4 text-sm">
                  <div class="col-span-5 font-medium">{{ category.name }}</div>
                  <div class="col-span-2">{{ category.nominees }}</div>
                  <div class="col-span-2">{{ category.finalists }}</div>
                  <div class="col-span-3">
                    <Progress :value="category.complete" class="h-2" />
                    <span class="text-xs text-muted-foreground">{{ category.complete }}% complete</span>
                  </div>
                </div>
              </div>

              <!-- Mobile view -->
              <div class="md:hidden">
                <div class="flex justify-between pb-4">
                  <select v-model="activeCategory" class="rounded-md border px-2 py-1">
                    <option v-for="category in categories" :key="category.id" :value="category">
                      {{ category.name }}
                    </option>
                  </select>
                </div>
                <div class="space-y-2">
                  <div class="flex justify-between">
                    <span class="font-medium">Nominees:</span>
                    <span>{{ activeCategory.nominees }}</span>
                  </div>
                  <div class="flex justify-between">
                    <span class="font-medium">Finalists:</span>
                    <span>{{ activeCategory.finalists }}</span>
                  </div>
                  <div class="space-y-1">
                    <span class="font-medium">Status:</span>
                    <Progress :value="activeCategory.complete" class="h-2" />
                    <span class="text-xs text-muted-foreground">{{ activeCategory.complete }}% complete</span>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <!-- Men's Finalists Tab -->
        <TabsContent value="men" class="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Men's Category Finalists</CardTitle>
              <CardDescription>Top nominees for the Best Player of the Season (Men)</CardDescription>
            </CardHeader>
            <CardContent>
              <div class="space-y-4">
                <div v-for="(player, index) in menFinalists" :key="index" class="flex items-center justify-between rounded-lg border p-4">
                  <div class="flex items-center space-x-4">
                    <img :src="player.image" alt="Player" class="h-12 w-12 rounded-full" />
                    <div>
                      <p class="font-medium">{{ player.name }}</p>
                      <p class="text-sm text-muted-foreground">{{ player.team }}</p>
                    </div>
                  </div>
                  <div class="flex items-center space-x-2">
                    <Badge variant="secondary">{{ player.votes }} votes</Badge>
                    <Button variant="outline" size="sm">View Profile</Button>
                  </div>
                </div>
              </div>
            </CardContent>
            <CardFooter>
              <Button variant="outline" class="w-full">View All Men's Categories</Button>
            </CardFooter>
          </Card>
        </TabsContent>

        <!-- Women's Finalists Tab -->
        <TabsContent value="women" class="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Women's Category Finalists</CardTitle>
              <CardDescription>Top nominees for the Best Player of the Season (Women)</CardDescription>
            </CardHeader>
            <CardContent>
              <div class="space-y-4">
                <div v-for="(player, index) in womenFinalists" :key="index" class="flex items-center justify-between rounded-lg border p-4">
                  <div class="flex items-center space-x-4">
                    <img :src="player.image" alt="Player" class="h-12 w-12 rounded-full" />
                    <div>
                      <p class="font-medium">{{ player.name }}</p>
                      <p class="text-sm text-muted-foreground">{{ player.team }}</p>
                    </div>
                  </div>
                  <div class="flex items-center space-x-2">
                    <Badge variant="secondary">{{ player.votes }} votes</Badge>
                    <Button variant="outline" size="sm">View Profile</Button>
                  </div>
                </div>
              </div>
            </CardContent>
            <CardFooter>
              <Button variant="outline" class="w-full">View All Women's Categories</Button>
            </CardFooter>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  </AuthenticatedLayout>
</template>
