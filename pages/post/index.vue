<script lang="ts" setup>
// compiler macro
definePageMeta({
  layout: 'page',
})
// useHead(() => ({
//   title: capitalize(t('pages.post.title')),
//   meta: [
//     {
//       name: 'description',
//       content: t('pages.post.description'),
//     },
//   ],
// }))
interface Product {
  id: number
  name: string
  description: string
  price: number
}

const config = useRuntimeConfig()
const apiUrl = config.public.apiUrl
// const { data: products } = await useFetch(apiUrl + '/products/')
const { data, error } = useAsyncData(
  "products",
  async () => {
    let response: Product[];
    try {
      response = await $fetch(apiUrl + '/products/',);

    } catch (e) {
      response = []
      console.log(e)
    }
    return response;
  }
);

</script>

<template>
  <PageWrapper>
    <PageHeader>
      <PageTitle text="Список продкутов" class="capitalize" />
    </PageHeader>
    <PageBody>
      <div class="w-full overflow-x-auto">
        <table class="w-full text-left border border-separate rounded border-slate-200" cellspacing="0">
          <tbody>
            <tr>
              <th scope="col" class="h-12 px-6 text-sm font-medium border-l first:border-l-0 stroke-slate-700 text-slate-700 bg-slate-100">Название</th>
              <th scope="col" class="h-12 px-6 text-sm font-medium border-l first:border-l-0 stroke-slate-700 text-slate-700 bg-slate-100">Цена</th>
            </tr>
            <tr v-for="product in data" :key="product.id" class="odd:bg-slate-50">
              <td class="h-12 px-6 text-sm transition duration-300 border-t border-l first:border-l-0 border-slate-200 stroke-slate-500 text-slate-500 ">
                {{ product.name }}
              </td>
              <td class="h-12 px-6 text-sm transition duration-300 border-t border-l first:border-l-0 border-slate-200 stroke-slate-500 text-slate-500 ">
                {{ product.price }}
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <!-- <ContentList v-slot="{ list }" path="/post">
        <PageSection v-for="article in list" :key="article._path">
          <div
            class="block hover:no-underline p-6 flex space-x-6 rounded border border-gray-900/10 dark:border-gray-50/[0.2]"
          >
            <div class="mt-1 text-slate-600 dark:text-gray-400 text-right">
              <div>{{ article.date }}</div>
              <Anchor
                class="text-sm flex items-center justify-end space-x-1"
                :href="`https://www.github.com/${article.author}`"
              >
                <icon-mdi:github-face class="text-xs" />
                <span>{{ article.author }}</span>
              </Anchor>
            </div>
            <div class="flex flex-col">
              <div
                class="text-xl font-semibold text-slate-800 dark:text-gray-50"
              >
                {{ article.title }}
              </div>
              <div class="text-slate-700 dark:text-gray-300 mb-1">
                {{ article.description }}
              </div>
              <div class="flex">
                <Anchor
                  class="text-sm flex space-x-1 items-center text-primary-500"
                  :to="article._path"
                >
                  <span>{{ $t('others.learn_more') }}</span>
                  <icon:ic:baseline-arrow-right-alt class="text-sm" />
                </Anchor>
              </div>
            </div>
          </div>
        </PageSection>
      </ContentList> -->
    </PageBody>
  </PageWrapper>
</template>
