// Based on this series
// https://alicia-paz.medium.com/make-your-rails-app-work-offline-part-2-caching-assets-and-adding-an-offline-fallback-334729ade904

importScripts(
  "https://storage.googleapis.com/workbox-cdn/releases/6.4.1/workbox-sw.js"
);

// We first define the strategies we will use and the registerRoute function
const { CacheFirst, NetworkFirst } = workbox.strategies;
const { registerRoute } = workbox.routing;
// If we have critical pages that won't be changing very often, it's a good idea to use cache first with them
// registerRoute(
//   ({ url }) => url.pathname.startsWith('/'),
//   new CacheFirst({
//     cacheName: 'documents',
//   })
// )

// For every other page we use network first to ensure the most up-to-date resources
registerRoute(
  ({ request, url }) => request.destination === "document" ||
    request.destination === "",
  new NetworkFirst({
    cacheName: 'documents',
  })
)

// For assets (scripts and images), we use cache first
registerRoute(
  ({ request }) => request.destination === "script" ||
    request.destination === "style",
  new CacheFirst({
    cacheName: 'assets-styles-and-scripts',
  })
)
registerRoute(
  ({ request }) => request.destination === "image",
  new CacheFirst({
    cacheName: 'assets-images',
  })
)


const {warmStrategyCache} = workbox.recipes;
const {setCatchHandler} = workbox.routing;
const strategy = new CacheFirst();
const urls = ['/offline.html'];
// Warm the runtime cache with a list of asset URLs
warmStrategyCache({urls, strategy});
// Trigger a 'catch' handler when any of the other routes fail to generate a response
setCatchHandler(async ({event}) => {
  switch (event.request.destination) {
    case 'document':
      return strategy.handle({event, request: urls[0]});
    default:
     return Response.error();
   }
});