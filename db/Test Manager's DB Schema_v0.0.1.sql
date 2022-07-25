CREATE TABLE `Permissions` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255) UNIQUE NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` tinytext NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT (0),
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now()),
  `content` varchar(255) NOT NULL
);

CREATE TABLE `Role_Permission` (
  `role_id` bigint,
  `permission_id` bigint,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `roles` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255) UNIQUE NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` tinytext NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT (0),
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now()),
  `content` varchar(255) NOT NULL
);

CREATE TABLE `users` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(255) UNIQUE NOT NULL,
  `mobile` varchar(15) UNIQUE NOT NULL,
  `email` varchar(255) UNIQUE NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255),
  `last_name` varchar(255) NOT NULL,
  `role_id` bigint,
  `last_login` timestamp NOT NULL,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `Projects` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `owner_id` bigint,
  `active` tinyint(1) NOT NULL DEFAULT (0),
  `track_progress` tinyint(1) NOT NULL DEFAULT (0),
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `Features` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `project_id` bigint,
  `assignee_id` bigint,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `Testcases` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `feature_id` bigint,
  `creator_id` bigint,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `Comments` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `testcase_id` bigint,
  `creator_id` bigint,
  `content` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE UNIQUE INDEX `uq_slug` ON `Permissions` (`slug`);

CREATE INDEX `idx_rp_role` ON `Role_Permission` (`role_id`);

CREATE INDEX `idx_rp_permission` ON `Role_Permission` (`permission_id`);

CREATE UNIQUE INDEX `uq_slug` ON `roles` (`slug`);

CREATE UNIQUE INDEX `uq_mobile` ON `users` (`mobile`);

CREATE UNIQUE INDEX `uq_email` ON `users` (`email`);

CREATE INDEX `idx_user_role` ON `users` (`id`);

ALTER TABLE `Role_Permission` ADD FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

ALTER TABLE `Role_Permission` ADD FOREIGN KEY (`permission_id`) REFERENCES `Permissions` (`id`);

ALTER TABLE `users` ADD FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

ALTER TABLE `Projects` ADD FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`);

ALTER TABLE `Features` ADD FOREIGN KEY (`project_id`) REFERENCES `Projects` (`id`);

ALTER TABLE `Features` ADD FOREIGN KEY (`assignee_id`) REFERENCES `users` (`id`);

ALTER TABLE `Testcases` ADD FOREIGN KEY (`feature_id`) REFERENCES `Features` (`id`);

ALTER TABLE `Testcases` ADD FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`);

ALTER TABLE `Comments` ADD FOREIGN KEY (`testcase_id`) REFERENCES `Testcases` (`id`);

ALTER TABLE `Comments` ADD FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`);
