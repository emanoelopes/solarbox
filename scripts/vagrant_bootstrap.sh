#!/bin/sh
# Original script on https://github.com/orendon/vagrant-rails

# enable console colors
sed -i '1iforce_color_prompt=yes' ~/.bashrc

# disable docs during gem install
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

# essenciais e dependências
sudo apt-get -y update
sudo apt-get install -y git-core curl autoconf build-essential libssl-dev libyaml-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev zlib1g zlib1g-dev libcurl4-openssl-dev wget python-software-properties libpq-dev

# SQLite, Git and Node.js
sudo apt-get install -y libsqlite3-dev git libpq-dev nodejs

# Configuração do GIT
git config --global user.name "solar_vm"
git config --global user.email "solarvm@git.com"

# Clonando o projeto SOLAR
git clone https://github.com/wwagner33/solar.git

# Instalar o RVM
sudo apt-get install -y libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc

# Instalar e configurar o Postgresql
sudo apt-get install -y postgresql postgresql-contrib
sudo sudo -u postgres psql -1 -c "CREATE USER solar WITH PASSWORD '12345';"
sudo sudo -u postgres psql -1 -c "ALTER USER solar SUPERUSER;"

# Instalar o Ruby 2.1.0
rvm install 2.1.0

# Configurar o rvm para usar a versão 2.1.0 
cd solar
rvm --default use 2.1.0

# Passos finais
sudo apt install -y ruby-bundler
gem install bundler
bundle install
cd config
for file in *.yml; do cp "$file" "${file/.yml}"; done

# Criar os bancos de desenvolvimento e teste
rake db:create:all

# Migrar os modelos para o banco
rake db:migrate

# Alimentar o banco com dados padrões
rake db:seed

