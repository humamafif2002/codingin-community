# 1. Gunakan image PHP 8.3 FPM versi Alpine (Jauh lebih ringan)
FROM php:8.3-fpm-alpine

# 2. Install system dependencies menggunakan 'apk' (bukan apt-get)
# Catatan: libonig-dev di Ubuntu/Debian bernama oniguruma-dev di Alpine
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev \
    zip \
    unzip

# 3. Install PHP extensions yang dibutuhkan Laravel
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# 4. Dapatkan Composer terbaru
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 5. Set working directory
WORKDIR /var/www

# 6. Copy seluruh file project ke dalam container
COPY . /var/www

# 7. Atur permission untuk folder storage dan bootstrap/cache
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 775 /var/www/bootstrap/cache

# 8. Buka port 9000 dan jalankan PHP-FPM
EXPOSE 9000
CMD ["php-fpm"]