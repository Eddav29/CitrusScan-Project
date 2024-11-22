Eddav29: @workspace buatkan Readme nya sekalian tambahkan dokumentasi api di dalamnya

Workspace: I'll help you create a comprehensive 

README.md

 file with API documentation. Here's a suggested structure:

```markdown
# Citrus Disease Detection API

A Laravel-based REST API for citrus disease detection and management.

## Table of Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [API Documentation](#api-documentation)
  - [Authentication](#authentication)
  - [User Management](#user-management)

## Requirements

- PHP >= 8.2
- Composer
- Laravel 11.x
- MySQL/SQLite

## Installation

1. Clone the repository:
```sh
git clone <repository-url>
cd <project-directory>
```

2. Install dependencies:
```sh
composer install
```

3. Set up environment:
```sh
cp .env.example .env
php artisan key:generate
```

4. Run migrations:
```sh
php artisan migrate
```

5. Seed database:
```sh
php artisan db:seed
```

## Configuration

1. Configure your database in 

.env

:
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your_database
DB_USERNAME=your_username
DB_PASSWORD=your_password
```

2. Configure Google OAuth (if using social login):
```env
GOOGLE_CLIENT_ID=your_client_id
GOOGLE_CLIENT_SECRET=your_client_secret
GOOGLE_REDIRECT_URL=your_redirect_url
```

## API Documentation

### Authentication

#### Register User
```
POST /api/register

Request:
{
    "name": "string",
    "email": "string",
    "password": "string",
    "password_confirmation": "string"
}

Response:
{
    "access_token": "string",
    "token_type": "Bearer",
    "user": {
        "user_id": "uuid",
        "name": "string",
        "email": "string"
    }
}
```

#### Login
```
POST /api/login

Request:
{
    "email": "string",
    "password": "string"
}

Response:
{
    "access_token": "string",
    "token_type": "Bearer",
    "user": {
        "user_id": "uuid",
        "name": "string",
        "email": "string"
    }
}
```

#### Logout
```
POST /api/logout

Headers:
Authorization: Bearer <token>

Response:
{
    "message": "Logout successful"
}
```

### User Management

#### Get Profile
```
GET /api/profile

Headers:
Authorization: Bearer <token>

Response:
{
    "user": {
        "user_id": "uuid",
        "name": "string",
        "email": "string"
    }
}
```

#### Update Profile
```
PUT /api/profile

Headers:
Authorization: Bearer <token>

Request:
{
    "name": "string", // optional
    "email": "string" // optional
}

Response:
{
    "user": {
        "user_id": "uuid",
        "name": "string",
        "email": "string"
    }
}
```

#### Update Password
```
PUT /api/update-password

Headers:
Authorization: Bearer <token>

Request:
{
    "old_password": "string",
    "new_password": "string",
    "new_password_confirmation": "string"
}

Response:
{
    "message": "Password updated successfully"
}
```

## Error Responses

The API returns standard HTTP status codes:

- 200: Success
- 201: Created
- 400: Bad Request
- 401: Unauthorized
- 403: Forbidden
- 404: Not Found
- 422: Validation Error
- 500: Server Error

Error response format:
```json
{
    "error": "Error message"
}
```

For validation errors:
```json
{
    "message": "The given data was invalid.",
    "errors": {
        "field": [
            "Error message"
        ]
    }
}
```
```

This README provides comprehensive documentation for your API, including installation instructions, configuration details, and API endpoints. Feel free to modify it according to your specific needs.This README provides comprehensive documentation for your API, including installation instructions, configuration details, and API endpoints. Feel free to modify it according to your specific needs.