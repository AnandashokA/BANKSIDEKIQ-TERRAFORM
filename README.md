# BANKSIDEKIQ-TERRAFORM
step 1: spin up new server like banks-sidekiq server configurati
step 2: install rvm and rail 3.3.8 using following command. (Incase doubt visit this site https://rvm.io/rvm/install)
        a. gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
        b. \curl -sSL https://get.rvm.io | bash -s stable --ruby=3.3.8

step 3: export the variable in .bashrc
        export PATH="$PATH:$HOME/.rvm/bin"
        source ~/.rvm/scripts/rvm
        cd /var/www/apps/banks/current
        export RAILS_ENV=production
        export ENV_PATH=contact

step 4: craete directory in /var
        cd /var
        sudo mkdir www/
        sudo mkdir apps/
        sudo mkdir banks/
        sudo chown -R ubuntu:ubuntu /var/www/

step 5: Add sidekiq service file in sysmd
        sudo vi /etc/systemd/system/sidekiq.service

        Add into the service file:
                [Unit]
                Description=Sidekiq for Bank Rails App
                After=network.target
                
                [Service]
                Type=simple
                User=ubuntu
                Group=ubuntu
                WorkingDirectory=/var/www/apps/banks/current
                Environment=RAILS_ENV=production
                Environment=ENV_PATH=contact
                ExecStart=/bin/bash -lc 'bundle exec sidekiq -e production -c 5'
                ExecStop=/bin/kill -TERM $MAINPID
                
                Restart=alway
                RestartSec=5
                TimeoutStopSec=30
                
                [Install]
                WantedBy=multi-user.target

step 6: Add ssh key into new server, copy from banks-sidekiq server
        cat ~/.ssh/authorized_keys - paste the key into new server
        cp id_rsa and id_rsa.pub to new server using scp
