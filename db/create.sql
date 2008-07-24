drop table if exists user;
create table user (
    id int not null auto_increment,
    username varchar(32) not null unique,
    password varchar(40) not null,
    status enum('wait', 'enabled', 'disabled') not null,
    updated_at timestamp not null,
    created_at datetime not null,
    primary key(id)
) engine=innodb default charset=utf8;

drop table if exists role;
create table role (
    id int not null auto_increment,
    rolename varchar(32) not null,
    primary key (id)
) engine=innodb default charset=utf8;

drop table if exists user_role;
create table user_role (
    id int not null auto_increment,
    user_id int not null,
    role_id int not null,
    primary key (id),
    constraint fk_user_id foreign key (user_id) references user (id),
    constraint fk_role_id foreign key (role_id) references role (id)
) engine=innodb default charset=utf8;

drop table if exists category;
create table category (
    id int not null auto_increment,
    name varchar(200) not null unique,
    updated_at timestamp not null,
    created_at datetime not null,
    primary key (id)
) engine=innodb default charset=utf8;

drop table if exists thread;
create table thread (
    id int not null auto_increment,
    category_id int not null,
    title varchar(200) not null,
    description text not null,
    updated_at timestamp not null,
    created_at datetime not null,
    primary key (id),
    constraint fk_category_id foreign key (category_id) references category (id)
) engine=innodb default charset=utf8;

drop table if exists entry;
create table entry (
    id int not null auto_increment,
    thread_id int not null,
    name varchar(32) not null default '',
    trip char(10) not null default '',
    email varchar(200) not null default '',
    body text not null,
    clientid char(10) not null default '',
    updated_at timestamp not null,
    created_at datetime not null,
    primary key (id),
    constraint fk_thread_id foreign key (thread_id) references thread (id)
) engine=innodb default charset=utf8;

drop table if exists sessions;
create table sessions (
    id           char(72),
    session_data text,
    expires      int,
    primary key (id)
) engine=innodb default charset=utf8;

