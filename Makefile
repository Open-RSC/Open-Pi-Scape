include .env
MYSQL_DUMPS_DIR=./Backups

compile:
	sudo ant -f Required/server/build.xml compile_core
	sudo ant -f Required/server/build.xml compile_plugins
	sudo ant -f Required/client/build.xml compile

create-database-openrsc:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} -e "create database openrsc;"

create-database-cabbage:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} -e "create database cabbage;"

create-database-preservation:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} -e "create database preservation;"

create-database-openpk:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} -e "create database openpk;"

create-database-wk:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} -e "create database wk;"

create-database-dev:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} -e "create database dev;"

create-database-website:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} -e "create database website;"

import-database-openrsc:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} openrsc < Required/openrsc_game_server.sql
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} openrsc < Required/openrsc_game_players.sql

import-database-cabbage:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} cabbage < Required/cabbage_game_server.sql
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} cabbage < Required/cabbage_game_players.sql

import-database-preservation:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} preservation < Required/openrsc_game_server.sql
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} preservation < Required/openrsc_game_players.sql

import-database-openpk:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} openpk < Required/openpk_game_server.sql
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} openpk < Required/openpk_game_players.sql

import-database-wk:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} wk < Required/wk_game_server.sql
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} wk < Required/wk_game_players.sql

import-database-dev:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} dev < Required/openrsc_game_server.sql
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} dev < Required/openrsc_game_players.sql

upgrade-database-openrsc:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} openrsc < Required/openrsc_game_server.sql

upgrade-database-cabbage:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} cabbage < Required/cabbage_game_server.sql

upgrade-database-preservation:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} preservation < Required/openrsc_game_server.sql

upgrade-database-openpk:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} openpk < Required/openpk_game_server.sql

upgrade-database-wk:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} wk < Required/wk_game_server.sql

upgrade-database-dev:
	docker exec -i mysql mysql -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} dev < Required/openrsc_game_server.sql

backup-openrsc:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	sudo chmod -R 777 $(MYSQL_DUMPS_DIR)
	sudo chmod 644 etc/mariadb/innodb.cnf
	docker exec mysql mysqldump -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} openrsc --single-transaction --quick --lock-tables=false | sudo zip > $(MYSQL_DUMPS_DIR)/`date "+%Y%m%d-%H%M-%Z"`-openrsc.zip

backup-cabbage:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	sudo chmod -R 777 $(MYSQL_DUMPS_DIR)
	sudo chmod 644 etc/mariadb/innodb.cnf
	docker exec mysql mysqldump -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} cabbage --single-transaction --quick --lock-tables=false | sudo zip > $(MYSQL_DUMPS_DIR)/`date "+%Y%m%d-%H%M-%Z"`-cabbage.zip

backup-preservation:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	sudo chmod -R 777 $(MYSQL_DUMPS_DIR)
	sudo chmod 644 etc/mariadb/innodb.cnf
	docker exec mysql mysqldump -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} preservation --single-transaction --quick --lock-tables=false | sudo zip > $(MYSQL_DUMPS_DIR)/`date "+%Y%m%d-%H%M-%Z"`-preservation.zip

backup-openpk:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	sudo chmod -R 777 $(MYSQL_DUMPS_DIR)
	sudo chmod 644 etc/mariadb/innodb.cnf
	docker exec mysql mysqldump -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} openpk --single-transaction --quick --lock-tables=false | sudo zip > $(MYSQL_DUMPS_DIR)/`date "+%Y%m%d-%H%M-%Z"`-openpk.zip

backup-wk:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	sudo chmod -R 777 $(MYSQL_DUMPS_DIR)
	sudo chmod 644 etc/mariadb/innodb.cnf
	docker exec mysql mysqldump -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} wolfkingdom --single-transaction --quick --lock-tables=false | sudo zip > $(MYSQL_DUMPS_DIR)/`date "+%Y%m%d-%H%M-%Z"`-wolfkingdom.zip

backup-dev:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	sudo chmod -R 777 $(MYSQL_DUMPS_DIR)
	sudo chmod 644 etc/mariadb/innodb.cnf
	docker exec mysql mysqldump -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} dev --single-transaction --quick --lock-tables=false | sudo zip > $(MYSQL_DUMPS_DIR)/`date "+%Y%m%d-%H%M-%Z"`-dev.zip

backup-website:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	sudo chmod -R 777 $(MYSQL_DUMPS_DIR)
	sudo chmod 644 etc/mariadb/innodb.cnf
	docker exec mysql mysqldump -u${MARIADB_ROOT_USER} -p${MARIADB_ROOT_PASSWORD} website --single-transaction --quick --lock-tables=false | sudo zip > $(MYSQL_DUMPS_DIR)/`date "+%Y%m%d-%H%M-%Z"`-website.zip