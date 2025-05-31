SET character_set_client = utf8mb4;
SET character_set_connection = utf8mb4;
SET character_set_results = utf8mb4;

-- 创建数据库
create database Article_Manager;

-- 使用数据库
use Article_Manager;

-- 用户表
create table user (
                      id int unsigned primary key auto_increment comment 'ID',
                      username varchar(20) not null unique comment '用户名',
                      password varchar(32)  comment '密码',
                      nickname varchar(10)  default '' comment '昵称',
                      email varchar(128) default '' comment '邮箱',
                      user_pic varchar(128) default '' comment '头像',
                      create_time datetime not null comment '创建时间',
                      update_time datetime not null comment '修改时间'
) comment '用户表';

-- 分类表
create table category(
    first_category_name varchar(32) comment '一级分类名称',
    second_category_name varchar(32) comment '二级分类名称',
    third_category_name varchar(32) comment '三级分类名称',

                         id int unsigned primary key auto_increment comment 'ID',
                         create_user int unsigned not null comment '创建人ID',
                         create_time datetime not null comment '创建时间',
                         update_time datetime not null comment '修改时间',
                         constraint fk_category_user foreign key (create_user) references user(id) -- 外键约束
);

-- 文章表
create table article(
                        id int unsigned primary key auto_increment comment 'ID',
                        title varchar(100) not null comment '文章标题',
                        content varchar(10000) not null comment '文章内容',
                        state varchar(3) default '草稿' comment '文章状态: 只能是[已发布] 或者 [草稿]',
                        category_id int unsigned comment '文章分类ID',
                        create_user int unsigned not null comment '创建人ID',
                        create_time datetime not null comment '创建时间',
                        update_time datetime not null comment '修改时间',
                        constraint fk_article_category foreign key (category_id) references category(id),-- 外键约束
                        constraint fk_article_user foreign key (create_user) references user(id) -- 外键约束
);

create table comment (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '评论ID',
    article_id INT UNSIGNED NOT NULL COMMENT '对应的文章ID',
    content TEXT NOT NULL COMMENT '评论内容',
    create_user INT UNSIGNED NOT NULL COMMENT '评论人ID',
    create_time DATETIME NOT NULL COMMENT '创建时间',
    update_time DATETIME NOT NULL COMMENT '修改时间',
    CONSTRAINT fk_comment_article FOREIGN KEY (article_id) REFERENCES article(id),
    CONSTRAINT fk_comment_user FOREIGN KEY (create_user) REFERENCES user(id)
) CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT='评论表';

ALTER TABLE article
ADD COLUMN cover_img VARCHAR(255) DEFAULT '' COMMENT '封面图地址';