FROM ubuntu:22.04

# パッケージのインストール
RUN apt-get update && apt-get install -y \
    apache2 \
    php8.2 \
    php8.2-cli \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-xml \
    php8.2-mbstring \
    php8.2-zip \
    php8.2-curl \
    systemctl

# Apacheの自動起動を無効化
RUN systemctl disable apache2

# ドキュメントルートの設定
WORKDIR /var/www/html

# ソースコードのコピー
COPY . .

# Composerのインストール
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# 依存関係のインストール
RUN composer install

# Apacheの起動コマンドを削除
CMD ["apache2ctl", "-D", "FOREGROUND"]
