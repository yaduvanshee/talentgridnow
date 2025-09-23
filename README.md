# URL Shortener API

A simple **URL Shortener Service** built with **Ruby on Rails**.  
This API allows users to shorten long URLs, track visits, and fetch the original URL.  
It includes **Swagger (Rswag) documentation** for easy testing and exploration.

---

## Features

- Shorten long URLs into simple slugs
- Redirect users from shortened URLs to the original URL
- Track visit counts for each shortened URL
- JSON API responses
- API documentation using **Swagger (Rswag)**

---

## 🛠️ Tech Stack

- **Ruby**: 3.x
- **Rails**: 7.x
- **Swagger Docs**: Rswag (`/api-docs`)

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/yaduvanshee/talentgridnow.git
cd talentgridnow
```

### 2. Install Dependencies

```bash
bundle install
```

### 3. Database Setup

```bash
rails db:create db:migrate
```

### 4. Run the Server

```bash
rails s
```

Visit the app at:  
 `http://localhost:3000`

---

## API Endpoints

### Create Short URL

**POST** `/api/v1/short_urls`

Request:

```json
{
  "short_url": {
    "original_url": "https://example.com"
  }
}
```

Response:

```json
{
  "id": 1,
  "original_url": "https://example.com",
  "short_url": "http://localhost:3000/abc123",
  "slug": "abc123",
  "visits_count": 0,
  "created_at": "2025-09-23T10:00:00Z"
}
```

---

## API Documentation (Swagger)

Rswag is integrated for interactive API docs.

1. Run the specs to generate Swagger file:

   ```bash
   rake rswag:specs:swaggerize
   ```

2. Start the server:

   ```bash
   rails s
   ```

3. Open Swagger UI in browser:  
   `http://localhost:3000/api-docs`

---

## Running Tests

```bash
bundle exec rspec
```

This will also generate/update Swagger docs under `swagger/v1/swagger.yaml`.

---

## Deployment

1. Push to GitHub
2. Deploy on your platform of choice (Heroku, Render, Railway, etc.)
3. Set `RAILS_ENV=production` and run:

```bash
rails db:migrate
```

---

## To Do

- [ ] Add URL expiration feature
- [ ] Add custom slug support
- [ ] Add user authentication
- [ ] add serializer
