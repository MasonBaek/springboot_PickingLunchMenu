/* choicemenu */
CREATE TABLE `choicemenu` (
                              `choicemenuseq` int(11) NOT NULL AUTO_INCREMENT,
                              `menu_seq` int(11) NOT NULL,
                              `date_seq` int(11) DEFAULT NULL,
                              `date` varchar(10) COLLATE utf8_bin DEFAULT NULL,
                              `office` varchar(45) COLLATE utf8_bin DEFAULT NULL,
                              `id` varchar(45) COLLATE utf8_bin DEFAULT NULL,
                              `store` varchar(45) COLLATE utf8_bin DEFAULT NULL,
                              `menu` varchar(45) COLLATE utf8_bin DEFAULT NULL,
                              `menu_option` varchar(200) COLLATE utf8_bin DEFAULT NULL,
                              `addmenu` varchar(200) COLLATE utf8_bin DEFAULT NULL,
                              PRIMARY KEY (`choicemenuseq`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/* choicemenu */
CREATE TABLE `choicestore` (
                               `store_seq` int(11) NOT NULL AUTO_INCREMENT,
                               `date_seq` int(11) NOT NULL,
                               `date` varchar(10) COLLATE utf8_bin DEFAULT NULL,
                               `id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
                               `storePicked` varchar(45) COLLATE utf8_bin DEFAULT NULL,
                               `office` varchar(45) COLLATE utf8_bin DEFAULT NULL,
                               PRIMARY KEY (`store_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/* dailystore */
CREATE TABLE `dailystore` (
                              `daily_seq` int(11) NOT NULL AUTO_INCREMENT,
                              `date` varchar(10) COLLATE utf8_bin DEFAULT NULL,
                              `office` varchar(10) COLLATE utf8_bin DEFAULT NULL,
                              `store` varchar(50) COLLATE utf8_bin DEFAULT NULL,
                              PRIMARY KEY (`daily_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/* member */
CREATE TABLE `member` (
                          `user_seq` int(11) NOT NULL AUTO_INCREMENT,
                          `id` varchar(20) COLLATE utf8_bin NOT NULL,
                          PRIMARY KEY (`user_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/* menu */
CREATE TABLE `menu` (
                        `menu_seq` int(11) NOT NULL AUTO_INCREMENT,
                        `storeNum` int(11) DEFAULT NULL,
                        `store` varchar(45) COLLATE utf8_bin DEFAULT NULL,
                        `menu` varchar(45) COLLATE utf8_bin DEFAULT NULL,
                        `price` int(11) DEFAULT NULL,
                        `amount` varchar(200) COLLATE utf8_bin DEFAULT NULL,
                        `popular` int(11) DEFAULT NULL,
                        PRIMARY KEY (`menu_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=570 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/* store */
CREATE TABLE `store` (
                         `store_seq` int(11) NOT NULL AUTO_INCREMENT,
                         `store` varchar(45) COLLATE utf8_bin NOT NULL,
                         `minimum_price` varchar(45) COLLATE utf8_bin DEFAULT NULL,
                         `delivery_tip` varchar(45) COLLATE utf8_bin DEFAULT NULL,
                         `delivery_detail` varchar(200) COLLATE utf8_bin DEFAULT NULL,
                         PRIMARY KEY (`store_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
