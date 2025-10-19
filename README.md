# Extreme Fitness Centre - Backend API

**Gym Name:** Extreme Fitness Centre
**Slogan:** Stronger Every Day
**Theme Color:** Blue (#0066CC)

Ruby on Rails API backend for the Extreme Fitness Centre gym management system.

## Ruby Version
- Ruby 3.x
- Rails 7.2.2

## System Dependencies
- PostgreSQL 12+
- Ruby 3.x
- Bundler

## Configuration

### Environment Variables
Create a `.env` file in the root directory:
```
FRONTEND_URL=http://localhost:3001
DATABASE_URL=postgresql://localhost/extreme_fitness_development
```

### Gym Configuration
The gym branding and configuration is stored in `config/initializers/gym_config.rb`:
- Brand name: Extreme Fitness Centre
- Slogan: Stronger Every Day
- Theme colors: Blue color scheme
- Contact information
- Business hours

## Database Setup

```bash
# Create the database
rails db:create

# Run migrations
rails db:migrate

# Seed the database with initial data
rails db:seed
```

## Running the Application

```bash
# Install dependencies
bundle install

# Start the Rails server
rails server
```

The API will be available at `http://localhost:3000`

## API Endpoints

### Configuration Endpoints
- `GET /api/v1/config` - Get all gym configuration
- `GET /api/v1/config/brand` - Get brand information
- `GET /api/v1/config/theme` - Get theme colors

### Future Endpoints (To Be Implemented)
- `/api/v1/members` - Member management
- `/api/v1/trainers` - Trainer profiles
- `/api/v1/classes` - Class scheduling
- `/api/v1/memberships` - Membership plans

## CORS Configuration
CORS is configured to accept requests from the React frontend at `http://localhost:3001` (configurable via `FRONTEND_URL` environment variable).

## Testing

```bash
# Run the test suite
rails test
```

## Deployment
- Ensure all environment variables are set
- Run migrations on production database
- Configure production CORS settings

## Features
- RESTful API design
- PostgreSQL database
- CORS enabled for frontend integration
- Modular configuration system
- Health check endpoint at `/up`
