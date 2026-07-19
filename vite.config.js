import { defineConfig, loadEnv } from 'vite';
import laravel from 'laravel-vite-plugin';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig(({ mode }) => {
    // Memuat variabel dari file .env
    const env = loadEnv(mode, process.cwd(), '');

    return {
        plugins: [
            laravel({
                input: ['resources/css/app.css', 'resources/js/app.js'],
                refresh: true,
            }),
            tailwindcss(),
        ],

        // ...(env.APP_ENV === 'local' && {
        //     server: {
        //         host: '0.0.0.0',
        //         port: 5173,
        //         hmr: {
        //             host: 'localhost',
        //         },
        //         watch: {
        //             usePolling: true,
        //         },
        //     }
        // })
    };
});