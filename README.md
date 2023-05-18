# Blog

This is a Ruby on Rails application for a blogging website where registered users can create posts and leave comments.

## Features

- Homepage with paginated list of posts.
- Filter posts by "All" and "My Posts".
- Post creation, editing, and deletion with a title, description, and optional image attachment.
- Admin panel with user management and a list of all posts.
- Test coverage using RSpec.

## Functionality

In addition to the specified requirements, this application also includes the following functionality:

- User authentication using Devise, allowing users to sign up, sign in, and manage their account settings.
- User roles and permissions, where admins have full access to user management and post administration, while regular users can only create, edit, and delete their own posts.
- Responsive and user-friendly interface using a modern design with Bootstrap

## Technical Requirements

- Ruby version: 3.1.2
- Rails version: 7.0.3
- Database: PostgreSQL
- Image handling: Active Storage
- Admin panel: Active Admin with Arctic Admin theme
- User authentication: Devise
